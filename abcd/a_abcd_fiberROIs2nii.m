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
    disp(['converting mask ROI to nii for subject ' subjects{isubj}]);
    
    l_ROI=[baseDir '/' subjects{isubj} '/ROIs/outlie_lh_amyg_nacc_fiberROI.mat'];
    r_ROI=[baseDir '/' subjects{isubj} '/ROIs/outlie_rh_amyg_nacc_fiberROI.mat'];
    ref=[baseDir '/' subjects{isubj} '/' subjects{isubj} '_t1_y1_acpc.nii.gz'];
    
    l_nii=dtiRoiNiftiFromMat(l_ROI, ref);
    r_nii=dtiRoiNiftiFromMat(r_ROI, ref);
    
    disp(['finished subject ' subjects{isubj}]);
end