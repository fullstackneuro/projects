function mfb_convert_wbc_pdb2mat

%script to convert wbc.pdb to wbc.mat
%
%
subjects = {'mfb0037'};

baseDir   = '/media/storg/temproc';

for isubj = 1:length(subjects)
    
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir);
    wbc_pdb   = dir(fullfile(mrtrixDir, ['*' 'PROB.pdb']));
    wbc       = fgRead(fullfile(mrtrixDir,wbc_pdb.name));
    saveDir   = fullfile(mrtrixDir, 'lmax6_wbc');
    fgWrite(wbc,saveDir,'mat');
    clear wbc
end