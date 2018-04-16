function s_els_clean_mfbafiberoutlier_ains_nacc

%script to cleaning fiber group outliers (ains-vlpfc and amyg-nacc)

baseDir = '/media/lcne/matproc/';

subjects = {'els210'};
%{
??'els191','els213',

'els173','els174','els179','els180','els183', ...
            'els185','els186','els188','els189',
            'els192x','els193','els194x','els197x', ...
            'els202','els203','els208','els208','els210', ...

done
'els006','els012','els013','els014','els016','els017','els025',...
             'els026','els032','els042','els047','els048','els049','els050', ...
             'els054','els056','els061','els064','els065','els067','els068', ...
             'els069','els070','els081','els087','els089','els092','els100'
             not enough rh fibers? els050-T2, els068-T2 'els069-T2',
             not enough lh fibers? els054-T2
'els006-T2','els012-T2','els013-T2','els014-T2','els016-T2','els017-T2','els025-T2',...
             'els026-T2','els032x-T2','els042-T2','els047-T2','els048-T2','els049-T2',, ... 
          'els056-T2','els061-T2','els064-T2','els065-T2','els067-T2'
'els070-T2','els081-T2','els087-T2','els089x-T2','els092-T2','els100-T2'
             
'els103','els106','els107','els111','els112','els113','els114', ...
'els115','els117','els118','els121','els122','els124','els125', ...
'els127','els130','els132','els134','els136','els137','els139', ...
'els140','els147','els148','els149','els151','els154','els155', ...
'els156','els157','els162','els163','els164','els165','els166', ...
'els171',
%}
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
    fgWrite(rh_fg_clean, [fibersFolder '/clean_rh_ains_nacc'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/' subjects{isubj} '_aligned_trilin_csd_lmax6_lh_antshortins_fd_lh_nacc_aseg_fd_lh_antshortins_fd_nonZero_MaskROI_lh_nacc_aseg_fd_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/clean_lh_ains_nacc'],'mat');
end