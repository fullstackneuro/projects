function s_plasticity_dtiInit
%
% This function loads a series of subjects and performs dtiInit for each
% one of them
%

datapath = '/media/storg/matproc';

subjects = {%'ad082014_hardi1_2','ad082014_hardi2_2','ad082014_hardi3_2', ...
            %'ml082214_hardi1_2','ml082214_hardi2_2','ml082214_hardi3_2', ...
            %'hm082514_hardi1_2','hm082514_hardi2_2','hm082514_hardi3_2', ...
            'yw083014_hardi1_2','yw083014_hardi2_2','yw083014_hardi3_2', ...
            };

for isubj = 1:length(subjects)
    % Build the file names for dwi, bvecs/bvals
    %dwiPath = dir(fullfile(datapath,subjects{iSbj},'*DTI*'));
    dwiPath = fullfile(datapath,subjects{isubj},'raw');
    dwiFile = dir(fullfile(dwiPath,'*.nii.gz'));
    dwiFile = fullfile(dwiPath, dwiFile.name);
    %dwiBvec = [dwiFile(1:end-6),'bvec'];
    %dwiBval = [dwiFile(1:end-6),'bval'];
    t1Path = dir(fullfile(datapath,subjects{isubj},'*t1_acpc_2.nii.gz'));
    t1File = fullfile(datapath, subjects{isubj}, t1Path.name);

    dwiParams = dtiInitParams;
    %dwiParams.clobber = true;
    dwiParams.dwOutMm = [2, 2, 2];
    dtiInit(dwiFile, t1File, dwiParams);
end
