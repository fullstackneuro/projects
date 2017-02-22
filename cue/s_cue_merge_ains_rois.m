function s_cue_merge_ains_rois
% merges two mat rois, saves as single mat roi

datapath = '/media/lcne/matproc';

subjects = {'am160914','kn160918','ld160918','li160927'};

%{
'ac160415','jh160702','jr160507','mp160511','ps160508'
'ab071412','al151016','bb160402','bk032113','bp160213','cs160214','dc050213', ...
            'ds080712','en062813','gr051513','hm062513','jc160320','jc160321','jg151121', ...
            'jl071912','jt062413','jv151030','jw072512','jw160316','lc052213', ...
            'mk021913','ml061013','np072412','pk160319','ps151001','pw060713','rb160407', ...
            'rf160313','sp061313','wb071812','zl150930'
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