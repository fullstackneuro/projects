%% clean frontostriatal and mesolimbic fibers
%manually cleaning fiber group outliers for individual subjects
%{
subjectlist = 'ab071412','bc050913','bk032113','bk053012','ch101612','cs050813', ...
              'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
              'gr051513','hg101012','hm062513','jh042913','jl071912','jo081312', ...
              'jt062413','jw072512','kr030113','lc052213','lf052813','lw061713', ...
              'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
              'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
              'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
              'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'
%}
%% Frontostriatal fiber cleaning
% cd to subject folder
cd('/media/storg/matproc/en062813/dti96trilin/fibers/conTrack/frontostriatal');

%manually load fiber group, clean outliers, save cleaned fiber group
rh_mpfc_name = mrvSelectFile('r',{'*.mat';'*.*'}, 'Select fiber group file');
rh_mpfc_unclean = fgRead(rh_mpfc_name);
[rh_mpfc_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_mpfc_unclean, 4, 2, 100);
fgWrite(rh_mpfc_clean, 'clean_rh_mpfc_nacc','mat');

%left hemisphere
lh_mpfc_name = mrvSelectFile('r',{'*.mat';'*.*'}, 'Select fiber group file');
lh_mpfc_unclean = fgRead(lh_mpfc_name);
[lh_mpfc_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_mpfc_unclean, 4, 2, 100);
fgWrite(lh_mpfc_clean, 'clean_lh_mpfc_nacc','mat');

%% Mesolimbic fiber cleaning
%cd to mesolimbic folder
cd('/media/storg/matproc/ec081912/dti96trilin/fibers/conTrack/mesolimbic');

%manually load fiber group, clean outliers, save cleaned fiber group
rh_vta_name = mrvSelectFile('r',{'*.mat';'*.*'}, 'Select fiber group file');
rh_vta_unclean = fgRead(rh_vta_name);
[rh_vta_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_vta_unclean, 4, 2, 100);
fgWrite(rh_vta_clean, 'clean_rh_vta_nacc','mat');

%left hemisphere
lh_vta_name = mrvSelectFile('r',{'*.mat';'*.*'}, 'Select fiber group file');
lh_vta_unclean = fgRead(lh_vta_name);
[lh_vta_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_vta_unclean, 4, 2, 100);
fgWrite(lh_vta_clean, 'clean_lh_vta_nacc','mat');