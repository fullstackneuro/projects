function s_abcd_clean_mfbafiberoutlier_ains_nacc

%script to cleaning fiber group outliers (ains-vlpfc and amyg-nacc)

baseDir = '/media/lcne/matproc/';

subjects = {'els137-Tmid','els144-Tmid','els145-Tmid','els146-Tmid','els152-Tmid','els159x-Tmid','els172-Tmid', ...
            'els214-Tmid','els302-TK1','els303-TK1','els305-TK1','els307-TK1', ...
            'els311-TK1','els312-TK1','els315-TK1','els318-TK1'};

for isubj = 1:length(subjects)
    %define subject directory
    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti60trilin/fibers/mrtrix/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    %right hemi
    rh_fg_name = dir([fibersFolder '/' subjects{isubj} '_aligned_trilin_csd_lmax6_rh_antshortins_fd_rh_nacc_aseg_fd_rh_antshortins_fd_nonZero_MaskROI_rh_nacc_aseg_fd_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/outlie_rh_ains_nacc'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/' subjects{isubj} '_aligned_trilin_csd_lmax6_lh_antshortins_fd_lh_nacc_aseg_fd_lh_antshortins_fd_nonZero_MaskROI_lh_nacc_aseg_fd_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/outlie_lh_ains_nacc'],'mat');
end