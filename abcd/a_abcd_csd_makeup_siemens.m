function a_abcd_csd_makeup_siemens

baseDir='/mnt/acorn/abcd/matproc/makeup_siemens';

%produces subject list:
subjects={};
file=fopen(fullfile('/mnt/acorn/abcd/matproc/makeup_siemens', 'scripts', 'makeup_dti_1.txt'),'r');
tline=fgetl(file);
while ischar(tline)
    %disp(tline);
    subjects=[subjects, tline];
    tline=fgetl(file);
end
fclose(file);
incomplete = {};


for isubj = 1:length(subjects)
    try
        subjectDir    = [subjects{isubj}];
        dtFile = fullfile(baseDir, subjectDir, '/dti60trilin/dt6.mat');
        fibersFolder  = fullfile(baseDir, subjectDir, '/dti60trilin/fibers/mrtrix/');
        lmax    = [6];
        wmMask = [];

        %performs csd on subjects in preparation for fiber tracking
        mrtrix_init(dtFile,lmax,fibersFolder,wmMask);
        
    catch e
        warning(['subject ' subjects{isubj} ' could not be completed']);
        fprintf(1,'The error identifier was:\n%s',e.identifier);
        fprintf(1,'The error message was:\n%s',e.message);
        incomplete = [incomplete, subjects{isubj}];
    end
end

end