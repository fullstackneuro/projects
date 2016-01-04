function s_plasticity_merge_save_mpfc_wmmask
% merges two mat rois, saves as single mat roi
%

datapath = '/media/storg/matproc';
subjects = {'lt081615_1','lt081615_2','hm082514_2','ml082214','ml082214_2', ...
            'ld080115_1','ld080115_2','lp080215_1','lp080215_2'};
        
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1 = dtiReadRoi(fullfile(roiPath,'rh_wmmask_fs_fd.mat'));
    roi2 = dtiReadRoi(fullfile(roiPath,'rh_mpfc_4mm.mat'));
    newRoiName = fullfile(roiPath,'rh_wmmask_fs_fd_mpfc4mm.mat');
    newRoi = dtiMergeROIs(roi1,roi2);
    dtiWriteRoi(newRoi, newRoiName)
end