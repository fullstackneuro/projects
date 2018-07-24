function s_abcd_clean_mfbafiberoutlier_ains_nacc

%script to cleaning fiber group outliers (ains-vlpfc and amyg-nacc)

baseDir = '/media/lcne/matproc/abcd/';

subjects = {'sub-NDARINVZYLV9BMB'};

for isubj = 1:length(subjects)
    %define subject directory
    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti95trilin/fibers/mrtrix/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    %right hemi
    rh_fg_name = dir([fibersFolder '/' subjects{isubj} '_aligned_trilin_csd_lmax10_rh_nacc_aseg_fd_rh_antshortins_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_antshortins_fd_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut0075_initcut0075_curv1_step02_prob.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/outlie_rh_ains_nacc'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/' subjects{isubj} '_aligned_trilin_csd_lmax10_lh_nacc_aseg_fd_lh_antshortins_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_antshortins_fd_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut0075_initcut0075_curv1_step02_prob.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/outlie_lh_ains_nacc'],'mat');
end