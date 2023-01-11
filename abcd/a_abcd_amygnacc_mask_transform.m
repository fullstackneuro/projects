%Add ants directory to path
system('export PATH=$PATH:~/home/ark/ANTs/install/bin')

%matproc directory
matproc='/mnt/acorn/cylon/matproc';

%produces subject list:
subjects={};
file=fopen('/mnt/acorn/cylon/matproc/dnd_amyg_mask.txt','r');
tline=fgetl(file);
while ischar(tline)
    %disp(tline);
    subjects=[subjects, tline];
    tline=fgetl(file);
end

%subjects={'val002'}; %for testing

for isubj = 1:length(subjects)

    disp(['Transforming mask files for subject ' subjects{isubj}]);
    
    %input files
    l_mask=fullfile(matproc,subjects{isubj},'ROIs','lh_amyg_nacc_fiberROI.nii.gz');
    r_mask=fullfile(matproc,subjects{isubj},'ROIs','rh_amyg_nacc_fiberROI.nii.gz');
    affine=fullfile(matproc,subjects{isubj},'sub2MNI0GenericAffine.mat');
    warp=fullfile(matproc,subjects{isubj},'sub2MNI1Warp.nii.gz');
    l_output=fullfile(matproc,subjects{isubj},'ROIs','lh_amyg_nacc_fiberROI_mni.nii.gz');
    r_output=fullfile(matproc,subjects{isubj},'ROIs','rh_amyg_nacc_fiberROI_mni.nii.gz');
    
    %generate commands
    l_cmd = ['WarpImageMultiTransform 3 ' l_mask ' ' l_output ' ' warp ' ' affine];
    r_cmd = ['WarpImageMultiTransform 3 ' r_mask ' ' r_output ' ' warp ' ' affine];
    
    %transform mask
    system(l_cmd);
    system(r_cmd);

    disp(['Finished subject ' subjects{isubj}]);

end