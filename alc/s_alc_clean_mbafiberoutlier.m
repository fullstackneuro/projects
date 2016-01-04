%manually cleaning fiber group outliers for individual subjects

subjectlist =   'alc187','alc219','alc220','alc245', ...
                'alc257','alc262','alc269','alc274', ...
                'alc275','alc276','alc277','alc278', ...
                'alc280','alc281','alc282','alc284'};      
        %alc283, alc286

% cd to subject folder
cd('/media/storg/matproc/dp092612/dti96trilin/fibers/mrtrix');

%manually load fiber group, clean outliers, save cleaned fiber group
rh_fg_name = mrvSelectFile('r',{'*.pdb';'*.*'}, 'Select fiber group file');
rh_fg_unclean = fgRead(rh_fg_name);
[rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
fgWrite(rh_fg_clean, 'clean_rh_antshortins_nacc','mat');

%left hemisphere
lh_fg_name = mrvSelectFile('r',{'*.pdb';'*.*'}, 'Select fiber group file');
lh_fg_unclean = fgRead(lh_fg_name);
[lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
fgWrite(lh_fg_clean, 'clean_lh_antshortins_nacc','mat');