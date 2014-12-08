function fibersPDB = s_finra2_mrtrix_track_between_rois
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

baseDir = '/media/storg/matproc/';

subjects = {'ab071412','bc050913','bk032113','bk053012','ch101612', ...
            'cs050813','dc050213','dp092612','ds080712','ec081912', ...
            'en062813','fg092712','gr051513','hg101012','hm062513', ...
            'jh042913','jl071912','jo081312','jt062413','jw072512', ...
            'kr030113','lc052213','lf052813','lw061713','md072512', ...
            'mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713', ...
            'pw061113','ra053013','rb073112','rb082212','sd040313', ...
            'sh010813','sl080912','sn061213','sp061313','tr101312', ...
            'tw062113','vv060313','wb071812', ...  
            };
        
for isubj = 1:length(subjects)

subjectDir = [subjects{isubj}];
subjectRefImg = [subjects{isubj} '_t1_acpc.nii.gz'];
dtFile = fullfile(baseDir, subjectDir, '/dti96trilin/dt6.mat');
refImg = fullfile(baseDir, subjectDir, subjectRefImg);
fibersFolder = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix');

% Set upt the MRtrix trakign parameters
trackingAlgorithm = {'prob'};
lmax    = [2]; % The appropriate value depends on # of directions. For 32, use lower #'s like 4 or 6. For 70+ dirs, 6 or 10 is good [10];
maxNFibers2try2find  = 500000; % 10000; % this the number of fibers to find
maxNFibers2try = 5000000; %1000000; % this is the max number of fibers to try before giving up
wmMask  = [];

% Make an (include) white matter mask ROI. This mask is the smallest 
% set of white matter that contains both ROIS (fromRois and toRois)
%
% We use a nifti ROi to select the portion of the White matter to use for
% seeding
wmMaskName = fullfile(baseDir, subjectDir, '/dti96trilin/bin/wmMask');

% Then transform the niftis into .mif
[p,f,e] = fileparts(wmMaskName);
wmMaskMifName    = fullfile(p,sprintf('%s.nii.gz',f)); 
%wmMaskNiftiName  = sprintf('%s.nii.gz',wmMaskName);
%mrtrix_mrconvert(wmMaskNiftiName, wmMaskMifName);    

% This first step initializes all the files necessary for mrtrix.
% This can take a long time.
files = mrtrix_init(dtFile,lmax,fibersFolder,wmMask);
    
cd(fibersFolder);
    
% We genenrate and save the fibers in the current folder.
[fibersPDB, status, results] = finra2_mrtrix_wbc_for_contrack(files, ...
     wmMaskMifName, wmMaskMifName, trackingAlgorithm{1}, ...
     maxNFibers2try2find, maxNFibers2try);
    
     %fgWrite(fibersPDB,['fibername'],'pwd')
end

return