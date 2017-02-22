function s_plasticity_nb1_dtiInit
%
% This function loads a series of subjects and performs dtiInit for each
%

datapath = '/media/storg/matproc';

subjects = {'nb081015_1_hardi1','nb081015_1_hardi2','nb081015_1_hardi3','nb081015_1_hardi4'};

for isubj = 1:length(subjects)
    % Build the file names for dwi, bvecs/bvals
    %dwiPath = dir(fullfile(datapath,subjects{iSbj},'*DTI*'));
    dwiPath = fullfile(datapath,subjects{isubj},'raw');
    dwiFile = dir(fullfile(dwiPath,'*.nii.gz'));
    dwiFile = fullfile(dwiPath, dwiFile.name);
    %dwiBvec = [dwiFile(1:end-6),'bvec'];
    %dwiBval = [dwiFile(1:end-6),'bval'];
    t1Path = dir(fullfile(datapath,subjects{isubj},'*1_t1_acpc.nii.gz'));
    t1File = fullfile(datapath, subjects{isubj}, t1Path.name);
    
    dwiParams = dtiInitParams;
    dwiParams.clobber = true;
    dwiParams.dwOutMm = [2, 2, 2];
    %dwiParams.phaseEncodeDir = 2;
    dwiParams.rotateBvecsWithCanXform = true;
    dtiInit(dwiFile, t1File, dwiParams);
end