function s_plasticity_make_and_smooth_roi_mat
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014
datapath = '/media/storg/matproc';
subjects = {'lt081615_1','lt081615_2'};
%{
'mm080915_1','mm080915_2','nb081015_1','nb081015_2'
'ad082014','ad082014_2','yw083014','yw083014_2','hm082514','hm082514_2','ml082214','ml082214_2', ...
'ld080115_1','ld080115_2','lp080215_1','lp080215_2'};
%}
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