function s_plasticity_merge_save_rois
% merges two mat rois, saves as single mat roi
%

datapath = '/media/storg/matproc';
subjects = {'lt081615_1','lt081615_2'};
%{
'mm080915_1','mm080915_2','nb081015_1','nb081015_2'
'ad082014','ad082014_2','yw083014','yw083014_2','hm082514','hm082514_2','ml082214','ml082214_2', ...
            'ld080115_1','ld080115_2','lp080215_1','lp080215_2'};
%}        
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1 = dtiReadRoi(fullfile(roiPath,'lh_antins_a2009s.mat'));
    roi2 = dtiReadRoi(fullfile(roiPath,'lh_shortins_a2009s.mat'));
    newRoiName = fullfile(roiPath,'lh_antshortins.mat');
    newRoi = dtiMergeROIs(roi1,roi2);
    dtiWriteRoi(newRoi, newRoiName)
end