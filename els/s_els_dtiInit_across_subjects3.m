function s_els_dtiInit_across_subjects3
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
%'els009','els012','els034','els040','els058','els059', ...
%            'els060','els061','els062','els075','els086','els089','els090', ...
%            'els092','els095','els097','els099','els100'};

subjects = {'els125','els127','els130','els132','els134','els136','els137'};
%{
'els103','els106','els107','els111','els112','els113','els114'
'els115','els116','els117','els118','els121','els122','els124', ...
            , ...
            'els139','els140','els145','els147','els148','els149','els151', ...
            'els154','els155','els156','els157','els162','els163','els164', ...
            'els165','els166','els171'};
%}
        
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