function s_els_dtiInit_across_subjects
%
% This function loads a series of subjects and performs dtiInit for each
% one of them
%

datapath = '/media/storg/matproc';
% dti raw faulty? {'els006','els009','els012',}
% no dti 'els060'
% dti incomplete 'els029'
% done       'els013','els014','els016','els017', ...
%            'els024','els025','els026','els028','els032','els033','els034', ...
%            'els039','els041','els042','els045','els046','els047','els048', ...
%            'els049','els050','els053','els054','els055','els056','els057', ...
%            'els064','els065','els067','els068','els069','els070', ...
%            'els072','els073','els074','els076','els077','els079','els081', ...
%            'els083','els085','els087','els088','els093'};
%        els006',
subjects = {'els009','els012','els034','els040','els058','els059', ...
            'els060','els061','els062','els075','els086','els089','els090', ...
            'els092','els095','els097','els099','els100'};

        
for isubj = 1:length(subjects)
    % Build the file names for dwi, bvecs/bvals
    %dwiPath = dir(fullfile(datapath,subjects{iSbj},'*DTI*'));
    dwiPath = fullfile(datapath,subjects{isubj},'raw');
    dwiFile = fullfile(dwiPath,sprintf('%s.nii',subjects{isubj}));
    
    %dwiFile = fullfile(datapath,subjects{iSbj},dwiFile.name);
    %dwiBvec = [dwiFile(1:end-6),'bvec'];
    %dwiBval = [dwiFile(1:end-6),'bval'];
    t1Path = dir(fullfile(datapath,subjects{isubj},'*t1_acpc.nii.gz'));
    t1File = fullfile(datapath,subjects{isubj},t1Path.name);

    dwiParams = dtiInitParams;
    dwiParams.dwOutMm = [2, 2, 2];
    dwiParams.phaseEncodeDir = 1;
    
    dtiInit(dwiFile, t1File, dwiParams);
end