function s_els_merge_save_rois
% merges two mat rois, saves as single mat roi
%
%
%

datapath = '/media/storg/matproc';

subjects = {'els006','els009','els012','els034','els040','els058','els059', ...
            'els060','els061','els062','els075','els086','els089','els090', ...
            'els092','els095','els097','els099','els100'};

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1    = dtiReadRoi(fullfile(roiPath,'lh_shortins_a2009s.mat'));
    roi2    = dtiReadRoi(fullfile(roiPath,'lh_antins_a2009s.mat'));
    newRoiName = fullfile(roiPath,'lh_antshortins.mat');
    newRoi     = dtiMergeROIs(roi1,roi2);
    dtiWriteRoi(newRoi, newRoiName)
end
