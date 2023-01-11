function a_abcd_clean_mfbafiberoutlier_ains_nacc

%script to cleaning fiber group outliers (ains-vlpfc and amyg-nacc)

baseDir = '/mnt/acorn/abcd/matproc';

%read subjects in from text file
subjects={};
file=fopen('/mnt/acorn/abcd/matproc/scripts/dummy.txt','r');
tline=fgetl(file);
while ischar(tline)
    disp(tline)
    subjects=[subjects, tline];
    tline=fgetl(file);
end


for isubj = 1:length(subjects)
    %define subject directory
    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti60trilin/fibers/mrtrix/');
    disp(['Working on subject ' subjects{isubj}]);
    
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