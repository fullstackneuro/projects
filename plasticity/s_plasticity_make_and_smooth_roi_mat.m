function s_plasticity_make_and_smooth_roi_mat
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014
datapath = '/media/storg/matproc';
subjects = {'ad082014'};

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj});
    roi = dir(fullfile(roiPath,'rh_nacc_aseg.mat'));
    oldRoi = roi.name;
    oldRoiPath = fullfile(roiPath, oldRoi);
    outRoi = [roiPath '/rh_nacc_aseg_ds.mat'];
    smoothKernel = 0; % size of the 3D smoothing Kernel in mm
    %operations   = ['fillholes', 'dilate', 'removesat']; 
    operations   = ['', 1, 1]; 

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