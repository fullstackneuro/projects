function s_mac_clean_mfbafiberoutlier_ains_nacc
%script to cleaning fiber group outliers (vlpfc fronto-orbital -- insula)

baseDir = '/media/lcne/matproc/';

subjects = {'mac13106'};
%{
'mac03218_1','mac03218_2','mac12826_1','mac12826_2', ...
            'mac18000_1','mac18000_2','mac18622_1'};
% ,'mac18622_2' dtiInit
%}
for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti64trilin/fibers/mrtrix/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    rh_fg_name = dir([fibersFolder '/*.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/outlie_rh_antshortins_nacc'],'mat');

    %left hemisphere
    %lh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_antshortins_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_antshortins_fd_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut0075_initcut0005_curv1_step02_prob.pdb']);
    %lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    %lh_fg_unclean = fgRead(lh_fg_path);
    %[lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    %fgWrite(lh_fg_clean, [fibersFolder '/outlie_lh_antshortins_nacc'],'mat');
end