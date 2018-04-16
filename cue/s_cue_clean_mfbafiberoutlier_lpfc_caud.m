function s_cue_clean_mfbafiberoutlier_lpfc_caud
%script to cleaning fiber group outliers (vlpfc / dlpfc - caudate)

baseDir = '/media/lcne/matproc/';

subjects = {'at160601','cg160715','jf160703','lm160914','mr170621','nc160905','rf170610', ...
            'rs160730','rv160413','tj160529','zm160627'};
%{
lcne done
'jb161004','rc161007','se161021','mr161024', ...
            'gm161101','hw161104','ph161104','kd170115', ...
            'er170121','al170316','jd170330','jw170330', ...
            'tg170423','jc170501','hp170601','rl170603'
            
lcne
'am160914','cm160510','ja160416','ps160508','rt160420','yl160507','ac160415', ...
'ag151024','aa151010','al151016','dw151003','ie151020','ja151218', ...
'jh160702','jr160507','kn160918','ld160918','li160927','mp160511'
?'tm160117',
?'aa151010 
'al151016', not enough fibers, signal drop rvlpfc
'dw151003', not enough fibers
'ie151020' 'not enough fibers l vlpfc            
            
storg
'bb160402','bp160213','jc160320','jc160321','jg151121','jn160403','pk160319', ...
'ps151001','rb160407','rf160313','rp160205','si151120','sr151031','ss160205', ...
'tf151127','vm151031','wh160130','wr151127','zl150930','jw160316','as160129', ...
'cs160214','kl160122','jv151030'
%}

for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    rh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_rh_caud_aseg_rh_frontorb_a2009s_fd_rh_caud_aseg_nonZero_MaskROI_rh_frontorb_a2009s_fd_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/outlie_rh_vlpfc_caud'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_lh_caud_aseg_lh_frontorb_a2009s_fd_lh_caud_aseg_nonZero_MaskROI_lh_frontorb_a2009s_fd_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/outlie_lh_vlpfc_caud'],'mat');
    
    %load fiber group, clean outliers, save cleaned fiber group
    rh_dl_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_rh_caud_aseg_rh_frontmidlat_a2009s_fd_rh_caud_aseg_nonZero_MaskROI_rh_frontmidlat_a2009s_fd_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    rh_dl_fg_path = fullfile(fibersFolder, rh_dl_fg_name.name);
    rh_dl_fg_unclean = fgRead(rh_dl_fg_path);
    [rh_dl_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_dl_fg_unclean, 3, 2, 100);
    fgWrite(rh_dl_fg_clean, [fibersFolder '/outlie_rh_dlpfc_caud'],'mat');

    %left hemisphere
    lh_dl_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_lh_caud_aseg_lh_frontmidlat_a2009s_fd_lh_caud_aseg_nonZero_MaskROI_lh_frontmidlat_a2009s_fd_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    lh_dl_fg_path = fullfile(fibersFolder, lh_dl_fg_name.name);
    lh_dl_fg_unclean = fgRead(lh_dl_fg_path);
    [lh_dl_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_dl_fg_unclean, 3, 2, 100);
    fgWrite(lh_dl_fg_clean, [fibersFolder '/outlie_lh_dlpfc_caud'],'mat');
end
