%   mask with ROI
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
dirs    = 'dti96trilin';
logDir  = '/media/storg/matproc/stats';
baseDir = {'/media/storg/matproc'};

subjects = {'ad082014_hardi1','ad082014_hardi2','ad082014_hardi3', ...
            'hm082514_hardi1','hm082514_hardi2','hm082514_hardi3', ...
            'ml082214_hardi1','ml082214_hardi2','ml082214_hardi3', ...
            'yw083014_hardi1','yw083014_hardi2','yw083014_hardi3', ...
            'ad082014_2_hardi1','ad082014_2_hardi2','ad082014_2_hardi3', ...
            'hm082514_2_hardi1','hm082514_2_hardi2','hm082514_2_hardi3', ...
            'ml082214_2_hardi1','ml082214_2_hardi2','ml082214_2_hardi3', ...
            'yw083014_2_hardi1','yw083014_2_hardi2','yw083014_2_hardi3'};
        
% Set fiber groups
roiName = {'rh_nacc_aseg.mat', ...
           'lh_nacc_aseg.mat', ...
           'rh_antins_a2009s.mat', ...
           'lh_antins_a2009s.mat', ...
           'rh_shortins_a2009s.mat', ...
           'lh_shortins_a2009s.mat', ...
           'rh_caud_aseg.mat', ...
           'lh_caud_aseg.mat', ...
           'rh_pal_aseg.mat', ...
           'lh_pal_aseg.mat', ...
           'rh_put_aseg.mat', ...
           'lh_put_aseg.mat', ...
           'rh_thal_aseg.mat', ...
           'lh_thal_aseg.mat'};

%% Set up the text file that will store the fiber vals.
dateAndTime     = getDateAndTime;
textFileName    = fullfile(logDir,['roi_nacc_',dateAndTime,'.csv']);
[fid1 message]  = fopen(textFileName, 'w');
fprintf(fid1, 'subject,roiname,famean,fastd,mdmean,mdstd,rdmean,rdstd,admean,adstd\n');


%% Run the fiber properties functions
for i = 1:numel(baseDir)
    if i == 1; subs = subjects;
    elseif i == 2; subs = subsSession2; end
    
    for ii=1:numel(subs)
        sub = dir(fullfile(baseDir{i},[subs{ii} '*']));
        if ~isempty(sub)
            subDir   = fullfile(baseDir{i},sub.name);
            dt6Dir   = fullfile(subDir,dirs);
            roiDir   = fullfile(subDir,'ROIs');
            
            dt = dtiLoadDt6(fullfile(dt6Dir,'dt6.mat'));
            
            fprintf('\nProcessing %s\n', subDir);
            
            % Read in fiber groups
            for kk=1:numel(roiName)
                roiLoadName = fullfile(roiDir, roiName{kk});
                
                if exist(roiLoadName,'file')
                    disp(['Computing dtiVals for ' roiLoadName ' ...']);
                    try
                        roi = dtiReadRoi(roiLoadName);
                                                                       
                        % Compute the fiber statistics and write them to the text file
                        coords = roi.coords;
                                                       
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
                        
                        avgFA = FA(2);
                        avgMD = MD(2);
                        avgRD = radialADC(2);
                        avgAD = axialADC(2);
                        
                        faSTD = std(fa);
                        mdSTD = std(md);
                        rdSTD = std(rd);
                        adSTD = std(ad);
                                                       
                        save('data_test.mat');
                        
                        % Write out to the the stats file using the tab delimeter.
                        fprintf(fid1,'%s,%s,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f\n',...
                                subs{ii},roi.name,avgFA,faSTD,avgMD,mdSTD,avgRD,rdSTD,avgAD,adSTD);                  

                    catch ME
                      fprintf('Fiber group being skipped: %s',roiLoadName);
                        disp(ME);
                        clear ME
%                         fprintf('Can"t load the fiber group - It might be empty. Skipping.\n');
                    end
                else disp(['Fiber group: ' roiLoadName ' not found. Skipping...'])
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