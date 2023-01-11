%% Make fiber density maps

% saves out niftis with values that represent whether fibers go through
% that voxel and if so, how many. Scaled to have a max value of 1.

%
% NOTE: if mergeLR=1, this script first saves out the L and R fiber density
% maps, then xforms them to group space and normalizes them so that they
% each have a max value of 1, then combines L and R sides.




%% define directories and file names, load files


clear all
close all

dataDir = '/mnt/acorn/abcd/matproc';

%generate subject list based on who has outlie files
subFiles=dir(fullfile(dataDir,'NDAR*'));
subjects={};
for isubj = 1:numel(subFiles)
    lh_outlie_ains_nacc_loc = [dataDir '/' subFiles(isubj).name '/dti60trilin/fibers/mrtrix/outlie_lh_ains_nacc.mat'];
    rh_outlie_ains_nacc_loc = [dataDir '/' subFiles(isubj).name '/dti60trilin/fibers/mrtrix/outlie_rh_ains_nacc.mat'];
    affine_loc = [dataDir '/' subFiles(isubj).name '/MNI0GenericAffine.mat'];
    if exist(lh_outlie_ains_nacc_loc,'file') == 2 && exist(rh_outlie_ains_nacc_loc, 'file') == 2 && exist(affine_loc, 'file') == 2
        subjects=[subjects, subFiles(isubj).name];
    end
end

%subjects={'NDARINV00CY2MDM','NDARINV00HEV6HB', 'NDARINV00UMK5VC'};

hemi={'lh','rh'};

for h = 1:length(hemi) %loop across hemispheres

    % seed and target ROIs are loaded to make sure that all the streamlines are
    % oriented in the same direction; this step can be omitted if you're
    % already sure of that
    seedRoiFile = fullfile(dataDir,'%s','ROIs',[hemi{h} '_antshortins_fd.nii.gz']); %s is subject id

    targetRoiFile = fullfile(dataDir,'%s','ROIs',[hemi{h} '_nacc_aseg_fd.nii.gz']);

    % fiber file to convert into a fiber density file
    % note: this doesn't have to be in .pdb format; any format that the function
    % fgRead() can load in should be fine
    fgFile = fullfile(dataDir,'%s','dti60trilin','fibers','mrtrix',['outlie_' hemi{h} '_ains_nacc.mat']);


    % t1 file in dti/native space
    t1File = fullfile(dataDir,'%s','%s_t1_y1_acpc.nii.gz'); %s is subject id

    % subject-specific xforms for native > mni space
    xform_aff=fullfile(dataDir,'%s','MNI0GenericAffine.mat');
    %xform_warp=fullfile(dataDir,'%s','t1','t12mni_xform_Warp.nii.gz');


    % define fg_densities directory (directory to save out file to)
    fdDir = fullfile(dataDir,'%s','fg_densities');  %s is subject id


    outFdFileName = ''; % if this is left blank, the outfile will have the same name as the fgFile (with a .nii.gz extension)

    % options
    smooth = 0; % 0 or empty to not smooth, otherwise this defines the smoothing kernel




    %% get to it


    i=1;
    for i=1:numel(subjects)

        subject = subjects{i};

        fprintf(['\n\n Working on subject ',subject,'...\n\n']);


        % define fg_densities directory; create if necessary
        thisFdDir = sprintf(fdDir,subject);
        if (~exist(thisFdDir, 'dir'))
            mkdir(thisFdDir)
        end


        % load t1 volume
        t1 = niftiRead(sprintf(t1File,subject,subject));


        % load seed and target rois
        roi1 = roiNiftiToMat(sprintf(seedRoiFile,subject));
        roi2 = roiNiftiToMat(sprintf(targetRoiFile,subject));

        % load fiber group
        fg = fgRead(sprintf(fgFile,subject));

        % reorient to make sure all fibers start in roi1 and end in roi2
        [fg,flipped] = AFQ_ReorientFibers(fg,roi1,roi2);

        % define out name for fiber density file
        if isempty(outFdFileName)
            [~,outName]=fileparts(fgFile);
        else
            outName = outFdFileName;
        end


        % make fiber density maps using vistasoft function
        %fdImg = dtiComputeFiberDensityNoGUI(fgs,xform,imSize,normalize,fgNum, endptFlag, fgCountFlag, weightVec, weightBins)
        fd = dtiComputeFiberDensityNoGUI(fg, t1.qto_xyz,size(t1.data),1,1,0);

        % save new fiber density file in native space
        outPath = fullfile(thisFdDir,outName);
        nii=createNewNii(t1,fd,outPath,'fiber density');
        writeFileNifti(nii);


        % xform to standard space
        inFile=[outPath '.nii.gz'];
        outFile=[outPath '_mni.nii.gz'];
        outNii=xformANTs(inFile,outFile,sprintf(xform_aff,subject));

        % Smooth the image?
        if smooth
            outNii.data = smooth3(outNii.data, 'gaussian', smooth);
        end

        % scale to have max value of 1 in group space
        outNii.data=outNii.data./max(outNii.data(:));

        % save out fiber density file in group space
        writeFileNifti(outNii);


        fprintf(['done with subject ' subjects{i} '.\n\n']);


    end % subjects
end %hemispheres






