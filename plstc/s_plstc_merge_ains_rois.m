function s_plstc_merge_ains_rois
% merges two mat rois, saves as single mat roi

datapath = '/media/lcne/matproc';

subjects = {'ad082014_2','hm082514_2','ml082214_2', ...
            'ld080115_1','ld080115_2', ...
            'lp080215_1','lp080215_2', ...
            'lt081615_1','lt081615_2', ...
            'mm080915_1','mm080915_2', ...
            'nb081015_1','nb081015_2'};
%{
'ad082014_1','ad082014_2', ...
            'hm082514_1','hm082514_2', ...
            'ml082214_1','ml082214_2', ...
            'yw083014_1','yw083014_2'};
%}
            
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