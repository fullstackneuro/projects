% change base directory

baseDir = '/media/lcne/matproc/';

subjects = {'els006','els009','els012','els013','els014','els016','els017', ...
            'els024','els025','els026','els028','els032','els033','els034', ...
            'els039','els040','els041','els042','els045','els046','els047', ...
            'els048','els049','els050','els053','els054','els055','els056', ...
            'els057','els058','els059','els060','els061','els062','els064', ...
            'els065','els067','els068','els069','els070','els072','els073', ...
            'els074','els075','els076','els077','els079','els081','els083', ...
            'els085','els086','els087','els088','els089','els090'};
        
%subjects t2
subjects =  {'els006-T2','els012-T2','els013-T2','els014-T2','els016-T2','els017-T2','els025-T2',...
             'els026-T2','els032x-T2','els042-T2','els047-T2','els048-T2','els049-T2','els050-T2', ...
             'els054-T2','els056-T2','els061-T2','els064-T2','els065-T2','els067-T2','els068-T2', ...
             'els069-T2','els070-T2','els081-T2','els087-T2','els089x-T2','els092-T2','els100-T2'};


for isubj = 1:length(subjects)

    dtFile = fullfile(baseDir, subjects{isubj}, '/dti60trilin/dt6.mat');
    dt6 = load(dtFile,'files');
    files = dt6.files;
    files.alignedDwRaw   = ['/media/lcne/matproc/' subjects{isubj} '/' subjects{isubj} '_aligned_trilin.nii.gz'];
    files.alignedDwBvecs = ['/media/lcne/matproc/' subjects{isubj} '/' subjects{isubj} '_aligned_trilin.bvecs'];
    files.alignedDwBvals = ['/media/lcne/matproc/' subjects{isubj} '/' subjects{isubj} '_aligned_trilin.bvals'];
    save(dtFile, 'files','-APPEND')
end


%single sub

dtFile = fullfile(baseDir, 'els100', '/dti60trilin/dt6.mat');
dt6 = load(dtFile,'files');
files = dt6.files;
files.t1 = 'els006_t1_acpc.nii.gz';
files.alignedDwRaw = '/media/lcne/matproc/els100/els100_aligned_trilin.nii.gz';
files.alignedDwBvecs = '/media/lcne/matproc/els100/els100_aligned_trilin.bvecs';
files.alignedDwBvals = '/media/lcne/matproc/els100/els100_aligned_trilin.bvals';
save(dtFile, 'files','-APPEND')

%check params
dt6 = load(dtFile,'params');
params = dt6.params;
params.rawDataDir = '/media/lcne/matproc/els006';
params.rawDataFile = 'els006_aligned_trilin.nii';
save(dtFile, 'params','-APPEND')