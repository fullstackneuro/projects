function fibersPDB = s_cue_mrtrix_track_dlpfc_caudate
%
% This functions shows how to track between two ROIS using mrtrix.
% This si very helpful for ideintifying some fiber groups for example the
% optic radiation.
%
% This is how the code works.
% 1. We load two ROIs in the brain, for Shumpei's project for example we
%    will load the right-LGN and the right-Visual cortex
% 2. We create union ROI by combining these two ROIs. The union ROI is used
%    as seeding for the fibers. mrtrix will initiate and terminate fibers only
%    within the volume defined by the Union ROI.
% 3. We create a white matter mask. This mask is generally a large portion
%    of the white matter. A portion that contains both union ROIs. For example
%    the right hemisphere.
% 4. We use mrtrix to track between the right-LGN and righ-visual cortex.
%    mrtrix will initiate fibers by seeding within the UNION ROI and it will 
%    only keep fibers that have paths within the white matter masks.
%
% The final result of this script is to generate lot's of candidate fibers 
% that specifically end and start from the ROI of interest. This is a similar 
% approach to Contrack. 
%
% INPUTS: none
% OUTPUTS: the final name of the ROI created at each iteration
%
% Written by Franco Pestilli (c) Stanford University Vistasoft

baseDir = '/media/lcne/matproc/';

subjects = {'at160601','cg160715','jf160703','lm160914','mr170621','nc160905','rf170610', ...
            'rs160730','rv160413','tj160529','zm160627'};
%{
lcne done
'jb161004','rc161007','se161021','mr161024', ...
            'gm161101','hw161104','ph161104','kd170115', ...
            'er170121','al170316','jd170330','jw170330', ...
            'tg170423','jc170501','hp170601','rl170603'
lcne
'am160914','cm160510','ja160416','ps160508','rt160420','yl160507','ac160415', ...
'ag151024','aa151010','al151016','dw151003','ie151020','ja151218', ...
'jh160702','jr160507','kn160918','ld160918','li160927','mp160511'
?'tm160117',
storg
'bb160402','bp160213','jc160320','jc160321','jg151121','jn160403','pk160319', ...
'ps151001','rb160407','rf160313','rp160205','si151120','sr151031','ss160205', ...
'tf151127','vm151031','wh160130','wr151127','zl150930','jw160316','as160129', ...
'cs160214','kl160122','jv151030',
%}

hemis = {'lh','rh'};
            
for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    subjectRefImg = [subjects{isubj} '_t1_acpc.nii.gz'];
    dtFile = fullfile(baseDir, subjectDir, '/dti96trilin/dt6.mat');
    refImg = fullfile(baseDir, subjectDir, subjectRefImg);
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix/');
    roiFolder = fullfile(baseDir, subjectDir, 'ROIs');
       
    % We want to track the subcortical pathway
    fromRois = '_caud_aseg';
    toRois   = {'_frontorb_a2009s_fd','_frontmidlat_a2009s_fd'};
    wmMaskFS = '_wmmask_fs_fd';       
    
    % Set up the MRtrix tracking parameters
    trackingAlgorithm = {'prob'};
    lmax    = [10]; % The appropriate value depends on # of directions. For 32, use lower #'s like 4 or 6. For 70+ dirs, 6 or 10 is good [10];
    maxNFibers2try2find  = 5000; % 10000; % this the number of fibers to find
    maxNFibers2try = 500000; %1000000; % this is the max number of fibers to try before giving up
    cutoff = 0.1; %FA cutoff along path
    initcutoff = 0.1; %FA cutoff at seed
    curvature = 1; %curvature radius. formula: angle = 2 * asin (S / (2*R)), S=step-size, R=radius of curvature
    stepsize = 0.2; %voxel-voxel step distance
    wmMask = [];
    
    for hemi = 1:length(hemis)
        fromRoiHemi = [hemis{hemi} fromRois];
        wmMaskHemi = [hemis{hemi} wmMaskFS];
        wmMaskName = fullfile(roiFolder, wmMaskHemi);
    
        % Make an (include) white matter mask ROI. This mask is the smallest
        % set of white matter that contains both ROIS (fromRois and toRois)
        %
        % We use a nifti ROi to select the portion of the White matter to use for
        % seeding
        [~, wmMaskName] = dtiRoiNiftiFromMat(wmMaskName,refImg,wmMaskName,1);
        
        % Then transform the niftis into .mif
        [p,f,e] = fileparts(wmMaskName);
        wmMaskMifName    = fullfile(p,sprintf('%s.mif',f));
        wmMaskNiftiName  = sprintf('%s.nii.gz',wmMaskName);
        mrtrix_mrconvert(wmMaskNiftiName, wmMaskMifName);
        
        % This first step initializes all the files necessary for mrtrix.
        % This can take a long time.
        files = mrtrix_init(dtFile,lmax,fibersFolder,wmMask);
        
        % Convert the ROIs from .mat or .nii.gz to .mif format.
        fromRoiName = fullfile(baseDir, subjectDir, '/ROIs/', fromRoiHemi);
        [~, fromRoiName] = dtiRoiNiftiFromMat(fromRoiName, refImg, fromRoiName, 1);
        fromRoiMifName    = fullfile(p,sprintf('%s.mif',fromRoiHemi));
        fromRoiNiftiName  = sprintf('%s.nii.gz',fromRoiName);
        mrtrix_mrconvert(fromRoiNiftiName, fromRoiMifName);
        
        % loop across toRois, must recreate hemisphere name
        for i_roi = 1:length(toRois)
            toRoiHemi = [hemis{hemi} toRois{i_roi}];
            toRoiName = fullfile(baseDir, subjectDir, '/ROIs/', toRoiHemi);
            [~, toRoiName] = dtiRoiNiftiFromMat(toRoiName, refImg, toRoiName, 1);
            toRoiMifName    = fullfile(p,sprintf('%s.mif',toRoiHemi));
            toRoiNiftiName  = sprintf('%s.nii.gz',toRoiName);
            mrtrix_mrconvert(toRoiNiftiName, toRoiMifName);
        end
        
        % Create joint from/to Rois to use as a mask
        for nRoi = 1:length(toRois)
            % MRTRIX tracking between 2 ROIs template.
            roi{1} = fullfile(baseDir, subjectDir, '/ROIs/', fromRoiHemi);
            % loop across toRois, must recreate hemisphere name
            toRoiHemi = [hemis{hemi} toRois{nRoi}];
            roi{2} = fullfile(baseDir, subjectDir, '/ROIs/', toRoiHemi);
            
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
            roiName         = fullfile(baseDir, subjectDir, '/ROIs/',[roi1.name '_' roi2.name '_union']);
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
end

return