function ants_inverse_xform(matprocDir, templateDir, sublist) 

    %Add ants install directory to path
    system('export PATH=$PATH:~/ANTs/install/bin');

    %generate subject list from textfile
    str = fileread(sublist);
    sublist = regexp(str, '\n', 'split');
    sublist = sublist(~cellfun('isempty',sublist));

    %loop through hemispheres and ROIs.
    hem={'lh','rh'};
    ROIs={'vtapbp_nihpd','vta_nacc_nihpd_bin01_1mm_fd_clip', 'ains_nacc_nihpd_bin03_fd'}; %right now, includes Pauli vta roi, and masks for vta-nacc and ains-nacc tracts

    for isubj = 1:length(sublist)

        %establish subject-level paths
        rawName=sublist{isubj};
        subName=['sub-' rawName(1:15)];
        timePoint=['ses-' rawName(17:34)];

        disp(['inverse xforming ROIs for subject ' subName]);

        for h = 1:length(hem)
            for r = 1:length(ROIs)
                
                %setup
                fixedImage=fullfile(matprocDir, subName, timePoint, [subName '_t1_acpc.nii.gz']);
                movingImage=fullfile(templateDir, [hem{h} '_' ROIs{r} '.nii.gz']);
                affine=fullfile(matprocDir, subName, timePoint, 'sub2nihpd0GenericAffine.mat');
                warp=fullfile(matprocDir, subName, timePoint, 'sub2nihpd1InverseWarp.nii.gz'); %use inverse
                output=fullfile(matprocDir, subName, timePoint, 'ROIs', [hem{h} '_' ROIs{r} '.nii.gz']);

                %construct the ANTs command string
                cmdString=['antsApplyTransforms -d 3 -i ' movingImage ' -r ' fixedImage ' -t [' affine ',1] -t ' warp ' -o ' output];
                %run the command string
                system(cmdString);

                %binarize
                disp(['Binarizing mask for subject ' subName]);
                roi = niftiRead(output);
                roi.data(roi.data~=0)=1;
                writeFileNifti(roi);

                %also convert to mat file for contrack
                roiNiftiToMat(output,1);
            end

        end

        disp(['finished subject ' subName]);
    end

end