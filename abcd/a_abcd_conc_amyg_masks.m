%add fsl directory to path
system('export PATH=$PATH:~/usr/local/fsl/bin');

%matproc directory
matproc='/mnt/acorn/cylon/matproc';
abcd_matproc='/mnt/acorn/abcd/matproc';

%produces subject list:
subjects={};
file=fopen('/mnt/acorn/cylon/matproc/all_amyg_mask.txt','r');
tline=fgetl(file);
while ischar(tline)
    %disp(tline);
    subjects=[subjects, tline];
    tline=fgetl(file);
end

%binarize all mni mask files
%{
for isubj = 1:length(subjects)
    
    disp(['binarizing masks for subject ' subjects{isubj}]);
    
    lh_ROI=fullfile(matproc, subjects{isubj}, 'ROIs', 'lh_amyg_nacc_fiberROI_mni.nii.gz');
    rh_ROI=fullfile(matproc, subjects{isubj}, 'ROIs', 'rh_amyg_nacc_fiberROI_mni.nii.gz');
    lh_output=fullfile(matproc, subjects{isubj}, 'ROIs', 'lh_amyg_nacc_fiberROI_mni_bin.nii.gz'); %bin for binarized
    rh_output=fullfile(matproc, subjects{isubj}, 'ROIs', 'rh_amyg_nacc_fiberROI_mni_bin.nii.gz');
    
    lh_cmdstring = ['fslmaths ' lh_ROI ' -bin ' lh_output];
    rh_cmdstring = ['fslmaths ' rh_ROI ' -bin ' rh_output];
    
    disp(lh_cmdstring);
    system(lh_cmdstring);
    disp(rh_cmdstring);
    system(rh_cmdstring);
    
    disp(['masks binarized for subject ' subjects{isubj}]);
    
end
%}

%concatenate all mni mask files
hem={'lh','rh'};
for h = 1:length(hem)
    cmdstring='fslmaths ';
    output=fullfile(abcd_matproc, 'masks', 'amygnacc', [hem{h} '_amyg_nacc_c.nii.gz']); %c for concatenated
    for isubj = 1:length(subjects)
        roiPath=fullfile(matproc, subjects{isubj}, 'ROIs', [hem{h} '_amyg_nacc_fiberROI_mni_bin.nii.gz']);
        if isubj==length(subjects)
           cmdstring=[cmdstring roiPath ' ' output]; 
        else
           cmdstring=[cmdstring roiPath ' -add ']; 
        end
    end
    disp(cmdstring);
    system(cmdstring);
end

%divide mask values by number of subs
lh_mask=fullfile(abcd_matproc, 'masks', 'amygnacc', 'lh_amyg_nacc_c.nii.gz');
rh_mask=fullfile(abcd_matproc, 'masks', 'amygnacc', 'rh_amyg_nacc_c.nii.gz');
lh_output=fullfile(abcd_matproc, 'masks', 'amygnacc', 'lh_amyg_nacc_cn.nii.gz'); %n for normalized
rh_output=fullfile(abcd_matproc, 'masks', 'amygnacc', 'rh_amyg_nacc_cn.nii.gz');

lh_cmdstring=['fslmaths ' lh_mask ' -div 146 ' lh_output]; %146 is the number of subjects used to make mask
rh_cmdstring=['fslmaths ' rh_mask ' -div 146 ' rh_output];
disp(lh_cmdstring);
system(lh_cmdstring);
disp(rh_cmdstring);
system(rh_cmdstring);



