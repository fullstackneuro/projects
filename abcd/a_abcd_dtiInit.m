function a_abcd_dtiInit
%
% This function loads a series of subjects and performs dtiInit for each
% one of them
%
datapath='/mnt/acorn/abcd/matproc';

%produces subject list:
subjects={};
file=fopen(fullfile(datapath, 'scripts', 'dummy.txt'),'r');
tline=fgetl(file);
while ischar(tline)
    %disp(tline);
    subjects=[subjects, tline];
    tline=fgetl(file);
end
fclose(file);

disp(length(subjects));

incomplete={};
    
for isubj = 1:length(subjects) %determine length, then subdivide between terminals
    try
        % Build the file names for dwi, bvecs/bvals
        %dwiPath = dir(fullfile(datapath,subjects{iSbj},'*DTI*'));
        dwiPath = fullfile(datapath,subjects{isubj},'raw');
        dwiFile = dir(fullfile(dwiPath,[subjects{isubj} '_dwi_y1.nii.gz']));
        %dwiFile = fullfile(datapath,subjects{iSbj},dwiFile.name);
        %dwiBvec = [dwiFile(1:end-6),'bvec'];
        %dwiBval = [dwiFile(1:end-6),'bval'];
        t1Path = dir(fullfile(datapath,subjects{isubj},[subjects{isubj} '_t1_y1_acpc.nii.gz']));
        t1File = fullfile(datapath,subjects{isubj},t1Path.name);

        cd(fullfile(dwiPath))
        dwiParams = dtiInitParams;
        dwiParams.dwOutMm = [1.7, 1.7, 1.7];
        dwiParams.phaseEncodeDir = 2;
        dwiParams.rotateBvecsWithCanXform = true;

        %SET TO ZERO UNLESS REPLACING
        dwiParams.clobber = 0;

        dtiInit(dwiFile.name, t1File, dwiParams);

    catch e
        warning(['subject ' subjects{isubj} ' has needed files, but could not be completed']);
        fprintf(1,'The error identifier was:\n%s',e.identifier);
        fprintf(1,'The error message was:\n%s',e.message);
        incomplete = [incomplete, subjects{isubj}];
    end
end
