function s_plasticity_lp2_dtiInit
%
% This function loads a series of subjects and performs dtiInit for each
%

datapath = '/media/storg/matproc';

subjects = {'lp080215_2_hardi1','lp080215_2_hardi2'};
    
%'lp080215_2_hardi1','lp080215_2_hardi2','lp080215_2_hardi3','lp080215_2_hardi4'};
      
for isubj = 1:length(subjects)
    % Build the file names for dwi, bvecs/bvals
    %dwiPath = dir(fullfile(datapath,subjects{iSbj},'*DTI*'));
    dwiPath = fullfile(datapath,subjects{isubj},'raw');
    dwiFile = fullfile(dwiPath,[subjects{isubj} '.nii.gz']);
    %dwiBvec = [dwiFile(1:end-6),'bvec'];
    %dwiBval = [dwiFile(1:end-6),'bval'];
    t1Path = dir(fullfile(datapath,subjects{isubj},'*2_t1_acpc.nii.gz'));
    t1File = fullfile(datapath, subjects{isubj}, t1Path.name);

    dwiParams = dtiInitParams;
    %dwiParams.clobber = true;
    dwiParams.dwOutMm = [2, 2, 2];
    dtiInit(dwiFile, t1File, dwiParams);
end
