function s_mac_clean_mfbafiberoutlier
%script to cleaning fiber group outliers (anterior insula - nacc)

baseDir = '/media/storg/matproc/';

subjects = {'mac03218_1'};
%'mac03218_2','mac12826_1','mac12826_2', ...
%            'mac18000_1','mac18000_2'};
        
for isubj = 1:length(subjects)
    subjectDir    = [subjects{isubj}];
    fibersFolderMRTRIX = fullfile(baseDir, subjectDir, '/dti64trilin/fibers/mrtrix');
    %{
    %left anterior
    lh_ant_fgname = dir([fibersFolderMRTRIX '/*csd_lmax6_lh_thal_aseg_fd_FA_L*.pdb']);
    lant_fgpath = fullfile(fibersFolderMRTRIX, lh_ant_fgname.name);
    lant_fg_unclean = fgRead(lant_fgpath);
    [lant_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lant_fg_unclean, 3, 2, 100);
    fgWrite(lant_fg_clean, [fibersFolderMRTRIX '/clean_lh_anterior'],'mat');
    %left posterior
    lh_post_fgname = dir([fibersFolderMRTRIX '/*csd_lmax6_lh_thal_aseg_fd_FP_L*.pdb']);
    lpost_fgpath = fullfile(fibersFolderMRTRIX, lh_post_fgname.name);
    lpost_fg_unclean = fgRead(lpost_fgpath);
    [lpost_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lpost_fg_unclean, 3, 2, 100);
    fgWrite(lpost_fg_clean, [fibersFolderMRTRIX '/clean_lh_posterior'],'mat');
    %left temporal
    lh_temp_fgname = dir([fibersFolderMRTRIX '/*csd_lmax6_lh_thal_aseg_fd_ILF_roi2_L*.pdb']);
    ltemp_fgpath = fullfile(fibersFolderMRTRIX, lh_temp_fgname.name);
    ltemp_fg_unclean = fgRead(ltemp_fgpath);
    [ltemp_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(ltemp_fg_unclean, 3, 2, 100);
    fgWrite(ltemp_fg_clean, [fibersFolderMRTRIX '/clean_lh_temporal'],'mat');
    %left motor
    lh_mot_fgname = dir([fibersFolderMRTRIX '/*csd_lmax6_lh_thal_aseg_fd_SLF_roi1_L*.pdb']);
    lmot_fgpath = fullfile(fibersFolderMRTRIX, lh_mot_fgname.name);
    lmot_fg_unclean = fgRead(lmot_fgpath);
    [lmot_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lmot_fg_unclean, 3, 2, 100);
    fgWrite(lmot_fg_clean, [fibersFolderMRTRIX '/clean_lh_motor'],'mat');
    %left parietal
    lh_par_fgname = dir([fibersFolderMRTRIX '/*csd_lmax6_lh_thal_aseg_fd_SLF_roi2_L*.pdb']);
    lpar_fgpath = fullfile(fibersFolderMRTRIX, lh_par_fgname.name);
    lpar_fg_unclean = fgRead(lpar_fgpath);
    [lpar_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lpar_fg_unclean, 3, 2, 100);
    fgWrite(lpar_fg_clean, [fibersFolderMRTRIX '/clean_lh_parietal'],'mat');
    
    %right anterior
    rh_ant_fgname = dir([fibersFolderMRTRIX '/*csd_lmax6_rh_thal_aseg_fd_FA_R*.pdb']);
    rant_fgpath = fullfile(fibersFolderMRTRIX, rh_ant_fgname.name);
    rant_fg_unclean = fgRead(rant_fgpath);
    [rant_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rant_fg_unclean, 3, 2, 100);
    fgWrite(rant_fg_clean, [fibersFolderMRTRIX '/clean_rh_anterior'],'mat');
    %right posterior
    rh_post_fgname = dir([fibersFolderMRTRIX '/*csd_lmax6_rh_thal_aseg_fd_FP_R*.pdb']);
    rpost_fgpath = fullfile(fibersFolderMRTRIX, rh_post_fgname.name);
    rpost_fg_unclean = fgRead(rpost_fgpath);
    [rpost_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rpost_fg_unclean, 3, 2, 100);
    fgWrite(rpost_fg_clean, [fibersFolderMRTRIX '/clean_rh_posterior'],'mat');
    %}
    %right temporal
    rh_temp_fgname = dir([fibersFolderMRTRIX '/mac03218_1_aligned_trilin_csd_lmax6_rh_thal_aseg_fd_ILF_roi2_R_rh_thal_aseg_fd_nonZero_MaskROI_ILF_roi2_R_nonZero_MaskROI_union_rh_wmsegthalventdcinfins_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    rtemp_fgpath = fullfile(fibersFolderMRTRIX, rh_temp_fgname.name);
    rtemp_fg_unclean = fgRead(rtemp_fgpath);
    [rtemp_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rtemp_fg_unclean, 3, 2, 100);
    fgWrite(rtemp_fg_clean, [fibersFolderMRTRIX '/clean_rh_temporal'],'mat');
    %right motor
    rh_mot_fgname = dir([fibersFolderMRTRIX '/*csd_lmax6_rh_thal_aseg_fd_SLF_roi1_R*.pdb']);
    rmot_fgpath = fullfile(fibersFolderMRTRIX, rh_mot_fgname.name);
    rmot_fg_unclean = fgRead(rmot_fgpath);
    [rmot_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rmot_fg_unclean, 3, 2, 100);
    fgWrite(rmot_fg_clean, [fibersFolderMRTRIX '/clean_rh_motor'],'mat');
    %right parietal
    rh_par_fgname = dir([fibersFolderMRTRIX '/*csd_lmax6_rh_thal_aseg_fd_SLF_roi2_R*.pdb']);
    rpar_fgpath = fullfile(fibersFolderMRTRIX, rh_par_fgname.name);
    rpar_fg_unclean = fgRead(rpar_fgpath);
    [rpar_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rpar_fg_unclean, 3, 2, 100);
    fgWrite(rpar_fg_clean, [fibersFolderMRTRIX '/clean_rh_parietal'],'mat');
    
end