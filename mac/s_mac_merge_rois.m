function s_mac_merge_rois
% merges two mat rois, saves as single mat roi
%

datapath = '/media/storg/matproc';

subjects = {'mac03218_1'};
    %,'mac03218_2','mac12826_1','mac12826_2', ...
     %       'mac18000_1','mac18000_2'};
%,'mac18622_1','mac18622_2'

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1    = dtiReadRoi(fullfile(roiPath,'rh_wmsegthal_fd.mat'));
    roi2    = dtiReadRoi(fullfile(roiPath,'rh_ventraldc_aseg.mat'));
    newRoiName = fullfile(roiPath,'rh_wmsegthalventdc.mat');
    newRoi     = dtiMergeROIs(roi1,roi2);
    dtiWriteRoi(newRoi, newRoiName)
end