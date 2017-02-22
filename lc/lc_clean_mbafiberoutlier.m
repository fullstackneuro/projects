%manually cleaning fiber group outliers for individual subjects

subjectlist =   ;

% cd to subject folder
cd('/media/storg/matproc/sl080912/dti96trilin/fibers/mrtrix');

%manually load fiber group, clean outliers, save cleaned fiber group
rh_fg_name = mrvSelectFile('r',{'*.pdb';'*.*'}, 'Select fiber group file');
rh_fg_unclean = fgRead(rh_fg_name);
[rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3.5, 3.5, 100);
fgWrite(rh_fg_clean, 'clean_rh_lc_ains','mat');

%left hemisphere
lh_fg_name = mrvSelectFile('r',{'*.pdb';'*.*'}, 'Select fiber group file');
lh_fg_unclean = fgRead(lh_fg_name);
[lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
fgWrite(lh_fg_clean, 'clean_lh_antshortins_nacc','mat');