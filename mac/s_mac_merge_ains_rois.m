function s_mac_merge_ains_rois
% merges two mat rois, saves as single mat roi
%

datapath = '/media/storg/matproc';

subjects = {'mac03218_1','mac03218_2','mac12826_1','mac12826_2', ...
            'mac18000_1','mac18000_2','mac18622_1'};
% ,'mac18622_2' dtiInit

hemis = {'lh','rh'};

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    for hemi = 1:length(hemis)
        roi1name = [hemis{hemi} '_antins_a2009s_fd.mat'];
        roi2name = [hemis{hemi} '_shortins_a2009s_fd.mat'];
        roi1    = dtiReadRoi(fullfile(roiPath, roi1name));
        roi2    = dtiReadRoi(fullfile(roiPath, roi2name));
        newRoiName = fullfile(roiPath,[hemis{hemi} '_antshortins_fd.mat']);
        newRoi     = dtiMergeROIs(roi1,roi2);
        dtiWriteRoi(newRoi, newRoiName)
    end
end