function s_plasticity_merge_save_rois
% merges two mat rois, saves as single mat roi
%
%
%

datapath = '/media/storg/matproc';
subjects = {'ml082214_hardi1','ml082214_hardi2','ml082214_hardi3'};
        
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1 = dtiReadRoi(fullfile(roiPath,'lh_wmmask_fs.mat'));
    roi2 = dtiReadRoi(fullfile(roiPath,'lh_mpfc_4mm.mat'));
    newRoiName = fullfile(roiPath,'lh_wmmask_mpfc_merge.mat');
    newRoi = dtiMergeROIs(roi1,roi2);
    dtiWriteRoi(newRoi, newRoiName)
end