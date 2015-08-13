function s_finra2_clean_mfbafiberoutlier_postinsnacc
%script to cleaning fiber group outliers (posterior insula - nacc)

baseDir = '/media/storg/matproc/';

subjects = {'ab071412','bc050913','bk032113','ch101612', ...
            'cs050813','dc050213','dp092612','ds080712','ec081912', ...
            'en062813','fg092712','gr051513','hg101012','hm062513', ...
            'jh042913','jl071912','jo081312','jt062413','jw072512', ...
            'kr030113','lc052213','lf052813','lw061713','md072512', ...
            'mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713', ...
            'pw061113','ra053013','rb073112','rb082212','sd040313', ...
            'sh010813','sl080912','sn061213','sp061313','tr101312', ...
            'tw062113','vv060313','wb071812'};
        
for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    %rh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_rh_amyg_a2009s_rh_nacc_aseg_fd_rh_amyg_a2009s_nonZero_MaskROI_rh_nacc_aseg_fd_nonZero_MaskROI_union_rh_wmmask_amyg_fd_prob.pdb']);
    %rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    %rh_fg_unclean = fgRead(rh_fg_path);
    %[rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    %fgWrite(rh_fg_clean, [fibersFolder '/clean_rh_amyg_nacc'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/*aligned_trilin_csd_lmax10_lh_amyg_a2009s_lh_nacc_aseg_fd_lh_amyg_a2009s_nonZero_MaskROI_lh_nacc_aseg_fd_nonZero_MaskROI_union_lh_wmmask_amyg_fd_prob.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/clean_lh_amyg_nacc'],'mat');
end