baseDir='/mnt/acorn/abcd/matproc';

%read subjects in from text file
subjects={};
file=fopen('/mnt/acorn/abcd/matproc/scripts/amyg_mask.txt','r');
tline=fgetl(file);
while ischar(tline)
    disp(tline);
    subjects=[subjects, tline];
    tline=fgetl(file);
end

for isubj = 1:length(subjects)
    disp(['creating mask ROI for subject ' subjects{isubj}]);
    l_fg=dtiReadFibers([baseDir '/' subjects{isubj} '/dti60trilin/fibers/mrtrix/outlie_lh_amyg_nacc.mat']);
    r_fg=dtiReadFibers([baseDir '/' subjects{isubj} '/dti60trilin/fibers/mrtrix/outlie_rh_amyg_nacc.mat']);
    l_fg.name='outlie_lh_amyg_nacc'; %alter fiber names to something interpretable for save out
    r_fg.name='outlie_rh_amyg_nacc';
    dtiCreateRoiFromFibers(l_fg, [baseDir '/' subjects{isubj} '/ROIs'], 1);
    dtiCreateRoiFromFibers(r_fg, [baseDir '/' subjects{isubj} '/ROIs'], 1);
    disp(['finished subject ' subjects{isubj}]);
end