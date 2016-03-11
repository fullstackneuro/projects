function s_cue_clean_mfbafiberoutlier_frontorb_short
%script to cleaning fiber group outliers (vlpfc fronto-orbital -- insula)

baseDir = '/media/storg/matproc/';

subjects = {'as160129','bp160213','cs160214','kl160122', ...
            'rp160205','ss160205','wh160130'};
%{
89 diff dir ='nb160221',         
'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
            'jv151030','ps151001','si151120','sr151031','tf151127','vm151031', ...
            'wr151127','zl150930'
%}
        
for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    rh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_rh_shortins_a2009s_fd_rh_frontorb_a2009s_fd_rh_shortins_a2009s_fd_nonZero_MaskROI_rh_frontorb_a2009s_fd_nonZero_MaskROI_union_rh_wmmask_fs_fd_cut01_initcut01_curv1_step02_prob.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/clean_rfrontorb_shortins'],'mat');

    %left hemisphere
    %lh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_lh_nacc_aseg_fd_lh_postins_lh_nacc_aseg_fd_nonZero_MaskROI_lh_postins_nonZero_MaskROI_union_lh_wmmask_clip_postinsnacc_prob.pdb']);
    %lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    %lh_fg_unclean = fgRead(lh_fg_path);
    %[lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    %fgWrite(lh_fg_clean, [fibersFolder '/clean_lvlpfcins_default'],'mat');
end