%save a fiber group to ROI.nii.gz in subject ACPC space

baseDir = '/media/storg/matproc/';

subjects = {'ab071412','ch101612','dc050213','dp092612','ds080712','ec081912','en062813', ...
            'gr051513','hg101012','hm062513','jo081312','jt062413','jw072512','md072512', ...
            'mk021913','ml061013','mn052313','na060213','pf020113','ps022013','pw060713', ...
            'pw061113','ra053013','rb073112','rb082212','sl080912','sn061213','sp061313', ...
            'tr101312','tw062113','vv060313','wb071812'};

for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix/');
    t1path      = fullfile(baseDir, subjectDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    %dt6path = fullfile(baseDir, subjectDir, '/dti96trilin/dt6.mat');
        
    %load fiber groups
    %right hemisphere
    rhfgpath = fullfile(fibersFolder, 'clean_rh_antshortins_nacc.mat');
    rhfgload = dtiLoadFiberGroup(rhfgpath);
     
    %left hemisphere
    lhfgpath = fullfile(fibersFolder, 'clean_lh_antshortins_nacc.mat');
    lhfgload = dtiLoadFiberGroup(lhfgpath);

    %convert fiber group to ROI
    rhnewroi = dtiCreateRoiFromFibers(rhfgload,'acpc_rh_ains_nacc');
    lhnewroi = dtiCreateRoiFromFibers(lhfgload,'acpc_lh_ains_nacc');
    
    cd(fibersFolder);
    
    %save new roi
    dtiRoiNiftiFromMat(rhnewroi, t1path, 'acpc_rh_ains_nacc');
    dtiRoiNiftiFromMat(lhnewroi, t1path, 'acpc_lh_ains_nacc');

end