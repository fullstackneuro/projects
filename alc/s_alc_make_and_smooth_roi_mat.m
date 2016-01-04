function s_alc_make_and_smooth_roi_mat
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/storg/matproc';

subjects = {'alc283','alc286'};
%{
'alc187','alc219','alc220','alc245', ...
            'alc257','alc262','alc269','alc274', ...
            'alc275','alc276','alc277','alc278', ...
            'alc280','alc281','alc282','alc284'
%}

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = dir(fullfile(roiPath,'rh_nacc_aseg.mat'));
    %lh_antshortins, rh_antshortins
    %lh_nacc_aseg, rh_nacc_aseg
    %lh_wmmask_fs, rh_wmmask_fs
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