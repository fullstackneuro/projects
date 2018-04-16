function s_cue_make_wmmask_fsseg_dlpfc
%
% This script makes the white-matter mask from freesurfer segmentation
% used to track the connectomes in Pestilli et al., LIFE paper.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

% Get the base directory for the data

matProcDir = '/media/lcne/matproc';

subjects = {'as160317','as170730','cs170816','ds170728','nb160221','rc170730','rt170816'};
%{
cue done
'ag151024','ja151218','si151120','tf151127','wh160130','wr151127'

storg new
'kr030113','ps022013','tw062113','ec081912','jh042913','jo081312','lf052813', ...
'ra053013','sd040313','sh010813'};
lcne new
'at160601','cg160715','jf160703','lm160914','mr170621','nc160905','rf170610', ...
'rs160730','rv160413','tj160529','zm160627'
lcne done
'jb161004','rc161007','se161021','mr161024', ...
            'gm161101','hw161104','kd170115', ...
            'er170121','al170316','jd170330','jw170330', ...
            'tg170423','hp170601','rl170603','jc170501'
lcne
'am160914','cm160510','ja160416','ps160508','rt160420','yl160507','ac160415', ...
'ag151024','aa151010','al151016','dw151003','ie151020','ja151218', ...
'jh160702','jr160507','kn160918','ld160918','li160927','mp160511'
?'tm160117',
storg
'bb160402','bp160213','jc160320','jc160321','jg151121','jn160403','pk160319',
'ps151001','rb160407','rf160313','rp160205','si151120','sr151031','ss160205',
'tf151127','vm151031','wh160130','wr151127','zl150930','jw160316','as160129',
'cs160214','kl160122','jv151030',
%}
        
for isubj = 1:length(subjects)
    %subjectFolder = fullfile(baseDir, subjects{isubj});
    %fsMriFolder = fullfile(subjectFolder, 'mri');
    matRoiFolder = fullfile(matProcDir,subjects{isubj},'ROIs');
     
    wmMaskFile = fullfile(matRoiFolder,'rh_wmmask_fs.nii.gz'); 
    [~,wmMaskFileName,~] = fileparts(wmMaskFile);
    wmMaskFileName = wmMaskFileName(1:end-4); %strip .nii after .gz
    
    fs_wm = matchfiles(fullfile(matRoiFolder,'a2009seg2acpc.nii.gz'));
        
    eval(sprintf('!mri_convert  --out_orientation RAS %s %s', fs_wm{1}, wmMaskFile));
    wm = niftiRead(wmMaskFile);
    invals = [16 41 49 50 51 52 58 60 12106 12107 12108 12109 12110 12113 12115 12116 12117 12118 12124 12139 12148 12149 11154 12155 12163 12164 12165];
    %lh 16 2 10 11 12 13 26 28 11106 11107 11108 11109 11110 11113 11115 11116 11117 11118 11124 11139 11148 11149 11154 11155 11163 11164 11165
    %rh 16 41 49 50 51 52 58 60 12106 12107 12108 12109 12110 12113 12115 12116 12117 12118 12124 12139 12148 12149 11154 12155 12163 12164 12165
    origvals = unique(wm.data(:));
    fprintf('\n[%s] Converting voxels... ',mfilename);
    wmCounter=0;noWMCounter=0;
    for ii = 1:length(origvals);
        if any(origvals(ii) == invals)
            wm.data( wm.data == origvals(ii) ) = 1;
            wmCounter=wmCounter+1;
        else            
            wm.data( wm.data == origvals(ii) ) = 0;
            noWMCounter = noWMCounter + 1;
        end
    end
    fprintf('converted %i regions to White-matter (%i regions left outside of WM)\n\n',wmCounter,noWMCounter);
    niftiWrite(wm);
    
    %convert nifti to mat    
    im=niftiRead(wmMaskFile);
    wmMaskRoiMat = fullfile(matRoiFolder,[wmMaskFileName, '.mat']);
    
    %now we want to convert the image to a list of coordinates in acpc space
    %find roi index locations
    ndx=find(im.data);
    
    %convert to ijk coords 
    [I J K]=ind2sub(size(im.data),ndx);
    
    %convert to acpc coords
    acpcCoords=mrAnatXformCoords(im.qto_xyz, [I J K]);
    
    %now put these coordinates into the mrDiffusion roi structure
    roi=dtiNewRoi(wmMaskRoiMat,'r',acpcCoords);
    
    %save out the roi 
    dtiWriteRoi(roi,wmMaskRoiMat);
    fprintf('\nwriting file %s\n',fullfile(wmMaskRoiMat));
end
end
