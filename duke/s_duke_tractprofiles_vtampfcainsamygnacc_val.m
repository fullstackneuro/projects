% tract profiles on MRtrix fiber groups

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

%% Set directory structure
%% I. Directory and Subject Informatmation
dirs    = 'dti32trilin';
logDir  = '/mnt/acorn/cylon/matproc/stats';
baseDir = {'/mnt/acorn/cylon/matproc'};

subjects = {'val002', 'val003', 'val005', 'val007', 'val009', 'val012', ...
    'val013', 'val015', 'val016', 'val020', 'val021', 'val025', 'val027', ...
    'val031', 'val032', 'val034', 'val035', 'val036', 'val038', 'val041', ...
    'val045', 'val047', 'val048', 'val061', 'val062', 'val064', 'val065', ...
    'val066', 'val068', 'val071', 'val073', 'val081', 'val082', 'val086', ...
    'val088', 'val090', 'val093', 'val096', 'val100', 'val101', 'val103', ...
    'val106', 'val107', 'val109', 'val111', 'val115', 'val116', 'val119', ...
    'val120', 'val123', 'val128', 'val129', 'val131', 'val134', 'val136', ...
    'val139', 'val140', 'val141', 'val142', 'val145', 'val146', 'val147', ...
    'val149', 'val150', 'val151', 'val152', 'val153', 'val157', 'val158', ...
    'val161', 'val162', 'val163', 'val165', 'val166', 'val168'};
%{
'as160129','bp160213','cs160214','kl160122','rp160205','ss160205','wh160130'
'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
            'jv151030','ps151001','si151120','sr151031','tf151127','vm151031', ...
            'wr151127','zl150930'
%}
                
% Set fiber groups
fiberName = {'rh_ains_nacc.mat', ...
            'rh_amyg_nacc.mat', ...
            'lh_ains_nacc.mat', ...
            'lh_amyg_nacc.mat', ...
            'rh_mpfc_nacc.mat', ...
            'rh_vta_nacc.mat', ...
            'lh_mpfc_nacc.mat', ...
            'lh_vta_nacc.mat'};

%% Set up the text file that will store the fiber vals.
dateAndTime     = getDateAndTime;
%textFileName    = fullfile(logDir,['dnd_connacctome_',dateAndTime,'.csv']);
textFileName    = fullfile(logDir,'val_connacctome.csv');
[fid1 message]  = fopen(textFileName, 'w');
%fprintf(fid1, 'Subject_Code \t Fiber_Name \t Mean_FA \t FA_StErr \t Mean_MD \t MD_StErr \t Mean Radial ADC \t RD StErr \t Mean Axial ADC \t AD StErr \t Number of Fibers (arb) \t Mean Length \t Min Length \t Max Length \t Mean_FA_tp \t FA_std \t Mean_MD_tp \t MD_std \t Mean_RD_tp \t RD_std \t Mean_AD_tp \t AD_std \n');


