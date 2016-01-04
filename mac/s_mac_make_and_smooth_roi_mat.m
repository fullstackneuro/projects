function s_mac_make_and_smooth_roi_mat
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/storg/matproc';

subjects = {'mac03218_1'};
    %,'mac03218_2','mac12826_1','mac12826_2', ...
     %       'mac18000_1','mac18000_2'};
%,'mac18622_1','mac18622_2'

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = dir(fullfile(roiPath,'rh_wmsegthalventdcinfins.mat'));
    %lh_antshortins, rh_antshortins
    %lh_nacc_aseg, rh_nacc_aseg
    %lh_wmmask_fs, rh_wmmask_fs
    oldRoi = roi.name;
    oldRoiPath = fullfile(roiPath, oldRoi);
    outRoi = [roiPath '/rh_wmsegthalventdcinfins_fd.mat'];
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