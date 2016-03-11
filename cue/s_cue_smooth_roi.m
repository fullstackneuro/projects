function s_cue_smooth_roi
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/lcne/matproc';

subjects = {'al151016'};

%{'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
%            'jv151030','ps151001','si151120','sr151031','tf151127','tm161017','vm151031', ...
%            'wr151127','zl150930'};

rois = {'rh_frontorb_a2009s', ...
        'rh_antshortins', ...
        'rh_antins_a2009s', ...
        'rh_shortins_a2009s', ...
        'lh_frontorb_a2009s', ...
        'lh_antshortins', ...
        'lh_antins_a2009s', ...
        'lh_shortins_a2009s'};
        
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    for iroi = 1:length(rois)
        roi = fullfile(roiPath, [rois{iroi} '.mat']);
        outRoi = fullfile(roiPath, [rois{iroi} '_fdr.mat']);
        smoothKernel = 0; % size of the 3D smoothing Kernel in mm
        %operations   = ['fillholes', 'dilate', 'removesat']; 
        operations   = [1, 1, 1]; 

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