function s_duke_make_and_smooth_roi_mat
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/cylon/matproc';

subjects = {'dnd029', 'dnd039', 'dnd060', 'dnd069', 'dnd070', 'dnd092', 'dnd097', 'dnd099', 'dnd109', 'dnd114', 'dnd121'};
        
%dnd040 no dwi
rois = {'rh_wmmask_fs', 'lh_wmmask_fs'}
        
%{
  {'rh_amyg_aseg','lh_amyg_aseg', ...  
        'rh_nacc_aseg','lh_nacc_aseg', ...
        'rh_frontorb_a2009s','lh_frontorb_a2009s', ...
        'rh_frontinfang_a2009s','lh_frontinfang_a2009s', ...
        'rh_antins_a2009s','lh_antins_a2009s', ...
        'rh_shortins_a2009s','lh_shortins_a2009s', ...
        'rh_latorb_a2009s','lh_latorb_a2009s', ...
        'rh_wmmask_fs','lh_wmmask_fs', ...
        'rh_ventraldc_aseg','lh_ventraldc_aseg', ...
        'rh_supfront_a2009s','lh_supfront_a2009s', ...
        'rh_frontmidlat_a2009s','lh_frontmidlat_a2009s'};      
%}
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