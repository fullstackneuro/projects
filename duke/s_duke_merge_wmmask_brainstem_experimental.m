function s_duke_merge_wm_brainstem
% merges two mat rois, saves as single mat roi

datapath = '/cylon/matproc';

subjects = {'dnd029', 'dnd039', 'dnd060', 'dnd069', 'dnd070', 'dnd092', 'dnd097', 'dnd099', 'dnd109', 'dnd114', 'dnd121'};
%val053 no dwi

hemis = {'lh','rh'};

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    for hemi = 1:length(hemis)
        roi1name = [hemis{hemi} '_wmmask_fs'];
        roi2name = [hemis{hemi} '_wmmask_fs'];
        roi1    = dtiReadRoi(fullfile(roiPath, roi1name));
        roi2    = dtiReadRoi(fullfile(roiPath, roi2name));
        newRoiName = fullfile(roiPath,[hemis{hemi} '_wmmask_fs.mat']);
        newRoi     = dtiMergeROIs(roi1,roi2);
        dtiWriteRoi(newRoi, newRoiName)
    end
end