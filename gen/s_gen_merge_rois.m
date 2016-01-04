function s_merge_rois
% merges two mat rois, saves as single mat roi

datapath = '/media/storg/matproc';

subjects = {'yw083014_7mm_1'};

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1    = dtiReadRoi(fullfile(roiPath,'rh_antins_a2009s.mat'));
    roi2    = dtiReadRoi(fullfile(roiPath,'rh_shortins_a2009s.mat'));
    newRoiName = fullfile(roiPath,'rh_antshortins.mat');
    newRoi     = dtiMergeROIs(roi1,roi2);
    dtiWriteRoi(newRoi, newRoiName)
end