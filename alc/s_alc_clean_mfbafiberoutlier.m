function s_alc_clean_mfbafiberoutlier
%script to cleaning fiber group outliers (anterior insula - nacc)

baseDir = '/media/storg/matproc/';

subjects = {'alc187','alc219','alc220','alc245', ...
            'alc257','alc262','alc269','alc274', ...
            'alc275','alc276','alc277','alc278', ...
            'alc280','alc281','alc282','alc283','alc284','alc286'};
        
for isubj = 1:length(subjects)
    subjectDir    = [subjects{isubj}];
    fibersFolderMRTRIX = fullfile(baseDir, subjectDir, '/dti84trilin/fibers/mrtrix');

    %left ains-nacc
    lh_ains_fgname = dir([fibersFolderMRTRIX '/*csd_lmax10_lh_nacc_aseg_fd_lh_antshortins_fd*initcut01*.pdb']);
    lains_fgpath = fullfile(fibersFolderMRTRIX, lh_ains_fgname.name);
    lains_fg_unclean = fgRead(lains_fgpath);
    [lains_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lains_fg_unclean, 3, 2, 100);
    fgWrite(lains_fg_clean, [fibersFolderMRTRIX '/clean_lh_ains_nacc'],'mat');

    %right ains-nacc
    rh_ains_fgname = dir([fibersFolderMRTRIX '/*csd_lmax10_rh_nacc_aseg_fd_rh_antshortins_fd*initcut01*.pdb']);
    rains_fgpath = fullfile(fibersFolderMRTRIX, rh_ains_fgname.name);
    rains_fg_unclean = fgRead(rains_fgpath);
    [rains_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rains_fg_unclean, 3, 2, 100);
    fgWrite(rains_fg_clean, [fibersFolderMRTRIX '/clean_rh_ains_nacc'],'mat');
    
end