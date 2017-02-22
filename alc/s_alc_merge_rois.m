function s_alc_merge_rois
% merges two mat rois, saves as single mat roi

datapath = '/media/lcne/matproc';

subjects = {'alc289','alc290','alc291','alc293','alc294'};

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1    = dtiReadRoi(fullfile(roiPath,'rh_antins_a2009s_fd.mat'));
    roi2    = dtiReadRoi(fullfile(roiPath,'rh_shortins_a2009s_fd.mat'));
    newRoiName = fullfile(roiPath,'rh_antshortins_fd.mat');
    newRoi     = dtiMergeROIs(roi1,roi2);
    dtiWriteRoi(newRoi, newRoiName)
end