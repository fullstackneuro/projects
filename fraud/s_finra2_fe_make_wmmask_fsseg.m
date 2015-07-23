function s_finra2_fe_make_wmmask_fsseg
%
% This script makes the white-matter mask from freesurfer segmentation
% used to track the connectomes in Pestilli et al., LIFE paper.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

% Get the base directory for the data
baseDir    = '/media/storg/fsproc/acpc';
matProcDir = '/media/storg/matproc';

subjects = {'cp011513','jw101812'};
%{
subjects   = {'ab071412','bc050913','bk032113','bk053012','ch101612', ...
              'cs050813','dc050213','dp092612','ds080712','ec081912', ...
              'en062813','fg092712','gr051513','hg101012','hm062513', ...
              'jh042913','jl071912','jo081312','jt062413','jw072512', ...
              'kr030113','lc052213','lf052813','lw061713','md072512', ...
              'mk021913','ml061013','mn052313','ms082112','na060213', ...
              'np072412','pf020113','pl061413','ps022013','pw060713', ...
              'pw061113','ra053013','rb073112','rb082212','sd040313', ...
              'sh010813','sl080912','sn061213','sp061313','tr101312', ...
              'tw062113','vv060313','wb071812'};
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
    %OLD invals  = [2 41 16 17 28 60 51 53 12 52 13 18 54 50 11 251 252 253 254 255 10 49 46 7];
    invals = [16 41 49 50 51 52 58 60 12118 12148 12164 12124];
    %lh 16 2 10 11 12 13 26 28 11118 11148 11164 11124
    %rh 16 41 49 50 51 52 58 60 12118 12148 12164 12124
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

end % Main function
