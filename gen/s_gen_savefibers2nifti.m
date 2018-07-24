function s_gen_savefibers2nifti

baseDir = '/media/storg/matproc';

subjects = {'ab071412','al151016','bb160402','bk032113','bp160213','cs160214', ...
            'dc050213','ds080712','en062813','gr051513','hm062513','jc160320','jc160321', ...
            'jg151121','jl071912','jv151030','jw072512','jw160316', ...
            'lc052213','lf052813','mk021913','ml061013', ...
            'np072412','pk160319','pw060713','rb160407','rf160313', ...
            'sn061213','sp061313','tw062113','zl150930'};
        
%done ac160415 'jh160702','jr160507','kn160918','ld160918','li160927', ...
%'mp160511','ph161104', ...
%'hw161104',
%storg
%

for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix/');
    t1path      = fullfile(baseDir, subjectDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    %dt6path = fullfile(baseDir, subjectDir, '/dti96trilin/dt6.mat');
        
    %load fiber groups
    %right hemisphere
    rhfgpath = fullfile(fibersFolder, 'clean_rh_frontorb_shortins.mat');
    rhfgload = dtiLoadFiberGroup(rhfgpath);
     
    %left hemisphere
    lhfgpath = fullfile(fibersFolder, 'clean_lh_frontorb_shortins.mat');
    lhfgload = dtiLoadFiberGroup(lhfgpath);

    %convert fiber group to ROI
    rhnewroi = dtiCreateRoiFromFibers(rhfgload,'acpc_rh_ains_vlpfc');
    lhnewroi = dtiCreateRoiFromFibers(lhfgload,'acpc_lh_ains_vlpfc');
    
    cd(fibersFolder);
    
    %save new roi
    dtiRoiNiftiFromMat(rhnewroi, t1path, 'acpc_rh_ains_vlpfc');
    dtiRoiNiftiFromMat(lhnewroi, t1path, 'acpc_lh_ains_vlpfc');
    
end
