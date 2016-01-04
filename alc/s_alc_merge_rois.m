function s_alc_merge_rois
% merges two mat rois, saves as single mat roi

datapath = '/media/storg/matproc';

subjects = {'alc283','alc286'};
%{
'alc187','alc219','alc220','alc245', ...
            'alc257','alc262','alc269','alc274', ...
            'alc275','alc276','alc277','alc278', ...
            'alc280','alc281','alc282','alc284'
%}

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1    = dtiReadRoi(fullfile(roiPath,'rh_antins_a2009s.mat'));
    roi2    = dtiReadRoi(fullfile(roiPath,'rh_shortins_a2009s.mat'));
    newRoiName = fullfile(roiPath,'rh_antshortins.mat');
    newRoi     = dtiMergeROIs(roi1,roi2);
    dtiWriteRoi(newRoi, newRoiName)
end