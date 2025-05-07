function clean_ainsnacc_outliers(baseDir, sublist)

%script to cleaning fiber group outliers (ains-vlpfc and amyg-nacc)


%generate subject list from textfile
str = fileread(sublist);
sublist = regexp(str, '\n', 'split');
subjects = sublist(~cellfun('isempty',sublist));


for isubj = 1:length(subjects)
    
    %establish subject-level paths
    rawName=subjects{isubj};
    subName=['sub-' rawName(1:15)];
    timePoint=['ses-' rawName(17:34)];
    
    %define subject directory
    fibersFolder  = fullfile(baseDir, subName, timePoint, '/dti60trilin/fibers/mrtrix/');
    disp(['Working on subject ' subName]);
    
    %load fiber group, clean outliers, save cleaned fiber group
    %right hemi
    try
        rh_fg_name = dir([fibersFolder '/' 'flip_rh_ains_nacc.mat']);
        rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
        rh_fg_unclean = fgRead(rh_fg_path);
        [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
        fgWrite(rh_fg_clean, [fibersFolder '/outlie_rh_ains_nacc'],'mat');
    catch e
        disp(e.identifier);
        disp(e.message);
    end

    %left hemisphere
    try
        lh_fg_name = dir([fibersFolder '/' 'flip_lh_ains_nacc.mat']);
        lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
        lh_fg_unclean = fgRead(lh_fg_path);
        [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
        fgWrite(lh_fg_clean, [fibersFolder '/outlie_lh_ains_nacc'],'mat');
    catch e
        disp(e.identifier);
        disp(e.message);
    end
end