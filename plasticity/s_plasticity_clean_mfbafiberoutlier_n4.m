function s_plasticity_clean_mfbafiberoutlier_n4
%script to cleaning fiber group outliers (posterior insula - nacc)

baseDir = '/media/storg/matproc/';

subjects = {'mm080915_1_hardi1','mm080915_1_hardi2','mm080915_1_hardi3','mm080915_1_hardi4', ...
            'mm080915_2_hardi1','mm080915_2_hardi2','mm080915_2_hardi3','mm080915_2_hardi4', ...
            'nb081015_1_hardi1','nb081015_1_hardi2','nb081015_1_hardi3','nb081015_1_hardi4', ...
            'nb081015_2_hardi1','nb081015_2_hardi2','nb081015_2_hardi3','nb081015_2_hardi4', ...
            'ld080115_1_hardi1','ld080115_1_hardi2','ld080115_1_hardi3','ld080115_1_hardi4', ...
            'ld080115_2_hardi1','ld080115_2_hardi2','ld080115_2_hardi3','ld080115_2_hardi4', ...
            'lp080215_1_hardi1','lp080215_1_hardi2','lp080215_1_hardi3','lp080215_1_hardi4', ...
            'lp080215_2_hardi1','lp080215_2_hardi2','lp080215_2_hardi3','lp080215_2_hardi4', ...
            'lt081615_1_hardi1','lt081615_1_hardi2','lt081615_1_hardi3','lt081615_1_hardi4', ...
            'lt081615_2_hardi1','lt081615_2_hardi2','lt081615_2_hardi3','lt081615_2_hardi4'};
        
for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/conTrack');
    fibersFolderMPFC  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/conTrack/mpfc');
    fibersFolderVTA  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/conTrack/vta');
    fibersFolderMRTRIX = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix');
    %{
    %left ains-nacc
    lh_ains_fgname = dir([fibersFolderMRTRIX '/*csd_lmax10_lh_nacc_aseg_lh_antshortins*.pdb']);
    lains_fgpath = fullfile(fibersFolderMRTRIX, lh_ains_fgname.name);
    lains_fg_unclean = fgRead(lains_fgpath);
    [lains_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lains_fg_unclean, 3, 2, 100);
    fgWrite(lains_fg_clean, [fibersFolder '/clean_lh_ains_nacc'],'mat');

    %right ains-nacc
    rh_ains_fgname = dir([fibersFolderMRTRIX '/*csd_lmax10_rh_nacc_aseg_rh_antshortins*.pdb']);
    rains_fgpath = fullfile(fibersFolderMRTRIX, rh_ains_fgname.name);
    rains_fg_unclean = fgRead(rains_fgpath);
    [rains_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rains_fg_unclean, 3, 2, 100);
    fgWrite(rains_fg_clean, [fibersFolder '/clean_rh_ains_nacc'],'mat');
    %}
    
    %left hemisphere mpfc
    lh_mpfc_fgname = dir([fibersFolderMPFC '/scoredFG_mpfc_lh_mpfc_4mm_lh_nacc_aseg_top500.pdb']);
    lmpfc_fgpath = fullfile(fibersFolderMPFC, lh_mpfc_fgname.name);
    lmpfc_fg_unclean = fgRead(lmpfc_fgpath);
    [lmpfc_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lmpfc_fg_unclean, 4, 4, 100);
    fgWrite(lmpfc_fg_clean, [fibersFolder '/unclean_lh_mpfc_nacc'],'mat');
    
    %right hemisphere mpfc
    rh_mpfc_fgname = dir([fibersFolderMPFC '/scoredFG_mpfc_rh_mpfc_4mm_rh_nacc_aseg_top500.pdb']);
    rmpfc_fgpath = fullfile(fibersFolderMPFC, rh_mpfc_fgname.name);
    rmpfc_fg_unclean = fgRead(rmpfc_fgpath);
    [rmpfc_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rmpfc_fg_unclean, 4, 4, 100);
    fgWrite(rmpfc_fg_clean, [fibersFolder '/unclean_rh_mpfc_nacc'],'mat');
    
    %left vta
    lh_vta_fgname = dir([fibersFolderVTA '/scoredFG_vta_vta_4mm_lh_nacc_aseg_top500.pdb']);
    lvta_fgpath = fullfile(fibersFolderVTA, lh_vta_fgname.name);
    lvta_fg_unclean = fgRead(lvta_fgpath);
    [lvta_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lvta_fg_unclean, 4, 4, 100);
    fgWrite(lvta_fg_clean, [fibersFolder '/unclean_lh_vta_nacc'],'mat');
    
    %right hemisphere vta
    rh_vta_fgname = dir([fibersFolderVTA '/scoredFG_vta_vta_4mm_rh_nacc_aseg_top500.pdb']);
    rvta_fgpath = fullfile(fibersFolderVTA, rh_vta_fgname.name);
    rvta_fg_unclean = fgRead(rvta_fgpath);
    [rvta_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rvta_fg_unclean, 4, 4, 100);
    fgWrite(rvta_fg_clean, [fibersFolder '/unclean_rh_vta_nacc'],'mat');  
end