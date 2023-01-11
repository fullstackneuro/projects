function a_abcd_ants_affine_warp
    
    %NOTE: CURRENTLY VERY INFLEXIBLE. Practice at wrapper building.

    %Add ants directory to path
    system('export PATH=$PATH:~/ANTs/install/bin');
    
    %matproc directory
    matproc='/mnt/acorn/abcd/matproc/GE';
    
    %produces subject list:
    subjects={};
    file=fopen('/mnt/acorn/abcd/matproc/scripts/GE_dwi_c.txt','r'); %use duke subjects to make amyg mask to be used for abcd
    tline=fgetl(file);
    while ischar(tline)
        %disp(tline);
        subjects=[subjects, tline];
        tline=fgetl(file);
    end
    
    %subjects={'NDARINV06A9DLE9'};
    
    for isubj = 1:length(subjects)
        
        disp(['Generating transform files for subject ' subjects{isubj}]);
        
        %setup input filenames
        fixedImage = '/mnt/acorn/abcd/standardROIs/MNI152_T1_1mm_brain.nii.gz';
        movingImage = fullfile(matproc,subjects{isubj},[subjects{isubj} '_t1_y1_acpc.nii.gz']);
        fixedMask = '/mnt/acorn/abcd/standardROIs/MNI152_T1_1mm_brain_mask.nii.gz';
        movingMask = fullfile(matproc,subjects{isubj},'dti60trilin','bin','brainMask.nii.gz');
        outPrefix=fullfile(matproc,subjects{isubj},'sub2MNI');

        %ants registration command for affine and warp transforms. Many settings hard-coded. Look into fixing later.
        cmd = ['antsRegistration -d 3 -o ' outPrefix ' -n Linear -r [' fixedImage ',' movingImage ',1] '...
               '-x [' fixedMask ',' movingMask '] -t Rigid[0.1] -m MI[' fixedImage ',' movingImage ',1,32,Regular,0.25] '...
               '-c [500x250x125,1e-6,10] -s 8x4x2 -f 8x4x2 -t Affine[0.1] -m MI[' fixedImage ',' movingImage ',1,32,Regular,0.25] '...
               '-c [500x250x125,1e-6,10] -s 8x4x2 -f 8x4x2 -t SyN[0.25] -m CC[' fixedImage ',' movingImage ',1,4] '...
               '-c [500x250x125,1e-6,10] -s 8x4x2 -f 8x4x2'];

        %run registration
        system(cmd);
        
        disp(['Finished subject ' subjects{isubj}]);
        
    end
end