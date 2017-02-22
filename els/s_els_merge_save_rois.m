function s_els_merge_save_rois
% merges two mat rois, saves as single mat roi
%

datapath = '/media/lcne/matproc';
subjects =  {'els006-T2','els012-T2','els013-T2','els014-T2','els016-T2','els017-T2','els025-T2',...
             'els026-T2','els032x-T2','els042-T2','els047-T2','els048-T2','els049-T2','els050-T2', ...
             'els054-T2','els056-T2','els061-T2','els064-T2','els065-T2','els067-T2','els068-T2', ...
             'els069-T2','els070-T2','els081-T2','els087-T2','els089x-T2','els092-T2','els100-T2'};
            
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1    = dtiReadRoi(fullfile(roiPath,'lh_shortins_a2009s_fd.mat'));
    roi2    = dtiReadRoi(fullfile(roiPath,'lh_antins_a2009s_fd.mat'));
    newRoiName = fullfile(roiPath,'lh_antshortins_fd.mat');
    newRoi     = dtiMergeROIs(roi1,roi2);
    dtiWriteRoi(newRoi, newRoiName)
end
