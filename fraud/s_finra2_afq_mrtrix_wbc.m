function s_finra2_afq_mrtrix_wbc
%import mrtrix wbc to afq
%export tract profiles of 20 afq tracts

baseDir = '/media/storg/matproc';
     
subjects = {'bk032113','ch101612','cs050813', ...
            'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            'gr051513','hg101012','hm062513','jh042913','jl071912','jo081312', ...
            'jt062413','jw072512','kr030113','lc052213','lf052813','lw061713', ...
            'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'};
            % 'ab071412','bc050913'
            
for isubj = 1:length(subjects)
    subDir   = fullfile(baseDir,subjects{isubj});
    dt6Dir   = fullfile(subDir,'dti96trilin');
    fiberDir = fullfile(subDir,'dti96trilin/fibers/mrtrix');
    
    dtFile = fullfile(dt6Dir,'dt6.mat');
    fibersFileName2Load = fullfile(fiberDir, 'lmax10_wbc.mat');
    
    fg = fgRead(fibersFileName2Load);
    % Segment the fibers using AFQ
    [fg_classified,~,classification]= AFQ_SegmentFiberGroups(dtFile, fg);
    
    % Split the fiber groups into individual groups
    fascicles = fg2Array(fg_classified);
    
    % Clean the fibers, we apply the same trhesholds to all fiber
    % groups this is the default thrshold used by AFQ. This is done by
    % not passing opts
    [fascicles, classification] = feAfqRemoveFascicleOutliers(fascicles,classification);
    
    % Save the segemented fascicles and the indices into the Mfiber
    fibersInfoToSaveDir = fullfile(subDir,'/dti96trilin/fibers/afq');
    mkdir(fibersInfoToSaveDir)
    fibersInfoToSaveName =  fullfile(fibersInfoToSaveDir,['lmax10_wbc','-AFQ','.mat']);
    save(fibersInfoToSaveName,'fg_classified','classification','fascicles')
end

end

function [fascicles, classification] = feAfqRemoveFascicleOutliers(fascicles,classification,opts)
%
% Removes the outliers in a group of fascicles.
%
% [fascicles classification] = feAfqRemoveFascicleOutliers(fascicles,classification,opts)
%
% INPUTS:
%    fascicles      - a set of fascicles created using feAfqSegment.m
%    classification - a classification strucutre created using
%                     feAfqSegment.m
%    opts           - default options for cleaning the outliers in the
%                     fascicle.
%
% OUTPUTS:
%    fascicles      - a set of fascicles as created by feAfqSegment.m
%                     but withut Outliers.
%    classification - a classification strucutre as created using
%                     feAfqSegment.m, but without outliers
%
% NOTEs: it requres AFQ to be on path.
%
% Copyright Franco Pestilli Stanford University 2014

% Parameters for the outliers removal process.
if notDefined('opts')
  opts.stdCutOff   = 3;   % Standard deviation fo the 3D gaussian distribution used to
  % represent the fascicle when removing outliers. 3.5 z-scores
  opts.maxLen      = 25;  % Max lenght of fibers to be accepted in cm
  opts.maxNumNodes = 100; % This is used only during the computations does not actually change the nodes
end

% Remove fibers outliers, this creates tighter fascicles.
keep = cell(length(fascicles),1);
fprintf('[%s] Removing outliers from fascicles...\n',mfilename)
for in = 1:length(fascicles)
  fprintf('[%s] %i/%i %s.\n',mfilename,in,length(fascicles),fascicles(in).name)
  [fascicles(in), keep{in}] = AFQ_removeFiberOutliers(fascicles(in),opts.stdCutOff,opts.maxLen,opts.maxNumNodes);
  
  % Find the indices to the current fascicle inside the vector of indices
  % for the whol-brain connectome (fg)
   thisFasIndices = find((classification.index == in));

  % Now remove the fibers that we do not want to keep out of the fascicles.
  classification.index(thisFasIndices(~keep{in})) = 0;
end
end