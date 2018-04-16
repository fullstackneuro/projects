function s_mac_make_and_smooth_roi_mat
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/storg/matproc';

subjects = {'mac03218_1','mac03218_2','mac12826_1','mac12826_2', ...
            'mac18000_1','mac18000_2','mac18622_1'};
% ,'mac18622_2' dtiInit

rois = {'rh_nacc_aseg','lh_nacc_aseg', ...
        'rh_frontorb_a2009s','lh_frontorb_a2009s', ...
        'rh_frontinfang_a2009s','lh_frontinfang_a2009s', ...
        'rh_antins_a2009s','lh_antins_a2009s', ...
        'rh_shortins_a2009s','lh_shortins_a2009s', ...
        'rh_nacc_aseg','lh_nacc_aseg', ...
        'rh_latorb_a2009s','lh_latorb_a2009s', ...
        'rh_wmmask_fs','lh_wmmask_fs', ...
        'rh_supfront_a2009s','lh_supfront_a2009s', ...
        'rh_frontmidlat_a2009s','lh_frontmidlat_a2009s', ...
        'rh_ventraldc_aseg','lh_ventraldc_aseg'};
        
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    for iroi = 1:length(rois)
        roi = fullfile(roiPath, [rois{iroi} '.mat']);
        outRoi = fullfile(roiPath, [rois{iroi} '_fd.mat']);
        smoothKernel = 0; % size of the 3D smoothing Kernel in mm
        %operations   = ['fillholes', 'dilate', 'removesat']; 
        operations   = [1, 1, 0]; 

        % fillholes = fill any hole in the ROI. Pass '' to not apply this
        %             operation
        % dilate     = expand the ROI in 3D. Pass '' to not apply this
        %             operation
        % removesat  = remove any voxel disconnected from the rest of the voxels. 
        %              Pass '' to not apply this operation
    
        oldRoiLoad = dtiReadRoi(roi);
        newRoi = dtiRoiClean(oldRoiLoad, smoothKernel, operations);
        dtiWriteRoi(newRoi, outRoi);
    end
end