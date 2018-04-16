function s_subval_dtiInit04
%
% This function loads a series of subjects and performs dtiInit for each
%

datapath = '/media/lcne/matproc/subval';

subjects = {'SV_120','SV_123','SV_128','SV_129','SV_131','SV_136','SV_139', ...
            'SV_140','SV_141','SV_142','SV_145','SV_146','SV_147','SV_149', ...
            'SV_150','SV_151','SV_152'};

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