function s_plstc_mbafiberoutlier_mrtrix
%script to cleaning fiber group outliers (posterior insula - nacc)

baseDir = '/media/lcne/matproc/';

subjects = {'yw083014_2'};
  
  % missing      
  %     vlpfc-stn
  % lpresmastn 'ad082014_1','ad082014_2', ...
            
  
for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix');
   %{
    %vlpfc-stn    
    %left hemisphere
    lh_vlpfcstn_fgname = dir([fibersFolder '/*aligned_trilin_csd_lmax10_lh_frontorb_a2009s_fd_lh_ventraldc_clip_stn_lh_frontorb_a2009s_fd_nonZero_MaskROI_lh_ventraldc_clip_stn_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut005_initcut005_curv1_step02_prob.pdb']);
    lvlpfcstn_fgpath = fullfile(fibersFolder, lh_vlpfcstn_fgname.name);
    lvlpfcstn_fg_unclean = fgRead(lvlpfcstn_fgpath);
    [lvlpfcstn_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lvlpfcstn_fg_unclean, 3, 2, 100);
    fgWrite(lvlpfcstn_fg_clean, [fibersFolder '/outlie_lh_vlpfc_stn'],'mat');
    
    clear lvlpfcstn_fg_unclean lvlpfcstn_fg_clean
    
    %right hemisphere 
    rh_vlpfcstn_fgname = dir([fibersFolder '/*aligned_trilin_csd_lmax10_rh_frontorb_a2009s_fd_rh_ventraldc_clip_stn_rh_frontorb_a2009s_fd_nonZero_MaskROI_rh_ventraldc_clip_stn_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut005_initcut005_curv1_step02_prob.pdb']);
    rvlpfcstn_fgpath = fullfile(fibersFolder, rh_vlpfcstn_fgname.name);
    rvlpfcstn_fg_unclean = fgRead(rvlpfcstn_fgpath);
    [rvlpfcstn_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rvlpfcstn_fg_unclean, 3, 2, 100);
    fgWrite(rvlpfcstn_fg_clean, [fibersFolder '/outlie_rh_vlpfc_stn'],'mat');
 
    clear rvlpfcstn_fg_unclean rvlpfcstn_fg_clean
    
    %ains-vlpfc  
    %left hemisphere
    lh_ainsvlpfc_fgname = dir([fibersFolder '/*aligned_trilin_csd_lmax10_lh_shortins_a2009s_fd_lh_frontorb_a2009s_fd_lh_shortins_a2009s_fd_nonZero_MaskROI_lh_frontorb_a2009s_fd_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut0075_initcut0075_curv1_step02_prob.pdb']);
    lainsvlpfc_fgpath = fullfile(fibersFolder, lh_ainsvlpfc_fgname.name);
    lainsvlpfc_fg_unclean = fgRead(lainsvlpfc_fgpath);
    [lainsvlpfc_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lainsvlpfc_fg_unclean, 3, 2, 100);
    fgWrite(lainsvlpfc_fg_clean, [fibersFolder '/outlie_lh_ains_vlpfc'],'mat');
    
    clear lainsvlpfc_fg_unclean lainsvlpfc_fg_clean
    
    %right hemisphere 
    rh_ainsvlpfc_fgname = dir([fibersFolder '/*aligned_trilin_csd_lmax10_rh_shortins_a2009s_fd_rh_frontorb_a2009s_fd_rh_shortins_a2009s_fd_nonZero_MaskROI_rh_frontorb_a2009s_fd_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut0075_initcut0075_curv1_step02_prob.pdb']);
    rainsvlpfc_fgpath = fullfile(fibersFolder, rh_ainsvlpfc_fgname.name);
    rainsvlpfc_fg_unclean = fgRead(rainsvlpfc_fgpath);
    [rainsvlpfc_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rainsvlpfc_fg_unclean, 3, 2, 100);
    fgWrite(rainsvlpfc_fg_clean, [fibersFolder '/outlie_rh_ains_vlpfc'],'mat');
    
    clear rainsvlpfc_fg_unclean rainsvlpfc_fg_clean
    %}
    %presma-stn
    %left hemisphere
    lh_presmastn_fgname = dir([fibersFolder '/*aligned_trilin_csd_lmax10_lh_supfront_clip_presma_lh_ventraldc_clip_stn_lh_supfront_clip_presma_nonZero_MaskROI_lh_ventraldc_clip_stn_nonZero_MaskROI_union_lh_wmmask_fs_fd_cut005_initcut0025_curv1_step02_prob.pdb']);
    lpresmastn_fgpath = fullfile(fibersFolder, lh_presmastn_fgname.name);
    lpresmastn_fg_unclean = fgRead(lpresmastn_fgpath);
    [lpresmastn_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lpresmastn_fg_unclean, 3, 2, 100);
    fgWrite(lpresmastn_fg_clean, [fibersFolder '/outlie_lh_presma_stn'],'mat');
    
    clear lpresmastn_fg_unclean lpresmastn_fg_clean
    
    %right hemisphere 
    rh_presmastn_fgname = dir([fibersFolder '/*aligned_trilin_csd_lmax10_rh_supfront_clip_presma_rh_ventraldc_clip_stn_rh_supfront_clip_presma_nonZero_MaskROI_rh_ventraldc_clip_stn_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut005_initcut0025_curv1_step02_prob.pdb']);
    rpresmastn_fgpath = fullfile(fibersFolder, rh_presmastn_fgname.name);
    rpresmastn_fg_unclean = fgRead(rpresmastn_fgpath);
    [rpresmastn_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rpresmastn_fg_unclean, 3, 2, 100);
    fgWrite(rpresmastn_fg_clean, [fibersFolder '/outlie_rh_presma_stn'],'mat');

    clear rpresmastn_fg_unclean rpresmastn_fg_clean
    
end


