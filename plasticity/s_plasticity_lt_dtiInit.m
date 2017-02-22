function s_plasticity_lt_dtiInit
%
% This function loads a series of subjects and performs dtiInit for each
% Align all 4 DWI acquisitions to first and second T1s

datapath = '/media/storg/matproc';

subjects = {'lt081615_1_hardi1','lt081615_1_hardi2','lt081615_1_hardi3','lt081615_1_hardi4', ...
            'lt081615_2_hardi1','lt081615_2_hardi2','lt081615_2_hardi3','lt081615_2_hardi4'};
%{
'ad082014_1_hardi1','ad082014_1_hardi2','ad082014_1_hardi3', ...
'ad082014_2_hardi1','ad082014_2_hardi2','ad082014_2_hardi3'
'hm082514_1_hardi1','hm082514_1_hardi2','hm082514_1_hardi3', ...
'hm082514_2_hardi1','hm082514_2_hardi2','hm082514_2_hardi3'
'ml082214_1_hardi1','ml082214_1_hardi2','ml082214_1_hardi3', ...
'ml082214_2_hardi1','ml082214_2_hardi2','ml082214_2_hardi3'
'yw083014_1_hardi1','yw083014_1_hardi2','yw083014_1_hardi3', ...
'yw083014_2_hardi1','yw083014_2_hardi2','yw083014_2_hardi3'
'ld080115_1_hardi1','ld080115_1_hardi2','ld080115_1_hardi3','ld080115_1_hardi4', ...
'ld080115_2_hardi1','ld080115_2_hardi2','ld080115_2_hardi3','ld080115_2_hardi4
'lp080215_1_hardi1','lp080215_1_hardi2','lp080215_1_hardi3','lp080215_1_hardi4', ...
'lp080215_2_hardi1','lp080215_2_hardi2','lp080215_2_hardi3','lp080215_2_hardi4'
%}
            
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
    dwiParams.clobber = true;
    dwiParams.dwOutMm = [2, 2, 2];
    dwiParams.phaseEncodeDir = 2;
    dtiInit(dwiFile, t1File, dwiParams);
end