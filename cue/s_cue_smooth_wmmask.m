function s_cue_smooth_wmmask
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014
datapath = '/media/storg/matproc';
subjects = {'aa151010','al151016','dw151003','ps151001','zl150930'};

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = fullfile(roiPath,'rh_wmmask_fs.mat');
    oldRoiPath = fullfile(roi);
    outRoi = [roiPath '/rh_wmmask_fs_fd.mat'];
    
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