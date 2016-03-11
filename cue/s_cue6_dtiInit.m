function s_cue6_dtiInit
%
% This function loads a series of subjects and performs dtiInit for each
%

datapath = '/media/storg/matproc';

subjects = {'sr151031','tf151127'};
%{
'vm151031','wr151127','zl150930'};
%skip'tm161017'
%}
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
    %dwiParams.phaseEncodeDir = 1;
    %dwiParams.rotateBvecsWithRx = true;
    dwiParams.rotateBvecsWithCanXform = true;
    dtiInit(dwiFile, t1File, dwiParams);
end