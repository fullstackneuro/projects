%% script to make fiber density maps

% this script:

% assumes createFiberDensityFiles_script has already been run. It takes the
% single subject output files from that script, combines the maps into a 4d
% nifti (along with a mean) and saves it out. 



%% define directories and file names, load files


clear all
close all

dataDir = '/mnt/acorn/abcd/matproc';

%generate subject list based on who has fg_density files
%{
subFiles=dir(fullfile(dataDir,'NDAR*'));
subjects={};
for isubj = 1:numel(subFiles)
    lh_fg_density_loc = [dataDir '/' subFiles(isubj).name '/fg_densities/outlie_lh_ains_nacc_mni.nii.gz'];
    rh_fg_density_loc = [dataDir '/' subFiles(isubj).name '/fg_densities/outlie_rh_ains_nacc_mni.nii.gz'];
    if exist(lh_fg_density_loc,'file') == 2 && exist(rh_fg_density_loc, 'file') == 2
        subjects=[subjects, subFiles(isubj).name];
    end
end
%}

subjects={'NDARINV00HEV6HB', 'NDARINV00UMK5VC'};

hemi={'lh','rh'};
for h = 1:length(hemi) %loop across hemispheres
    
    % directory (relative to subject dir) that has fiber density files
    inDir = fullfile(dataDir,'%s','fg_densities');  %s is subject id

    inFdFileName = ['outlie_' hemi{h} '_ains_nacc_mni']; % file name without the .nii.gz extension

    % directory to save out group files
    outDir = fullfile(dataDir,'fg_densities');


    %% get to it
    
    %creates outDir if it doesn't already exist (under matproc)
    if ~exist(outDir,'dir')
        mkdir(outDir)
    end

    % load subjects' nifti files & concatenate them
    niis=cellfun(@(x) niftiRead(fullfile(sprintf(inDir,x),[inFdFileName '.nii.gz'])), subjects, 'uniformoutput',1);
    fdImgs ={niis(:).data};
    fdImgs=cell2mat(reshape(fdImgs,1,1,1,[])); % concat subjects in 4th dim


    % save out new nifti file of all subjects' data
    outNii=createNewNii(niis(1),fullfile(outDir,[inFdFileName '_ALL.nii.gz']),fdImgs);
    writeFileNifti(outNii);


    % save out nifti file of the mean across subjects
    outNii.data=mean(outNii.data,4);
    outNii.fname=fullfile(outDir,[inFdFileName '_MEAN.nii.gz']);
    writeFileNifti(outNii);

end %hemispheres


