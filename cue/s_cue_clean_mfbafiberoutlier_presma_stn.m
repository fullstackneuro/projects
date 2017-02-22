function s_cue_clean_mfbafiberoutlier_presma_stn
%script to cleaning fiber group outliers (vlpfc fronto-orbital -- subthalamic nucleus)

baseDir = '/media/lcne/matproc/';

subjects = {'am160914','kn160918','ld160918','li160927'};

%{
'ab071412','al151016','bb160402','bk032113','bp160213','cs160214','dc050213', ...
            'ds080712','en062813','gr051513','hm062513','jc160320','jc160321','jg151121', ...
            'jl071912','jt062413','jv151030','jw072512','jw160316','lc052213','mk021913', ...
            'ml061013','np072412','pk160319','ps151001','pw060713','rb160407','rf160313', ...
            'sp061313','wb071812','zl150930'    
'ac160415','jh160702','jr160507','mp160511','ps160508'
%}
       
for isubj = 1:length(subjects)
    %define subject directory
    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    %right hemi
    rh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_rh_supfront_clip_presma_rh_ventraldc_clip_stn_rh_supfront_clip_presma_nonZero_MaskROI_rh_ventraldc_clip_stn_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/clean_rh_presma_stn'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_lh_supfront_clip_presma_lh_ventraldc_clip_stn_lh_supfront_clip_presma_nonZero_MaskROI_lh_ventraldc_clip_stn_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/clean_lh_presma_stn'],'mat');
end