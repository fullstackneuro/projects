function fibersPDB = s_plstc_mrtrix_track_amyg_nacc
%
% This functions shows how to track between two ROIS using mrtrix.
% This s very helpful for ideintifying some fiber groups for example the
% optic radiation.
%
% This is how te code works.
% 1. We load two ROIs in the brai, for Shumpei's project for example we
%    will load the right-LGN and the right-Visual cortex
% 2. We create union ROI by combining these two ROIs. The union ROI is used
%    as seeding fro the fibers. mrtrix will initiate and terminate fibers only
%    within the volume defined by the Union ROI.
% 3. We create a white matter mask. THis mask is generally a large portion
%    of the white matter. A portion that contains both union ROIs. For example
%    the right hemisphere.
% 4. We use mrtrix to track between the right-LGN and righ-visual cortex.
% mrtrix will initiate fibers by seeding within the UNION ROI and it will
% only keep fibers that have paths within the white matter masks.
%
% The final result of this script is to generate lot's of canddte fibers 
% that specifically end and start from the ROI of interest. Thisis an 
% approach similar to Contrack. 
%
% INPUTS: none
% OUTPUTS: the finela name of the ROI created at each iteration
%
% Written by Franco Pestilli (c) Stanford University Vistasoft

subjects = {'mm080915_1_hardi3','mm080915_1_hardi4', ...
            'mm080915_2_hardi1','mm080915_2_hardi2','mm080915_2_hardi3','mm080915_2_hardi4', ...
            'nb081015_1_hardi1','nb081015_1_hardi2','nb081015_1_hardi3','nb081015_1_hardi4', ...
            'nb081015_2_hardi1','nb081015_2_hardi2','nb081015_2_hardi3','nb081015_2_hardi4', ...
            'ld080115_1_hardi1','ld080115_1_hardi2','ld080115_1_hardi3','ld080115_1_hardi4', ...
            'ld080115_2_hardi1','ld080115_2_hardi2','ld080115_2_hardi3','ld080115_2_hardi4', ...
            'lp080215_1_hardi1','lp080215_1_hardi2','lp080215_1_hardi3','lp080215_1_hardi4', ...
            'lp080215_2_hardi1','lp080215_2_hardi2','lp080215_2_hardi3','lp080215_2_hardi4', ...
            'lt081615_1_hardi1','lt081615_1_hardi2','lt081615_1_hardi3','lt081615_1_hardi4', ...
            'lt081615_2_hardi1','lt081615_2_hardi2','lt081615_2_hardi3','lt081615_2_hardi4'};
        
%'mm080915_1_hardi1','mm080915_1_hardi2'}';
        
baseDir = '/media/storg/matproc/';

