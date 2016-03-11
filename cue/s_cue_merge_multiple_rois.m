function s_cue_merge_multiple_rois
% merges several mat rois, saves as single mat roi

datapath = '/media/storg/matproc';

subjects = {'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
            'jv151030','ps151001','si151120','sr151031','tf151127','vm151031', ...
            'wr151127','zl150930'}; 

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1    = dtiReadRoi(fullfile(roiPath,'lh_wmmask_fs_fd.mat'));
    roi2    = dtiReadRoi(fullfile(roiPath,'lh_antins_a2009s_fd.mat'));
    roi3    = dtiReadRoi(fullfile(roiPath,'lh_shortins_a2009s_fd.mat'));
    roi4    = dtiReadRoi(fullfile(roiPath,'lh_frontinfang_a2009s_fd.mat'));
    roi5    = dtiReadRoi(fullfile(roiPath,'lh_frontorb_a2009s_fd.mat'));
    roi6    = dtiReadRoi(fullfile(roiPath,'lh_latorb_a2009s_fd.mat'));
    newRoiName = fullfile(roiPath,'lh_wmmask_vlpfc_fd.mat');
    newRoi   = dtiMergeROIs(roi1,roi2);
    newRoi2  = dtiMergeROIs(newRoi,roi3);
    newRoi3  = dtiMergeROIs(newRoi2,roi4);
    newRoi4 = dtiMergeROIs(newRoi3, roi5);
    finalRoi = dtiMergeROIs(newRoi4, roi6);
    dtiWriteRoi(finalRoi, newRoiName);
    
end