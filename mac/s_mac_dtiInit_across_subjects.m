function s_mac_dtiInit_across_subjects
%
% This function loads a series of subjects and performs dtiInit for each
% one of them
%

datapath = '/media/storg/matproc';
subjects = {'mac03218_1','mac03218_1'};

        
for isubj = 1:length(subjects)
    % Build the file names for dwi, bvecs/bvals
    %dwiPath = dir(fullfile(datapath,subjects{iSbj},'*DTI*'));
    dwiPath = fullfile(datapath,subjects{isubj},'raw');
    dwiFile = dir(fullfile(dwiPath,'*.nii.gz'));
    %dwiFile = fullfile(datapath,subjects{iSbj},dwiFile.name);
    %dwiBvec = [dwiFile(1:end-6),'bvec'];
    %dwiBval = [dwiFile(1:end-6),'bval'];
    t1Path = dir(fullfile(datapath,subjects{isubj},'*t1_acpc.nii.gz'));
    t1File = fullfile(datapath,subjects{isubj},t1Path.name);

    cd(fullfile(dwiPath))
    dwiParams = dtiInitParams;
    dwiParams.dwOutMm = [2, 2, 2];
    
    %need this for Siemens acquired data
    dwiParams.rotateBvecsWithCanXform = 1;
    dwiParams.phaseEncodeDir = 2;
    
    dtiInit(dwiFile.name, t1File, dwiParams);
end
