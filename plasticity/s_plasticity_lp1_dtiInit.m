function s_plasticity_lp1_dtiInit
%
% This function loads a series of subjects and performs dtiInit for each
%

datapath = '/media/storg/matproc';

subjects = {'lp080215_1_hardi3','lp080215_1_hardi4'};

%{
%'ld080115_2_hardi1','ld080115_2_hardi2','ld080115_2_hardi3','ld080115_2_hardi4', ...};
'ld080115_1_hardi1','ld080115_1_hardi2','ld080115_1_hardi3','ld080115_1_hardi4'
           align to T1 from session 1
'ad082014_hardi1','ad082014_hardi2','ad082014_hardi3', ...
'ml082214_hardi1','ml082214_hardi2','ml082214_hardi3', ...
'hm082514_hardi1','hm082514_hardi2','hm082514_hardi3', ...
'yw083014_hardi1','yw083014_hardi2','yw083014_hardi3', ...
           align to T1 from session 2
'hm082514_2_hardi2','hm082514_2_hardi3', ...
'ml082214_2_hardi2','ml082214_2_hardi3', ...
'yw083014_2_hardi2','yw083014_2_hardi3'
%}      
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
    %dwiParams.clobber = true;
    dwiParams.dwOutMm = [2, 2, 2];
    dtiInit(dwiFile, t1File, dwiParams);
end