for isubj = 1:length(subjects)
    subjectDir = [subjects{isubj}];
    origSubjName = subjectDir(1:10);
    subjectRefImg = [origSubjName '_t1_acpc.nii.gz'];
    dtFile = fullfile(baseDir, subjectDir, '/dti96trilin/dt6.mat');
    refImg = fullfile(baseDir, subjectDir, subjectRefImg);
    fibersFolder = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix/');
    
    %same anatomical for all DWI runs
    roiDir = fullfile(baseDir, subjects{isubj}(1:10));
    
    % We want to track the cortical pathway (LGN -> V   1/V2 and V1/V2 -> MT)
    fromRois = {'rh_nacc_aseg_fd'};
    toRois   = {'rh_amyg_a2009s_fd'};
    
    % Set up the MRtrix tracking parameters
    trackingAlgorithm = {'prob'};
    lmax    = [10]; % The appropriate value depends on # of directions. For 32, use lower #'s like 4 or 6. For 70+ dirs, 6 or 10 is good [10];
    maxNFibers2try2find  = 5000; % 10000; % this the number of fibers to find
    maxNFibers2try = 500000; %1000000; % this is the max number of fibers to try before giving up
    cutoff = 0.075; %FA cutoff along path
    initcutoff = 0.075; %FA cutoff at seed
    curvature = 1; %curvature radius. formula: angle = 2 * asin (S / (2*R)), S=step-size, R=radius of curvature
    stepsize = 0.2; %voxel-voxel step distance
    wmMask = [];
    
    % Make an (include) white matter mask ROI. This mask is the smallest
    % set of white matter that contains both ROIS (fromRois and toRois)
    %
    % We use a nifti ROi to select the portion of the White matter to use for
    % seeding
    wmMaskName = fullfile(baseDir, subjects{isubj}(1:10), '/ROIs/rh_wmmask_fs_fd');
    [~, wmMaskName] = dtiRoiNiftiFromMat(wmMaskName,refImg,wmMaskName,1);
    
    % Then transform the niftis into .mif
    [p,f,e] = fileparts(wmMaskName);
    wmMaskMifName    = fullfile(p,sprintf('%s.mif',f));
    wmMaskNiftiName  = sprintf('%s.nii.gz',wmMaskName);
    mrtrix_mrconvert(wmMaskNiftiName, wmMaskMifName);
    
    % This first step initializes all the files necessary for mrtrix.
    % This can take a long time.
    files = mrtrix_init(dtFile,lmax,fibersFolder,wmMask);
    
    % Some of the following steps only need to be done once for each ROI,
    % so we want to do some sort of unique operation on the from/toRois
    %individualRois = unique([fromRois, toRois]);
    
    % Convert the ROIs from .mat or .nii.gz to .mif format.
    fromRoiName = fullfile(roiDir, '/ROIs/', fromRois{1});
    [~, fromRoiName] = dtiRoiNiftiFromMat(fromRoiName, refImg, fromRoiName, 1);
    fromRoiMifName    = fullfile(p,sprintf('%s.mif',fromRois{1}));
    fromRoiNiftiName  = sprintf('%s.nii.gz',fromRoiName);
    mrtrix_mrconvert(fromRoiNiftiName, fromRoiMifName);
    
    toRoiName = fullfile(roiDir, '/ROIs/', toRois{1});
    [~, toRoiName] = dtiRoiNiftiFromMat(toRoiName, refImg, toRoiName, 1);
    toRoiMifName    = fullfile(p,sprintf('%s.mif',toRois{1}));
    toRoiNiftiName  = sprintf('%s.nii.gz',toRoiName);
    mrtrix_mrconvert(toRoiNiftiName, toRoiMifName);
        
    %for i_roi = 1:length(individualRois)
    %    if exist(fullfile(p, [individualRois{i_roi}, '.nii.gz']),'file')
    %       thisroi = fullfile(p, [individualRois{i_roi}, '.nii.gz']);
    %
    %  elseif  exist(fullfile(p, [individualRois{i_roi}, '.nii']),'file')
    %     thisroi = fullfile(p, [individualRois{i_roi}, '.nii']);
    %
    %elseif   exist(fullfile(p, [individualRois{i_roi}, '.mat']),'file')
    %     thisroi = fullfile(p, [individualRois{i_roi}, '.mat']);
    %end
    
    %mrtrix_mrconvert(thisroi,refImg);
    %end
    
    % Create joint from/to Rois to use as a mask
    for nRoi = 1:length(toRois)
        % MRTRIX tracking between 2 ROIs template.
        roi{1} = fullfile(roiDir, '/ROIs/', fromRois{1});
        roi{2} = fullfile(roiDir, '/ROIs/', toRois{1});
        
        roi1 = dtiRoiFromNifti([roi{1} '.nii.gz'],[],[],'.mat');
        roi2 = dtiRoiFromNifti([roi{2} '.nii.gz'],[],[],'.mat');
        
        % Make a union ROI to use as a seed mask:
        % We will generate as many seeds as requested but only inside the voume
        % defined by the Union ROI.
        %
        % The union ROI is used as seed, fibers will be generated starting ONLy
        % within this union ROI.
        roiUnion        = roi1; % seed union roi with roi1 info
        roiUnion.name   = ['union of ' roi1.name ' and ' roi2.name]; % r lgn calcarine';
        roiUnion.coords = vertcat(roiUnion.coords,roi2.coords);
        roiName         = fullfile(roiDir, '/ROIs/',[roi1.name '_' roi2.name]);
        [~, seedMask]   = dtiRoiNiftiFromMat(roiUnion,refImg,roiName,1);
        seedRoiNiftiName= sprintf('%s.nii.gz',seedMask);
        seedRoiMifName  = sprintf('%s.mif',seedMask);
        
        % Transform the niftis into .mif
        mrtrix_mrconvert(seedRoiNiftiName, seedRoiMifName);
        
        % We cd into the folder where we want to sae the fibers.
        cd(fibersFolder);
        
        % We genenrate and save the fibers in the current folder.
        [fibersPDB{nRoi}, status, results] = s_gen_mrtrix_track_roi2roi(files, [roi{1} '.mif'], [roi{2} '.mif'], ...
            seedRoiMifName, wmMaskMifName, trackingAlgorithm{1}, ...
            maxNFibers2try2find, maxNFibers2try, cutoff, initcutoff, curvature, stepsize);
        
        %fgWrite(fibersPDB,['fibername'],'pwd')
    end
    
end

return