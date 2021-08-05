function s_duke_clean_mfbafiberoutlier_ainsnacc
%script to cleaning fiber group outliers (vlpfc fronto-orbital -- insula)

baseDir = '/cylon/matproc/';

subjects = {'dnd013', 'dnd048', 'dnd050', 'dnd052', 'dnd092', 'dnd111', 'dnd114', 'dnd121'};   
        %'dnd040',dnd012','
for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti64trilin/fibers/mrtrix');
    
    %load fiber group, clean outliers, save cleaned fiber group
    rh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_antshortins_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_antshortins_fd_nonZero_MaskROI_union.nii.gz_rh_wmmask_fs_fd_cut005_initcut005_curv1_step02_prob.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/outlie_rh_ains_nacc'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_antshortins_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_antshortins_fd_nonZero_MaskROI_union.nii.gz_lh_wmmask_fs_fd_cut005_initcut005_curv1_step02_prob.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/outlie_lh_ains_nacc'],'mat');
end