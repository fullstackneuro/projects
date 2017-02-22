function s_cue_make_wmmask_fsseg_vlpfc
%
% This script makes the white-matter mask from freesurfer segmentation
% used to track the connectomes in Pestilli et al., LIFE paper.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

% Get the base directory for the data

matProcDir = '/media/lcne/matproc';
%matProcDir = '/media/storg/matproc';

subjects = {'zl150930'};

%{
'am160914','kn160918','ld160918','li160927'
'ac160415','jh160702','jr160507','mp160511','ps160508'
'ab071412','al151016','bb160402','bk032113','bp160213','cs160214','dc050213', ...
            'ds080712','en062813','gr051513','hm062513','jc160320','jc160321','jg151121', ...
            'jl071912','jt062413','jv151030','jw072512','jw160316','lc052213', ...
            'mk021913','ml061013','np072412','pk160319','ps151001','pw060713','rb160407', ...
            'rf160313','sp061313','wb071812','zl150930'
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
    invals = [16 41 49 50 51 52 58 60 12106 12113 12115 12116 12117 12118 12124 12139 12148 12149 12155 12163 12164 12165];
    %lh 16 2 10 11 12 13 26 28 11107 11113 11154 11116 11117 11118 11124 11139 11148 11149 11155 11163 11164 11165
    %rh 16 41 49 50 51 52 58 60 12106 12113 12115 12116 12117 12118 12124 12139 12148 12149 12155 12163 12164 12165
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
