function s_subval_clean_mfbafiberoutlier_mpfc_nacc
%script to cleaning fiber group outliers (vlpfc fronto-orbital -- insula)

baseDir = '/media/lcne/matproc/subval';

subjects = {'SV_002','SV_003','SV_005','SV_007','SV_015','SV_016', ...
            'SV_020','SV_021','SV_025','SV_027','SV_034','SV_035', ...
            'SV_036','SV_038','SV_041','SV_045','SV_047','SV_048','SV_061', ...
            'SV_062','SV_064','SV_065','SV_066','SV_068','SV_071','SV_073', ...
            'SV_081','SV_082','SV_086','SV_088','SV_090','SV_093','SV_096', ...
            'SV_100','SV_101','SV_103','SV_106','SV_107','SV_109','SV_111', ...
            'SV_115','SV_116','SV_119','SV_120','SV_123','SV_128','SV_129', ...
            'SV_131','SV_136','SV_139','SV_140','SV_141','SV_142','SV_145', ...
            'SV_146','SV_147','SV_149','SV_150','SV_151','SV_152','SV_153', ...
            'SV_157','SV_158','SV_161','SV_162','SV_165','SV_166'};

for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    contrackFolder  = fullfile(baseDir, subjectDir, '/dti32trilin/fibers/conTrack/mpfcnacc/');
    fibersFolder = fullfile(baseDir, subjectDir, '/dti32trilin/fibers/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    rh_fg_name = dir([contrackFolder '/scoredFG_mpfcnacc_rh_mpfc_4mm_rh_nacc_aseg_fd_top500.pdb']);
    rh_fg_path = fullfile(contrackFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/outlie_rh_mpfc_nacc'],'mat');

    %left hemisphere
    lh_fg_name = dir([contrackFolder '/scoredFG_mpfcnacc_lh_mpfc_4mm_lh_nacc_aseg_fd_top500.pdb']);
    lh_fg_path = fullfile(contrackFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/outlie_lh_mpfc_nacc'],'mat');
end