function s_cue11_dtiInit
%
% This function loads a series of subjects and performs dtiInit for each
%

datapath = '/media/lcne/matproc';

subjects = {'tg170423','jc170501','hp170601','rl170603'};

%{
'jb161004','rc161007','se161021','mr161024'
'gm161101','hw161104','ph161104','kd170115'
'er170121','al170316','jd170330','jw170330'
'tg170423','jc170501','hp170601','rl170603'

'ac160415','cm160510','ja160416','jr160507','mp160511','ps160508','rt160420','yl160507'
'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
            'jv151030','ps151001','si151120','sr151031','tf151127','tm161017','vm151031', ...
            'wr151127','zl150930','as160129','bp160213','cs160214','kl160122', ...
            'nb160221','rp160205','ss160205','wh160130'};
%}
for isubj = 1:length(subjects)
    % Build the file names for dwi, bvecs/bvals, t1
    dwiPath = fullfile(datapath, subjects{isubj},'raw');
    dwiFile = fullfile(dwiPath, [subjects{isubj} '.nii.gz']);
    t1File = fullfile(datapath, subjects{isubj}, [subjects{isubj} '_t1_acpc.nii.gz']);

    dwiParams = dtiInitParams;
    dwiParams.clobber = true;
    %dwiParams.eddyCorrect = 0;
    %dwiParams.flipLrApFlag = true;
    dwiParams.dwOutMm = [2, 2, 2];
    %dwiParams.phaseEncodeDir = 1;
    %dwiParams.rotateBvecsWithRx = true;
    dwiParams.rotateBvecsWithCanXform = true;
    dtiInit(dwiFile, t1File, dwiParams);
end