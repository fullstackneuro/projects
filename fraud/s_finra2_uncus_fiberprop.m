%store proportion of fibers kept for major tracts after discarding outliers

baseDir = '/media/storg/matproc';
logDir = '/media/storg/matproc/stats';

% Set up the text file that will store the fiber vals.
dateAndTime     = getDateAndTime;
textFileName    = fullfile(logDir,['uncusa_fiberprop_',dateAndTime,'.csv']);
[fid1 message]  = fopen(textFileName, 'w');
fprintf(fid1, 'subject,clean_runcus,clean_luncus,unclean_runcus,unclean_luncus\n');
    
subjects = {'ab071412','bc050913','ch101612','cs050813', ...
            'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            'gr051513','hg101012','hm062513','jh042913','jl071912','jo081312', ...
            'jt062413','jw072512','kr030113','lc052213','lf052813','lw061713', ...
            'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'};

for isubj = 1:length(subjects)
    afq_wd = ['/media/storg/matproc/' subjects{isubj} '/dti96trilin/fibers/'];
    
    %clean
    %load tracts
    clean_path = fullfile(afq_wd, 'MoriGroups_clean_D3_L2.mat');
    clean = fgRead(clean_path);
    runcus = rows(clean(1,18).fibers);
    luncus = rows(clean(1,17).fibers);
    
    %right hemisphere
    %load tracts
    unclean_path = fullfile(afq_wd, 'MoriGroups.mat');
    unclean = fgRead(unclean_path);
    runcleancus = sum(unclean.subgroup == 18);
    luncleancus = sum(unclean.subgroup == 17);
    
    % Write out to the the stats file using the tab delimeter.
   fprintf(fid1,'%s,%.6f,%.6f,%.6f,%.6f\n',...
           subjects{isubj},runcus,luncus,runcleancus,luncleancus);      
end

% save the stats file.
fclose(fid1);