%% Run the fiber properties functions
for i = 1:numel(baseDir)
    if i == 1; subs = subjects;
    elseif i == 2; subs = subsSession2; end
    
    for ii=1:numel(subs)
        sub = dir(fullfile(baseDir{i},[subs{ii} '*']));
        if ~isempty(sub)
            subDir   = fullfile(baseDir{i},sub.name);
            dt6Dir   = fullfile(subDir,dirs);
            fiberDir = fullfile(dt6Dir, 'fibers');
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
                        
                        % Reorient fibers
                        roi1 = '';
                        roi2 = '';
                        %Determine which hemisphere for NAcc:
                        if strcmp(fiberName{kk}, 'lh_ains_nacc.mat') || strcmp(fiberName{kk}, 'lh_amyg_nacc.mat') || strcmp(fiberName{kk}, 'lh_mpfc_nacc.mat') || strcmp(fiberName{kk}, 'lh_vta_nacc.mat')
                            roi2 = fullfile(roiDir, 'lh_nacc_aseg_fd.mat');
                        else
                            roi2 = fullfile(roiDir, 'rh_nacc_aseg_fd.mat');
                        end
                        %determine starting ROI from file name:
                        if strcmp(fiberName{kk}, 'lh_ains_nacc.mat')
                            roi1 = fullfile(roiDir, 'lh_antshortins_fd.mat');
                        elseif strcmp(fiberName{kk}, 'lh_amyg_nacc.mat')
                            roi1 = fullfile(roiDir, 'lh_amyg_aseg_fd.mat');
                        elseif strcmp(fiberName{kk}, 'lh_mpfc_nacc.mat')
                            roi1 = fullfile(roiDir, 'lh_mpfc_5mm.mat');
                        elseif strcmp(fiberName{kk}, 'lh_vta_nacc.mat')
                            roi1 = fullfile(roiDir, 'lh_vta_5mm.mat');
                        elseif strcmp(fiberName{kk}, 'rh_ains_nacc.mat')
                            roi1 = fullfile(roiDir, 'rh_antshortins_fd.mat');
                        elseif strcmp(fiberName{kk}, 'rh_amyg_nacc.mat')
                            roi1 = fullfile(roiDir, 'rh_amyg_aseg_fd.mat');
                        elseif strcmp(fiberName{kk}, 'rh_mpfc_nacc.mat')
                            roi1 = fullfile(roiDir, 'rh_mpfc_5mm.mat');
                        elseif strcmp(fiberName{kk}, 'rh_vta_nacc.mat')
                            roi1 = fullfile(roiDir, 'rh_vta_5mm.mat');
                        end
                        
                        %flip fibers accordingly
                        fg = AFQ_ReorientFibers(fg, dtiReadRoi(roi1), dtiReadRoi(roi2));
                        
                        
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
                        %[faTP,mdTP,rdTP,adTP,clTP, ~, ~, cpTP, csTP, ~] = finra2_dtiComputeDiffusionPropertiesAlongFG(fg.fibers, dt.dt6, 100);
                        [faTP,mdTP,rdTP,adTP] = finra2_dtiComputeDiffusionPropertiesAlongFG(fg, dt, 100);
                        avgfaTP = mean(faTP);
                        avgmdTP = mean(mdTP);
                        avgrdTP = mean(rdTP);
                        avgadTP = mean(adTP);
                        stdfaTP = std(faTP);
                        stdmdTP = std(mdTP);
                        stdrdTP = std(mdTP);
                        stdadTP = std(adTP);
                       
                        %transpose column to row
                        faTP_row = faTP(:)';
                        mdTP_row = mdTP(:)';
                        rdTP_row = rdTP(:)';
                        adTP_row = adTP(:)';
                                            
                        %don't need to append subject name to array
                        %faTP_m = num2cell(faTP_row);
                        %faTP_m = horzcat(sub.name, faTP_m);
                        
                        save('data_test.mat');
                        
                        % Write out to the the stats file using the tab delimeter.
                        %fprintf(fid1,'%s\t %s\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t \n',...
                         %       subs{ii},fg.name,avgFA,faSEM,avgMD,mdSEM,avgRD,rdSEM,avgAD,adSEM,numFibers,avgLength,minLength,maxLength,avgfaTP,stdfaTP,avgmdTP,stdmdTP,avgrdTP,stdrdTP,avgadTP,stdadTP); %,meanScore);                        
                        %dlmwrite(textFileName, faTP_m, 'delimiter', ',', 'precision', '%.6f', '-append');
                        %cell2csv(textFileName, faTP_m,);
                        [nrow, ncol] = size(faTP_row);
                        fib = ['%s,%s,%s,',repmat('%.6f,',1,ncol-1),'%.6f\n']; %one less comma
                        for kk=1:size(faTP_row,1)
                            fprintf(fid1,fib, ...
                                subs{ii}, fg.name,'fa', faTP_row(kk,:));
                        end
                        
                        for kk=1:size(mdTP_row,1)
                            fprintf(fid1,fib, ...
                                subs{ii}, fg.name,'md', mdTP_row(kk,:));
                        end
                        
                        for kk=1:size(rdTP_row,1)
                            fprintf(fid1,fib, ...
                                subs{ii}, fg.name,'rd', rdTP_row(kk,:));
                        end
                        
                        for kk=1:size(adTP_row,1)
                            fprintf(fid1,fib, ...
                                subs{ii}, fg.name,'ad', adTP_row(kk,:));
                        end
                        
                        %fprintf(fid1,' ', ...
                        %    subs{ii},fg.name,faTP_row);
                                                
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