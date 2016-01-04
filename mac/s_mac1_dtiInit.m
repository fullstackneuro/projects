function s_mac1_dtiInit
%
% This function loads a series of subjects and performs dtiInit for each
% one of them
%

datapath = '/media/storg/matproc';

subjects = {'mac03218_1','mac03218_2','mac12826_1','mac12826_2', ...
            'mac18000_1','mac18000_2'};
        %,'mac18622_1','mac18622_2'
for isubj = 1:length(subjects)
    % Build the file names for dwi, bvecs/bvals
    %dwiPath = dir(fullfile(datapath,subjects{iSbj},'*DTI*'));
    dwiPath = fullfile(datapath,subjects{isubj},'raw');
    dwiFile = dir(fullfile(dwiPath,'*.nii.gz'));
    dwiFile = fullfile(dwiPath, dwiFile.name);
    %dwiBvec = [dwiFile(1:end-6),'bvec'];
    %dwiBval = [dwiFile(1:end-6),'bval'];
    t1Path = dir(fullfile(datapath,subjects{isubj},'*_t1_acpc.nii.gz'));
    t1File = fullfile(datapath, subjects{isubj}, t1Path.name);

    dwiParams = dtiInitParams;
    %dwiParams.clobber = true;
    dwiParams.dwOutMm = [2, 2, 2];
    
    %need this for Siemens acquired data
    dwiParams.rotateBvecsWithCanXform = 1;
    dwiParams.phaseEncodeDir = 2;
    
    dtiInit(dwiFile, t1File, dwiParams);
end