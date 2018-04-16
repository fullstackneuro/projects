function s_subval_dtiInit03
%
% This function loads a series of subjects and performs dtiInit for each
%

datapath = '/media/lcne/matproc/subval';

subjects = {'SV_073','SV_081','SV_082','SV_086','SV_088','SV_090','SV_093', ...
            'SV_096','SV_100','SV_101','SV_103','SV_106','SV_107','SV_109', ...
            'SV_111','SV_115','SV_116','SV_119'};

for isubj = 1:length(subjects)
    % Build the file names for dwi, bvecs/bvals, t1
    dwiPath = fullfile(datapath, subjects{isubj},'raw');
    dwiFile = fullfile(dwiPath, [subjects{isubj} '.nii.gz']);
    t1File = fullfile(datapath, subjects{isubj}, [subjects{isubj} '_t1_acpc.nii.gz']);

    dwiParams = dtiInitParams;
    dwiParams.clobber = true;
    %dwiParams.eddyCorrect = 0;
    %dwiParams.flipLrApFlag = true;
    dwiParams.dwOutMm = [2, 2, 2];
    dwiParams.phaseEncodeDir = 1;
    %dwiParams.rotateBvecsWithRx = true;
    dwiParams.rotateBvecsWithCanXform = true;
    dtiInit(dwiFile, t1File, dwiParams);
end