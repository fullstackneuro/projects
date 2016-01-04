vlpfc_clean_mfbafiberoutlier_shortins
%clean fiber group outliers (vlpfc fronto-orbital -- insula)

subjects = {'ab071412','bc050913','bk032113','bk053012','ch101612', ...
            'cs050813','dc050213','dp092612','ds080712','ec081912', ...
            'en062813','fg092712','gr051513','hg101012','hm062513', ...
            'jh042913','jl071912','jo081312','jt062413','jw072512', ...
            'kr030113','lc052213','lf052813','lw061713','md072512', ...
            'mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713', ...
            'pw061113','ra053013','rb073112','rb082212','sd040313', ...
            'sh010813','sl080912','sn061213','sp061313','tr101312', ...
            'tw062113','vv060313','wb071812'};

baseDir = '/media/storg/matproc/';        
subjects = 'np072412';
fibersFolder  = fullfile(baseDir, subjects, '/dti96trilin/fibers/mrtrix/');
    
%load fiber group, clean outliers, save cleaned fiber group
cd(fibersFolder);
%manually load fiber group, clean outliers, save cleaned fiber group
rh_fg_name = mrvSelectFile('r',{'*.mat';'*.*'}, 'Select fiber group file');
rh_fg_unclean = fgRead(rh_fg_name);
[rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
fgWrite(rh_fg_clean, 'clean_rfrontorbshortins_default','mat');