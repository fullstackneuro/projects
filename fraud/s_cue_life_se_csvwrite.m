%script for saving SE, EMD from subjects to CSV
%
%MAKE SURE TO EDIT HEMISPHERE

%% Set directory structure
%% I. Directory and Subject Informatmation
dirs    = 'dti96trilin';
logDir  = '/media/lcne/matproc/stats/';
%{
baseDir = '/media/lcne/matproc/';
subjects = {'li160927','ac160415','kn160918','jh160702','jr160507','mp160511'};
%}
baseDir = '/media/storg/matproc/';
subjects = {'ab071412','al151016','bb160402','bk032113','bp160213','cs160214','dc050213', ...
            'ds080712','en062813','gr051513','hm062513','jc160320','jc160321','jg151121', ...
            'jl071912','jv151030','jw072512','jw160316','lc052213', ...
            'mk021913','ml061013','np072412','pk160319','pw060713','rb160407', ...
            'rf160313','sp061313','zl150930'};

tract_name = {'ainsnacc','mpfcnacc','presmastn','vlpfcins','vlpfcstn'};
        
se_name = {'lh','rh'};
              
%% Set up the text file that will store the SE values.
dateAndTime     = getDateAndTime;
textFileName    = fullfile(logDir,['life_se_mididti_',dateAndTime,'.csv']);
[fid1 message]  = fopen(textFileName, 'w');
fprintf(fid1, 'subject_code,tract_name,se_name,s_mean,s_std,em_mean\n');

%% Run the fiber properties functions
for i = 1:length(subjects)
    subDir = fullfile(baseDir,subjects{i});
    lifeDir  = fullfile(subDir,'dti96trilin/fibers/life');
    
    fprintf('\nProcessing %s\n', subjects{i});
    
    %% For loop by tract
    for tract = 1:length(tract_name)
        tractDir = fullfile(lifeDir,tract_name{tract});
        
        %% For loop by hemi
        for hemi = 1:length(se_name)
            hemiDir = fullfile(tractDir,[se_name{hemi} '_nowbc']);
            seFile = fullfile(hemiDir,[subjects{i} '_' se_name{hemi} '_se_nowbc.mat']);
            
            if exist(seFile,'file')
                disp(['Loading SE for ' seFile ' ...']);
                seLoad = load(seFile);
                
                s_mean  = seLoad.se.s.mean;
                s_std   = seLoad.se.s.std;
                em_mean = seLoad.se.em.mean;
                %j_mean  = seLoad.se.j.mean;
                %kl_mean = seLoad.se.kl.mean;
                
                save('data_test.mat');
                
                % Write out to the the stats file using the tab delimeter.
                fprintf(fid1,'%s,%s,%s,%.6f,%.6f,%.6f\n',...
                    subjects{i},tract_name{tract},se_name{hemi},s_mean,s_std,em_mean);
                
            else disp(['SE file: ' seFile ' not found. Skipping...']);
            end
        end
    end
end

% save the stats file.
fclose(fid1);

disp('DONE!');
return
