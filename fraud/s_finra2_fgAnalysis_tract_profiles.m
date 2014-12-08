%
% This script is used for the analysis of fiber groups. It returns
% fiber values in a tab delimited text file that can be read into
% excel. The text file is saved in the baseDirectory by default.
%
% Values returned include:
% avgFA avgMD avgRD avgAD avgLength minLength maxLength
%
% subCodeList = '.txt';
% subs        = textread(subCodeList, '%s'); fprintf('\nWill process %d subjects...\n\n',numel(subs));
%
% Copy Right Franco PEstilli Staford University
% Based on code by LMP

addpath(genpath('~/path/to/spm8'))
addpath(genpath('~/path/to/vistasoft'));
addpath(genpath('~/path/to/life'));
addpath(genpath('~/path/to/mba'));

%% Set directory structure
%% I. Directory and Subject Informatmation
dirs          = 'dti96trilin';
logDir = '/media/storg/matlab_proc/stats';
baseDir = {'/media/storg/matlab_proc'};

% Group 1
%{
subjects = {'ab071412_mrdiff','bc050913_mrdiff','bk032113_mrdiff','bk053012_mrdiff','ch101612_mrdiff','cs050813_mrdiff', ...
            'dc050213_mrdiff','dp092612_mrdiff','ds080712_mrdiff','ec081912_mrdiff','en062813_mrdiff','fg092712_mrdiff', ...
            'gr051513_mrdiff','hg101012_mrdiff','hm062513_mrdiff','jh042913_mrdiff','jl071912_mrdiff','jo081312_mrdiff', ...
            'jt062413_mrdiff','jw072512_mrdiff','kr030113_mrdiff','lc052213_mrdiff','lf052813_mrdiff','lw061713_mrdiff', ...
            'md072512_mrdiff','mk021913_mrdiff','ml061013_mrdiff','mn052313_mrdiff','ms082112_mrdiff','na060213_mrdiff', ...
            'np072412_mrdiff','pf020113_mrdiff','pl061413_mrdiff','ps022013_mrdiff','pw060713_mrdiff','pw061113_mrdiff', ...
            'ra053013_mrdiff','rb073112_mrdiff','rb082212_mrdiff','sd040313_mrdiff','sh010813_mrdiff','sl080912_mrdiff', ...
            'sn061213_mrdiff','sp061313_mrdiff','tr101312_mrdiff','tw062113_mrdiff','vv060313_mrdiff','wb071812_mrdiff'}
%}
subjects = {'ab071412_mrdiff','ds080712_mrdiff','en062813_mrdiff','gr051513_mrdiff','hm062513_mrdiff', ...
            'jw072512_mrdiff','na060213_mrdiff','sp061313_mrdiff','tr101312_mrdiff','vv060313_mrdiff','wb071812_mrdiff'}
%'bc050913_mrdiff', bad motion
% Set fiber groups
fiberName = {'scored_fg_rh_antins_nacc_clean_post_140515.mat'};

%% Set up the text file that will store the fiber vals.
dateAndTime     = getDateAndTime;
textFileName    = fullfile(logDir,['ctr_antins_nacc_post_tractprofile100',dateAndTime,'.txt']);
[fid1 message]  = fopen(textFileName, 'w');
fprintf(fid1, 'Subject_Code \t Fiber_Name \t Mean_FA \t FA_StErr \t Mean_MD \t MD_StErr \t Mean Radial ADC \t RD StErr \t Mean Axial ADC \t AD StErr \t Number of Fibers (arb) \t Mean Length \t Min Length \t Max Length \t Mean_FA_tp \t FA_std \t Mean_MD_tp \t MD_std \t Mean_RD_tp \t RD_std \t Mean_AD_tp \t AD_std \n');


