function s_els_clean_mfbafiberoutlier_amyg_nacc

%script to cleaning fiber group outliers (amyg-nacc)

baseDir = '/media/lcne/matproc/';

subjects = {'els006','els009','els012','els013','els014','els016','els017', ...
            'els024','els025','els026','els028','els032','els033','els034', ...
            'els039','els040','els041','els042','els045','els046','els047', ...
            'els048','els049','els050','els053','els054','els055','els056', ...
            'els057','els058','els059','els060','els061','els062','els064', ...
            'els065','els067','els068','els069','els070','els072','els073', ...
            'els074','els075','els076','els077','els079','els081','els083', ...
            'els085','els086','els087','els088','els089','els090'};  
            
for isubj = 1:length(subjects)
    %define subject directory
    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti60trilin/fibers/mrtrix/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    %right hemi
    rh_fg_name = dir([fibersFolder '/' subjects{isubj} '_aligned_trilin_csd_lmax8_rh_amyg_aseg_fd_rh_nacc_aseg_fd_rh_amyg_aseg_fd_nonZero_MaskROI_rh_nacc_aseg_fd_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/clean_rh_amyg_nacc'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/' subjects{isubj} '_aligned_trilin_csd_lmax8_lh_amyg_aseg_fd_lh_nacc_aseg_fd_lh_amyg_aseg_fd_nonZero_MaskROI_lh_nacc_aseg_fd_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/clean_lh_amyg_nacc'],'mat');
end