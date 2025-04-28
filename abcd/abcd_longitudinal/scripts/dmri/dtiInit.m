function dtiInit(bidsDir, matprocDir, subFiles)
    
    %for testing:
    %bidsDir='/mnt/acorn/ethan/bids';
    %matprocDir='/mnt/acorn/ethan/matproc';
    %subFiles='/mnt/acorn/ethan/scripts/anat/subs.txt';

    %produce subject list:
    str = fileread(subFiles);
    subjects = regexp(str, '\n', 'split');
    subjects = subjects(~cellfun('isempty',subjects));
    
    

    %loop across subjects:
    for sub=1:length(subjects)
       
        %establish subject-level paths
        rawName=subjects{sub};
        subName=['sub-' rawName(1:15)];
        timePoint=['ses-' rawName(17:34)];
        
        %establish path to raw 3000 shell dwi data
        dwiPath=fullfile(matprocDir, subName, timePoint, 'raw');
        dwiFileName = dir(fullfile(dwiPath, '*dwi.nii.gz'));
        dwiFile=fullfile(dwiPath, dwiFileName(1).name);
        
        %copy over subject acpc t1 from bids
        copyfile(fullfile(bidsDir, subName, timePoint, 'anat', 'acpc', 'output', 't1.nii.gz'), ...
                fullfile(matprocDir, subName, timePoint, [subName '_t1_acpc.nii.gz']))
        t1File=fullfile(matprocDir, subName, timePoint, [subName '_t1_acpc.nii.gz']);
        cd(fullfile(matprocDir, subName, timePoint));

        %initialize dwi parameters for dtiInit pass-in
        dwiParams = dtiInitParams;
        dwiParams.dwOutMm = [1.7, 1.7, 1.7];
        dwiParams.phaseEncodeDir = 2;
        dwiParams.rotateBvecsWithCanXform = true; 
        dwiParams.outDir = fullfile(matprocDir, subName, timePoint);

        %SET TO ZERO UNLESS REPLACING
        dwiParams.clobber = 1;

        %begin dtiInit
        dtiInit(dwiFile, t1File, dwiParams);
        
    end
end