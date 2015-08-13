%store proportion of non-overlapping coordinates between uncinate and
%ains-nacc

baseDir = '/media/storg/matproc';
logDir = '/media/storg/matproc/stats';

% Set up the text file that will store the fiber vals.
dateAndTime     = getDateAndTime;
textFileName    = fullfile(logDir,['uncusainsnacc_overlap_',dateAndTime,'.csv']);
[fid1 message]  = fopen(textFileName, 'w');
fprintf(fid1, 'subject,luncus,lainsnac,loverlap,runcus,rainsnac,roverlap\n');
    
subjects = {'ab071412','bc050913','ch101612','cs050813', ...
            'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            'gr051513','hg101012','hm062513','jh042913','jl071912','jo081312', ...
            'jt062413','jw072512','kr030113','lc052213','lf052813','lw061713', ...
            'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'};

for isubj = 1:length(subjects)
    afq_wd = ['/media/storg/matproc/' subjects{isubj} '/dti96trilin/fibers/afq'];
    mrtrix_wd = ['/media/storg/matproc/' subjects{isubj} '/dti96trilin/fibers/mrtrix'];
    
    %left hemisphere
    %load tracts
    lh_uncus = fullfile(afq_wd, 'l_uncinate_lmax10.mat');
    lhuncus = fgRead(lh_uncus);
    lh_insula = fullfile(mrtrix_wd,'clean_lh_antshortins_nacc.mat');
    lhinsula = fgRead(lh_insula);
    lcoordsTract = fgGet(lhinsula, 'unique image coords');
    lcoordsUncinate = fgGet(lhuncus, 'unique image coords');
    luncus = rows(lcoordsUncinate);
    lainsnac = rows(lcoordsTract);
    loverlapcoords = ismember(lcoordsTract, lcoordsUncinate, 'rows');
    loverlap = sum(loverlapcoords);
           
    %right hemisphere
    %load tracts
    rh_uncus = fullfile(afq_wd, 'r_uncinate_lmax10.mat');
    rhuncus = fgRead(rh_uncus);
    rh_insula = fullfile(mrtrix_wd,'clean_rh_antshortins_nacc.mat');
    rhinsula = fgRead(rh_insula);
    rcoordsTract = fgGet(rhinsula, 'unique image coords');
    rcoordsUncinate = fgGet(rhuncus, 'unique image coords');
    runcus = rows(rcoordsUncinate);
    rainsnac = rows(rcoordsTract);
    roverlapcoords = ismember(rcoordsTract, rcoordsUncinate, 'rows');
    roverlap = sum(roverlapcoords);
    
    % Write out to the the stats file using the tab delimeter.
   fprintf(fid1,'%s,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f\n',...
           subjects{isubj},luncus,lainsnac,loverlap,runcus,rainsnac,roverlap);      
end

% save the stats file.
fclose(fid1);