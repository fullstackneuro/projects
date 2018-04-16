function s_subval_dtiInit02
%
% This function loads a series of subjects and performs dtiInit for each
%

datapath = '/media/lcne/matproc/subval';

subjects = {'SV_025','SV_027','SV_032','SV_034','SV_035','SV_036','SV_038', ...
            'SV_041','SV_045','SV_047','SV_048','SV_061','SV_062','SV_064', ...
            'SV_065','SV_066','SV_068','SV_071'};

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