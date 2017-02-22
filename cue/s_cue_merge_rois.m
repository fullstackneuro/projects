function s_cue_merge_rois
% merges two mat rois, saves as single mat roi

datapath = '/media/lcne/matproc';

subjects = {'jh160702'};

%{
'ac160415','cm160510','ja160416','jr160507','mp160511','ps160508','rt160420','yl160507'
'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
            'jv151030','ps151001','si151120','sr151031','tf151127','tm161017','vm151031', ...
            'wr151127','zl150930','as160129','bp160213','cs160214','kl160122', ...
            'nb160221','rp160205','ss160205','wh160130'};
'rb160407','jn160403','bb160402','jc160321','jc160320','pk160319','jw160316', ...
            'rf160313'
'as160129','bp160213','cs160214','kl160122', ...
            'nb160221','rp160205','ss160205','wh160130', ...
'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
            'jv151030','ps151001','si151120','sr151031','tf151127','vm151031', ...
            'wr151127','zl150930'
%}

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1    = dtiReadRoi(fullfile(roiPath,'lh_antins_a2009s_fd.mat'));
    roi2    = dtiReadRoi(fullfile(roiPath,'lh_shortins_a2009s_fd.mat'));
    newRoiName = fullfile(roiPath,'lh_antshortins_fd.mat');
    newRoi     = dtiMergeROIs(roi1,roi2);
    dtiWriteRoi(newRoi, newRoiName)
end