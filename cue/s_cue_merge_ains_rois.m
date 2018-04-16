function s_cue_merge_ains_rois
% merges two mat rois, saves as single mat roi

datapath = '/media/lcne/matproc';

subjects = {'ds170915','ts170927'};
%{
cue done
'ag151024','ja151218','si151120','tf151127','wh160130','wr151127'

lcne new
'at160601','cg160715','jf160703','lm160914','mr170621','nc160905','rf170610', ...
'rs160730','rv160413','tj160529','zm160627'
lcne done
'jb161004','rc161007','se161021','mr161024', ...
            'gm161101','hw161104','kd170115', ...
            'er170121','al170316','jd170330','jw170330', ...
            'tg170423','hp170601','rl170603','jc170501'
lcne
'am160914','cm160510','ja160416','ps160508','rt160420','yl160507','ac160415', ...
'ag151024','aa151010','al151016','dw151003','ie151020','ja151218', ...
'jh160702','jr160507','kn160918','ld160918','li160927','mp160511'
?'tm160117',
storg
'bb160402','bp160213','jc160320','jc160321','jg151121','jn160403','pk160319',
'ps151001','rb160407','rf160313','rp160205','si151120','sr151031','ss160205',
'tf151127','vm151031','wh160130','wr151127','zl150930','jw160316','as160129',
'cs160214','kl160122','jv151030',
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