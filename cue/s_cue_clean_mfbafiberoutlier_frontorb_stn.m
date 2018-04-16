function s_cue_clean_mfbafiberoutlier_frontorb_stn
%script to cleaning fiber group outliers (vlpfc fronto-orbital -- subthalamic nucleus)

baseDir = '/media/lcne/matproc/';

subjects = {'er170121','gm161101','hw161104','jw170330','ph161104'};

%{
presma-stn and vlpfc-stn same
storg
'ec081912','jh042913','jo081312','kr030113','lf052813','ps022013','ra053013','sd040313','sh010813','sn061213','tw062113'
lcne
'er170121','gm161101','hw161104','jw170330','ph161104'

left ains-vlpfc
'ec081912','jh042913','jo081312','kr030113','lf052813','ps022013','ra053013','sd040313','sh010813','sn061213','tw062113'
mpfc-nacc?
%}  
            
for isubj = 1:length(subjects)
    %define subject directory
    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    %right hemi
    rh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_rh_frontorb_a2009s_fd_rh_ventraldc_clip_stn_rh_frontorb_a2009s_fd_nonZero_MaskROI_rh_ventraldc_clip_stn_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/clean_rh_frontorb_stn'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_lh_frontorb_a2009s_fd_lh_ventraldc_clip_stn_lh_frontorb_a2009s_fd_nonZero_MaskROI_lh_ventraldc_clip_stn_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/clean_lh_frontorb_stn'],'mat');
end