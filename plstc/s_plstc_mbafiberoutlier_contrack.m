function s_plstc_mbafiberoutlier_contrack
%script to cleaning fiber group outliers (posterior insula - nacc)

baseDir = '/media/lcne/matproc/';

subjects = {'ad082014_1','ad082014_2', ...
            'hm082514_1','hm082514_2', ...
            'ml082214_1','ml082214_2', ...
            'yw083014_1','yw083014_2', ...
            'ld080115_1','ld080115_2', ...
            'lp080215_1','lp080215_2', ...
            'lt081615_1','lt081615_2', ...
            'mm080915_1','mm080915_2', ...
            'nb081015_1','nb081015_2'};
        
for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/conTrack');
    fibersFolderMPFC  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/conTrack/mpfcnacc');
   
    %left hemisphere mpfc
    lh_mpfc_fgname = dir([fibersFolderMPFC '/scoredFG_mpfcnacc_lh_mpfc_5mm_lh_nacc_aseg_fd_top500.pdb']);
    lmpfc_fgpath = fullfile(fibersFolderMPFC, lh_mpfc_fgname.name);
    lmpfc_fg_unclean = fgRead(lmpfc_fgpath);
    [lmpfc_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lmpfc_fg_unclean, 4, 4, 100);
    fgWrite(lmpfc_fg_clean, [fibersFolder '/outlie_lh_mpfc_nacc'],'mat');
    
    %right hemisphere mpfc
    rh_mpfc_fgname = dir([fibersFolderMPFC '/scoredFG_mpfcnacc_rh_mpfc_5mm_rh_nacc_aseg_fd_top500.pdb']);
    rmpfc_fgpath = fullfile(fibersFolderMPFC, rh_mpfc_fgname.name);
    rmpfc_fg_unclean = fgRead(rmpfc_fgpath);
    [rmpfc_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rmpfc_fg_unclean, 4, 4, 100);
    fgWrite(rmpfc_fg_clean, [fibersFolder '/outlie_rh_mpfc_nacc'],'mat');
 
end