%% Run the fiber properties functions
for i = 1:numel(baseDir)
    if i == 1; subs = subjects;
    elseif i == 2; subs = subsSession2; end
    
    for ii=1:numel(subs)
        sub = dir(fullfile(baseDir{i},[subs{ii} '*']));
        if ~isempty(sub)
            subDir   = fullfile(baseDir{i},sub.name);
            dt6Dir   = fullfile(subDir,dirs);
            fiberDir = fullfile(subDir,'dti96trilin/fibers/conTrack/clean_post');
            roiDir   = fullfile(subDir,'ROIs');
            
            dt = dtiLoadDt6(fullfile(dt6Dir,'dt6.mat'));
            
            fprintf('\nProcessing %s\n', subDir);
            
            % Read in fiber groups
            for kk=1:numel(fiberName)
                fiberGroup = fullfile(fiberDir, fiberName{kk});
                
                if exist(fiberGroup,'file')
                    disp(['Computing dtiVals for ' fiberGroup ' ...']);
                    try
                        try fg = dtiReadFibers(fiberGroup);
                        catch ER
                            fg = mtrImportFibers(fiberGroup);
                        end
                        
                        fg = dtiCleanFibers(fg);
                        
                        % Compute the fiber statistics and write them to the text file
                        coords = horzcat(fg.fibers{:})';
                        numberOfFibers=numel(fg.fibers);
                        
                        % Measure the step size of the first fiber. They *should* all be the same!
                        stepSize = mean(sqrt(sum(diff(fg.fibers{1},1,2).^2)));
                        fiberLength = cellfun('length',fg.fibers);
                        
                        % The rest of the computation does not require remembering which node
                        % belongd to which fiber.
                        [val1,val2,val3,val4,val5,val6] = dtiGetValFromTensors(dt.dt6, coords, inv(dt.xformToAcpc),'dt6','nearest');
                        dt6 = [val1,val2,val3,val4,val5,val6];
                        
                        % Clean the data in two ways.
                        % Some fibers extend a little beyond the brain mask. Remove those points by
                        % exploiting the fact that the tensor values out there are exactly zero.
                        dt6 = dt6(~all(dt6==0,2),:);
                        
                        % There shouldn't be any nans, but let's make sure:
                        dt6Nans = any(isnan(dt6),2);
                        if(any(dt6Nans))
                            dt6Nans = find(dt6Nans);
                            for jj=1:6
                                dt6(dt6Nans,jj) = 0;
                            end
                            fprintf('\ NOTE: %d fiber points had NaNs. These will be ignored...',length(dt6Nans));
                            disp('Nan points (ac-pc coords):');
                            for jj=1:length(dt6Nans)
                                fprintf('%0.1f, %0.1f, %0.1f\n',coords(dt6Nans(jj),:));
                            end
                        end
                        
                        % We now have the dt6 data from all of the fibers.  We
                        % extract the directions into vec and the eigenvalues into
                        % val.  The units of val are um^2/sec or um^2/msec
                        % mrDiffusion tries to guess the original units and convert
                        % them to um^2/msec. In general, if the eigenvalues are
                        % values like 0.5 - 3.0 then they are um^2/msec. If they
                        % are more like 500 - 3000, then they are um^2/sec.
                        [vec,val] = dtiEig(dt6);
                        
                        % Some of the ellipsoid fits are wrong and we get negative eigenvalues.
                        % These are annoying. If they are just a little less than 0, then clipping
                        % to 0 is not an entirely unreasonable thing. Maybe we should check for the
                        % magnitude of the error?
                        nonPD = find(any(val<0,2));
                        if(~isempty(nonPD))
                            fprintf('\n NOTE: %d fiber points had negative eigenvalues. These will be clipped to 0...\n', numel(nonPD));
                            val(val<0) = 0;
                        end
                        
                        threeZeroVals=find(sum(val,2)==0);
                        if ~isempty (threeZeroVals)
                            fprintf('\n NOTE: %d of these fiber points had all three negative eigenvalues. These will be excluded from analyses\n', numel(threeZeroVals));
                        end
                        
                        val(threeZeroVals,:)=[];
                        
                        % Now we have the eigenvalues just from the relevant fiber positions - but
                        % all of them.  So we compute for every single node on the fibers, not just
                        % the unique nodes.
                        [fa,md,rd,ad] = dtiComputeFA(val);
                        
                        %Some voxels have all the three eigenvalues equal to zero (some of them
                        %probably because they were originally negative, and were forced to zero).
                        %These voxels will produce a NaN FA
                        FA(1)=min(fa(~isnan(fa)));
                        FA(2)=mean(fa(~isnan(fa)));
                        FA(3)=max(fa(~isnan(fa))); % isnan is needed because sometimes if all the three eigenvalues are negative, the FA becomes NaN. These voxels are noisy.
                        MD(1)=min(md);
                        MD(2)=mean(md);
                        MD(3)=max(md);
                        radialADC(1) = min(rd);
                        radialADC(2) = mean(rd);
                        radialADC(3) = max(rd);
                        axialADC(1)  = min(ad);
                        axialADC(2)  = mean(ad);
                        axialADC(3)  = max(ad);
                        fibLength(1) = mean(fiberLength)*stepSize;
                        fibLength(2) = min(fiberLength)*stepSize;
                        fibLength(3) = max(fiberLength)*stepSize;
                        
                        avgFA = FA(2);
                        avgMD = MD(2);
                        avgRD = radialADC(2);
                        avgAD = axialADC(2);
                        avgLength = fibLength(1);
                        minLength = fibLength(2);
                        maxLength = fibLength(3);
                        numFibers = numel(fg.fibers);
                        % fg.params is empty
                        % meanScore = mean(fg.params{2}.stat);
                        
                        faSTD = std(fa);
                        faSEM = faSTD/sqrt(length(fg.fibers));
                        mdSTD = std(md);
                        mdSEM = mdSTD/sqrt(length(fg.fibers));
                        rdSTD = std(rd);
                        rdSEM = rdSTD/sqrt(length(fg.fibers));
                        adSTD = std(ad);
                        adSEM = adSTD/sqrt(length(fg.fibers));
                        
                        %compute tract profiles
                        %[faTP,mdTP,rdTP,adTP,clTP, ~, ~, cpTP, csTP, ~] = finra2_dtiComputeDiffusionPropertiesAlongFG(fg.sibers, dt.dt6, 100);
                        [faTP,mdTP,rdTP,adTP] = finra2_dtiComputeDiffusionPropertiesAlongFG(fg, dt, 100);
                        avgfaTP = mean(faTP);
                        avgmdTP = mean(mdTP);
                        avgrdTP = mean(rdTP);
                        avgadTP = mean(adTP);
                        stdfaTP = std(faTP);
                        stdmdTP = std(mdTP);
                        stdrdTP = std(mdTP);
                        stdadTP = std(adTP);                        
                        
                        save('data_test.mat');
                        
                        % Write out to the the stats file using the tab delimeter.
                        %fprintf(fid1,'%s\t %s\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t \n',...
                        %        subs{ii},fg.name,avgFA,faSEM,avgMD,mdSEM,avgRD,rdSEM,avgAD,adSEM,numFibers,avgLength,minLength,maxLength,avgfaTP,stdfaTP,avgmdTP,stdmdTP,avgrdTP,stdrdTP,avgadTP,stdadTP); %,meanScore);
%                         fprintf(fid1,'%s\t %s\t %.6f\t %.6f\t %.6f\t %.6f\n',...
%                          subs{ii},fg.name,avgFA,faSEM,avgMD,mdSEM); 
                        save('/media/storg/matlab_proc/stats/test.txt','faTP' ,'-ASCII', '-append');


                    catch ME
                      fprintf('Fiber group being skipped: %s',fiberGroup);
                        disp(ME);
                        clear ME
%                         fprintf('Can"t load the fiber group - It might be empty. Skipping.\n');
                    end
                else disp(['Fiber group: ' fiberGroup ' not found. Skipping...'])
                end
            end
        else disp('No data found.');
        end
    end
end
% save the stats file.
fclose(fid1);

disp('DONE!');
return
