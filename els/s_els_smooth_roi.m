function s_els_smooth_roi
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/storg/matproc';

subjects = {'els103','els106','els107','els111','els112','els113','els114', ...
            'els115','els116','els117','els118','els121','els122','els124', ...
            'els125','els127','els130','els132','els134','els136','els137', ...
            'els139','els140','els145','els147','els148','els149','els151', ...
            'els154','els155','els156','els157','els162','els163','els164', ...
            'els165','els166','els171'};
%{
'els006','els009','els012','els034','els040','els058','els059', ...
            'els060','els061','els062','els075','els086','els089','els090', ...
            'els092','els095','els097','els099','els100'};
%}
        
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = dir(fullfile(roiPath,'rh_nacc_aseg.mat'));
    oldRoi = roi.name;
    oldRoiPath = fullfile(roiPath, oldRoi);
    outRoi = [roiPath '/rh_nacc_aseg_fd.mat'];
    smoothKernel = 0; % size of the 3D smoothing Kernel in mm
    %operations   = ['fillholes', 'dilate', 'removesat']; 
    operations   = [1, 1, 0]; 

    % fillholes = fill any hole in the ROI. Pass '' to not apply this
    %             operation
    % dilate     = expand the ROI in 3D. Pass '' to not apply this
    %             operation
    % removesat  = remove any voxel disconnected from the rest of the voxels. 
    %              Pass '' to not apply this operation
    
    oldRoiLoad = dtiReadRoi(oldRoiPath);
    newRoi = dtiRoiClean(oldRoiLoad, smoothKernel, operations);
    dtiWriteRoi(newRoi, outRoi);
end