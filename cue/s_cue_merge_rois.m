function s_cue_merge_rois
% merges two mat rois, saves as single mat roi

datapath = '/media/storg/matproc';

subjects = {'as160129','bp160213','cs160214','kl160122', ...
            'nb160221','rp160205','ss160205','wh160130'};
%{
'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
            'jv151030','ps151001','si151120','sr151031','tf151127','vm151031', ...
            'wr151127','zl150930'
%}

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1    = dtiReadRoi(fullfile(roiPath,'rh_antins_a2009s_fd.mat'));
    roi2    = dtiReadRoi(fullfile(roiPath,'rh_shortins_a2009s_fd.mat'));
    newRoiName = fullfile(roiPath,'rh_antshortins_fd.mat');
    newRoi     = dtiMergeROIs(roi1,roi2);
    dtiWriteRoi(newRoi, newRoiName)
end