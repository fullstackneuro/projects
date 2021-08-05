function s_duke_clean_mfbafiberoutlier_mpfcnacc
%script to cleaning fiber group outliers (vlpfc fronto-orbital -- insula)

baseDir = '/cylon/matproc/';

subjects = {'dnd045', 'dnd077'};
        %'dnd040',dnd012','
        %'dnd005', 'dnd013', 'dnd016', 'dnd018' <- completed
        %dnd018 error - not enough fibers
       
for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti64trilin/fibers/mrtrix');
    
    %load fiber group, clean outliers, save cleaned fiber group
    rh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_mpfc_5mm_rh_nacc_aseg_fd_nonZero_MaskROI_rh_mpfc_5mm_nonZero_MaskROI_union.nii.gz_rh_wmmask_fs_fd_cut005_initcut005_curv1_step02_prob.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    rh_fg_clean.colorRgb = [200 100 100];
    fgWrite(rh_fg_clean, [fibersFolder '/outlie_rh_amyg_nacc1'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_mpfc_5mm_lh_nacc_aseg_fd_nonZero_MaskROI_lh_mpfc_5mm_nonZero_MaskROI_union.nii.gz_lh_wmmask_fs_fd_cut005_initcut005_curv1_step02_prob.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    lh_fg_clean.colorRgb = [200 100 100];
    fgWrite(lh_fg_clean, [fibersFolder '/outlie_lh_amyg_nacc1'],'mat');
end