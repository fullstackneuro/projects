%Add ants directory to path
system('export PATH=$PATH:~/opt/ANTS/bin');

%matproc directory
matproc='/mnt/acorn/abcd/matproc';

%produces subject list:
subjects={};
file=fopen('/mnt/acorn/abcd/matproc/scripts/GE_xform.txt','r');
tline=fgetl(file);
while ischar(tline)
    %disp(tline);
    subjects=[subjects, tline];
    tline=fgetl(file);
end

%for testing
%subjects={'NDARINV2FV7FT02'};

hem={'lh','rh'};

for isubj = 1:length(subjects)
    
    disp(['inverse xforming mask for subject ' subjects{isubj}]);
    
    for h = 1:length(hem)
        fixedImage=fullfile(matproc, 'GE', subjects{isubj}, [subjects{isubj} '_t1_y1_acpc.nii.gz']);
        movingImage=fullfile(matproc, 'masks', 'vtanacc', [hem{h} '_vta_nacc_mni_bin.nii.gz']);
        affine=fullfile(matproc, 'GE', subjects{isubj}, 'sub2MNI0GenericAffine.mat');
        warp=fullfile(matproc, 'GE', subjects{isubj}, 'sub2MNI1InverseWarp.nii.gz');
        output=fullfile(matproc, 'GE', subjects{isubj}, 'ROIs', [hem{h} '_vta_nacc_mask.nii.gz']);
        
        cmdString=['antsApplyTransforms -d 3 -i ' movingImage ' -r ' fixedImage ' -t [' affine ',1] -t ' warp ' -o ' output];
        system(cmdString);
        
        %binarize
        disp(['Binarizing mask for subject ' subjects{isubj}]);
        roi = niftiRead(output);
        roi.data(roi.data~=0)=1;
        writeFileNifti(roi);

        %also convert to mat file for contrack
        roiNiftiToMat(output,1);
        
    end
    
    disp(['finished subject ' subjects{isubj}]);
end