function s_cue_clean_mfbafiberoutlier_ains_nacc
%script to cleaning fiber group outliers (vlpfc fronto-orbital -- insula)

baseDir = '/media/lcne/matproc/';

subjects = {'nb160221'};
%{
'as160317','as170730','cs170816','ds170728','rc170730','rt170816'
%89 diff dirs 'nb160221',
'jb161004','rc161007','se161021','mr161024', ...
            'gm161101','hw161104','ph161104','kd170115', ...
            'er170121','al170316','jd170330','jw170330', ...
            'tg170423','jc170501','hp170601','rl170603'};
%}
for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti89trilin/fibers/mrtrix/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    rh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_rh_nacc_aseg_fd_rh_antshortins_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_antshortins_fd_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut0075_initcut0005_curv1_step02_prob.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/outlie_rh_antshortins_nacc'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_lh_nacc_aseg_fd_lh_antshortins_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_antshortins_fd_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut0075_initcut0005_curv1_step02_prob.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/outlie_lh_antshortins_nacc'],'mat');
end