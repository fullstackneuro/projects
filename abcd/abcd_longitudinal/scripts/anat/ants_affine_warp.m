function ants_affine_warp(matprocDir, templateDir, sublist)
    
    %NOTE: CURRENTLY VERY INFLEXIBLE.

    %Add ants install directory to path
    system('export PATH=$PATH:~/ANTs/install/bin');
    
    %for testing:
    %matprocDir='/mnt/acorn/ethan/matproc';
    %sublist='/mnt/acorn/ethan/scripts/anat/subs.txt';
    
    
    str = fileread(sublist);
    sublist = regexp(str, '\n', 'split');
    sublist = sublist(~cellfun('isempty',sublist));
    
    for isubj = 1:length(sublist)
        
        %establish subject-level paths
        rawName=sublist{isubj};
        subName=['sub-' rawName(1:15)];
        timePoint=['ses-' rawName(17:34)];        
        
        
        disp(['Generating transform files for subject ' subName]);
        
        if isdir(fullfile(matprocDir, subName, timePoint, 'dti60trilin'))
            trilin_folder='dti60trilin';
        else
            trilin_folder='dti59trilin';
        end
        
        %setup input filenames
        fixedImage = fullfile(templateDir, 'nihpd_sym_04.5-18.5_t1w.nii');
        movingImage = fullfile(matprocDir,subName,timePoint,[subName '_t1_acpc.nii.gz']);
        fixedMask = fullfile(templateDir, 'nihpd_sym_04.5-18.5_mask.nii');
        movingMask = fullfile(matprocDir,subName,timePoint,trilin_folder,'bin','brainMask.nii.gz');
        outPrefix=fullfile(matprocDir,subName,timePoint,'sub2nihpd');

        %ants registration command for affine and warp transforms. Many settings hard-coded. Look into fixing later.
        cmd = ['antsRegistration -d 3 -o ' outPrefix ' -n Linear -r [' fixedImage ',' movingImage ',1] '...
               '-x [' fixedMask ',' movingMask '] -t Rigid[0.1] -m MI[' fixedImage ',' movingImage ',1,32,Regular,0.25] '...
               '-c [500x250x125,1e-6,10] -s 8x4x2 -f 8x4x2 -t Affine[0.1] -m MI[' fixedImage ',' movingImage ',1,32,Regular,0.25] '...
               '-c [500x250x125,1e-6,10] -s 8x4x2 -f 8x4x2 -t SyN[0.25] -m CC[' fixedImage ',' movingImage ',1,4] '...
               '-c [500x250x125,1e-6,10] -s 8x4x2 -f 8x4x2'];

        %run registration
        system(cmd);
        
        disp(['Finished subject ' subName]);
        
    end
end