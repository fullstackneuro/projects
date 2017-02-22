%script for saving SE, EMD from subjects to CSV
%
%MAKE SURE TO EDIT HEMISPHERE

%% Set directory structure
%% I. Directory and Subject Informatmation
dirs    = 'dti96trilin';
logDir  = '/media/storg/matproc/stats/life';
baseDir = '/media/storg/matproc';
%baseDir = '/media/lcne/matproc';

%subjects = {'ac160415','jh160702','jr160507','mp160511','ps160508'};


subjects = {'ab071412','al151016','bb160402','bk032113','bp160213','cs160214','dc050213', ...
            'ds080712','en062813','gr051513','hm062513','jc160320','jc160321','jg151121', ...
            'jl071912','jt062413','jv151030','jw072512','jw160316','lc052213','mk021913', ...
            'ml061013','np072412','pk160319','ps151001','pw060713','rb160407','rf160313', ...
            'sp061313','wb071812','zl150930'};
%}        

se_name = {'rh_se_nowbc.mat'};
              
%% Set up the text file that will store the SE values.
dateAndTime     = getDateAndTime;
textFileName    = fullfile(logDir,['life_se_ainsnacc',dateAndTime,'.csv']);
[fid1 message]  = fopen(textFileName, 'w');
fprintf(fid1, 'subject_code,se_name,s_mean,s_std,em_mean\n');

%% Run the fiber properties functions
for i = 1:length(subjects)
    subDir = fullfile(baseDir,subjects{i});
    lifeDir  = fullfile(subDir,'dti96trilin/fibers/life/vlpfcins/rh_nowbc');

    fprintf('\nProcessing %s\n', subjects{i});
    
    % Read in fiber groups
    for ii=1:numel(se_name)
        seFile = fullfile(lifeDir,[subjects{i} '_' se_name{ii}]);
                
        if exist(seFile,'file')
            disp(['Loading SE for ' seFile ' ...']);
            seLoad = load(seFile);
            
            s_mean  = seLoad.se.s.mean;
            s_std   = seLoad.se.s.std;
            em_mean = seLoad.se.em.mean;
            %j_mean  = seLoad.se.j.mean;
            %kl_mean = seLoad.se.kl.mean;
            
            %save('data_test.mat');
            
            % Write out to the the stats file using the tab delimeter.
            fprintf(fid1,'%s,%s,%.6f,%.6f,%.6f\n',...
                subjects{i},se_name{ii},s_mean,s_std,em_mean);
            
        else disp(['SE file: ' seFile ' not found. Skipping...']);
        end
    end
end

% save the stats file.
fclose(fid1);
    
disp('DONE!');
return
