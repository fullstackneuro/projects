%set up script for LiFE
%
%MAKE SURE TO EDIT HEMISPHERE

subjects = {'lc052213'};
            
            %'bc050913','bk032113','ch101612','cs050813', ...
            %'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            %'gr051513','hg101012','hm062513','jh042913','jl071912','jo081312', ...
            %'jt062413','jw072512','kr030113','lf052813','lw061713', ...
            %'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            %'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            %'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            %'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'};
    
            %all subjects
            %'ab071412','bc050913','bk032113','bk053012','ch101612','cs050813', ...
            %'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            %'gr051513','hg101012','hm062513','jh042913','jl071912','jo081312', ...
            %'jt062413','jw072512','kr030113','lc052213','lf052813','lw061713', ...
            %'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            %'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            %'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            %'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'
            
baseDir = '/media/storg/matproc/';

for isubj = 1:length(subjects)
    %% (0) Set up paths and filenames
    % Base subject folder
    subjectDir    = [subjects{isubj}];
    subjectFolder = fullfile(baseDir, subjectDir);
    
    % make life folder if doesn't exist
    lifeFolder    = fullfile(subjectFolder, '/dti96trilin/fibers/life');
        if ~exist(lifeFolder,'dir'); mkdir(lifeFolder); end 
        
    % T1 high resolution anatomy
    subjectRefImg = [subjects{isubj} '_t1_acpc.nii.gz'];
    sub_t1w_acpc  = fullfile(subjectFolder, subjectRefImg);
    
    % Fibers and tracts
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix');
    sub_wbc       = fullfile(fibersFolder, 'lmax10_wbc.mat');
    sub_roi2roi_track = fullfile(fibersFolder, 'clean_rh_antshortins_nacc.mat');
       
    % ROIs and WM masks
    roiFolder        = fullfile(baseDir, subjectDir, '/ROIs');
    sub_wmmask_track = fullfile(roiFolder, 'rh_wmmask_fs_fd_clip_insnacc.nii.gz');
    sub_roi1 = fullfile(roiFolder, 'rh_antshortins_fd.nii.gz');
    sub_roi2 = fullfile(roiFolder, 'rh_nacc_aseg_fd.nii.gz');
    
    % DWI files
    fullsubjectAcqName = dir(fullfile(subjectFolder, '*.bvals'));
    [~, subAcqName,~]  = fileparts(fullsubjectAcqName.name);
    sub_dwi_bvec       = fullfile(subjectFolder, [subAcqName, '.bvecs']);
    sub_dwi_bval       = fullfile(subjectFolder, [subAcqName, '.bvals']);
    sub_dwi_processed  = fullfile(subjectFolder, [subAcqName, '.nii.gz']);
    
    %% (1) Find fibers in WB-connectome between ROI1 and ROI2
    % Find the fascicles in the connectome that touch both ROIs.
    roi1 = dtiImportRoiFromNifti(sub_roi1,'ROI1');
    roi2 = dtiImportRoiFromNifti(sub_roi2,'ROI2');
    roi_combined = dtiNewRoi('combined_roi');
    roi_combined.coords   = [roi1.coords;roi2.coords];
    wbc          = fgRead(sub_wbc);
    
    tic, fprintf('\n[%s] Segmenting fascicles from connectome... \n',mfilename)
    
    %take wbc fibers hitting combined roi
    [fasciclesRoi1ToRoi2, indicesRoi1ToRoi2] = feSegmentFascicleFromConnectome(wbc, {roi_combined}, {'and both endpoints'}, 'toi in wbc');
   
    %take wbc fibers that hit roi1 and then hit roi2
    %[fasciclesRoi1ToRoi2, indicesRoi1ToRoi2] = feSegmentFascicleFromConnectome(wbc, {roi1, roi2}, {'and both endpoints','and both endpoints'}, 'toi in wbc');
    fprintf('\n[%s] DONE segmenting tract from connectome in %2.3f \n',mfilename,toc)
    
    %% (2) Clean them. We need to clean the tract then remove them from the whole-brain connectome.
    % Clean the fibers by length, fibers that too long are likely to go far
    % frontal and not just touch insula and nacc.
    [Lnorm, Lmm]  = mbaComputeFiberLengthDistribution(fasciclesRoi1ToRoi2, false);
    maxSD         = 1; % Max standard deviation of the fibers to keep in the group.
    %fibers2delete = Lnorm > maxSD;
    
    tract = fgRead(sub_roi2roi_track);
    [~, TLmm]  = mbaComputeFiberLengthDistribution(tract, false);
    meanTractLength = mean(TLmm);
    lengThreshold = 0.5; % mm
    fibers2delete = (Lmm > meanTractLength+lengThreshold) | (Lmm < meanTractLength-lengThreshold);
 
    %we will have to use this outliers approach. too many wild fibers going around whole brain. 
    %Alternative approach: Clean the fibers by length and volume.
    %[~, keep] = mbaComputeFibersOutliers(fasciclesRoi1ToRoi2,2,2);
    % fibers2delete = ~keep;

    fprintf('\n[%s] Deleting %i fibers out of %i fibers found touching the two ROIs \n', ...
            mfilename,sum(fibers2delete),length(fasciclesRoi1ToRoi2.fibers))

    % Remove the fascicles from the TOI to clean it
    fasciclesRoi1ToRoi2Clean  = fgExtract(fasciclesRoi1ToRoi2,find(fibers2delete),'remove');
    fasciclesRoi1ToRoi2Delete = fgExtract(fasciclesRoi1ToRoi2,find(fibers2delete),'keep');
    
    % Write code to display the fibers usign mbaDisplayConnectome.m - We
    % need to take a look at the fiber deleted, at the whole group fo fibers
    % we found touching the two ROIs and at the TOI
    
    t1 = niftiRead(sub_t1w_acpc);
    
    %display roi2roi fibers
    figure_tract = figure('position',[100 200 1000 900]);
    %mbaDisplayBrainSlice(t1,[1 0 0]);
    %hold on
    %mbaDisplayBrainSlice(t1,[0 0 1]);
    %mbaDisplayConnectome(tract.fibers, figure_tract, [0,0,1],'single',[],[],.1);
    
    %display wbc fibers to delete
    figure_delete = figure('position',[100 200 1000 900]);
    %mbaDisplayBrainSlice(t1,[1 0 0]);
    %hold on
    %mbaDisplayBrainSlice(t1,[0 0 1]);
    %mbaDisplayConnectome(fasciclesRoi1ToRoi2Delete.fibers, figure_delete, [1,0,0],'single',[],[],.1);
    
    %display wbc fibers +/- lengThreshold of roi2roi fibers
    figure_clean = figure('position',[100 200 1000 900]);
    %mbaDisplayBrainSlice(t1,[1 0 0]);
    %hold on
    %mbaDisplayBrainSlice(t1,[0 0 1]);
    %mbaDisplayConnectome(fasciclesRoi1ToRoi2Clean.fibers, figure_clean, [0,1,0],'single',[],[],.1);
        
    % (3) Merge them with the tract
    tract = rmfield(tract,'pathwayInfo');
    fasciclesRoi1ToRoi2Clean = rmfield(fasciclesRoi1ToRoi2Clean,'pathwayInfo');
    TOI = fgMerge(tract,fasciclesRoi1ToRoi2Clean,'tract_of_interest_plus_fascicles_in_wbc');
    nTOIfibers  = fefgGet(TOI,'nfibers');
    
    % (4) Remove the fibers in the TOI and TOI-cleaned from the Whole Brain
    % Connecteome.
    
    % Now let's get the indices of the fibers in the Whole-brain
    % connectome. We want to remove these fibers from the whole-brain
    % connectome.
    fasIndicesInWBC = find(indicesRoi1ToRoi2);
    fasIndicesInWBC = fasIndicesInWBC(~fibers2delete);
    fprintf('\n[%s] Deleting %i fibers out of %i fibers found touching the two ROIs from the WB connectome\n', ...
            mfilename,sum(~fibers2delete),length(wbc.fibers))
    wbc             = fgExtract(wbc,fasIndicesInWBC,'remove');

    
    % (5) Clip the connectome to the WM-mask
    fprintf('[%s] Intersecting WB connectome with WM mask', mfilename)
    wm  = dtiImportRoiFromNifti(sub_wmmask_track,'WM');
    wbc = dtiIntersectFibersWithRoi([], 'and', [], wm, wbc);
    fprintf('[%s] Clipping WB connectome to WM mask', mfilename)
    wbc = feClipFibersToVolume(wbc,wm.coords,.83);
    % Show the ROI to catch any potential problems:
    % roi = dtiCreateRoiFromFibers(fg);toc
    % plot3(roi.coords(:,1),roi.coords(:,2),roi.coords(:,3),'g.');
    
    % (6) Merge the new TOI with the clipped WB-connectome
    nWBCfibers = fefgGet(wbc,'nfibers');
    wbcMerged  = fgMerge(wbc,TOI,'WBC and TOI');
    
    % (7) Build the LiFE model
    fe = feConnectomeInit(sub_dwi_processed, ...
        wbcMerged,'WBC_TOI', ...
        fibersFolder, ...
        sub_dwi_processed, ...
        sub_t1w_acpc);
    
    % (8) Fit the LiFE model
    fit = feFitModel(feGet(fe,'mfiber'), ...
                     feGet(fe,'dsigdemeaned'), ...
                     'bbnnls');
    fe  = feSet(fe,'fit',fit);
    clear fit
    feConnectomeSave(fe);
    
    % (9) Perform a virtual lesion (note the indices of the fibers to tract are
    %     number of fibers in the tract to lesion are nFibers_in_clipped_WB_connectome+1:end
    indices2toi = (nWBCfibers+1) : (nWBCfibers+nTOIfibers);
    
    % set up display information, we want to show plots of the results:
    display.tract         = true;
    display.distributions = true;
    display.evidence      = true;
    [se, fig] = feVirtualLesion(fe, indices2toi', display, false);
    
    % saves figures for subject
    for ifig = 1:length(fig)
        feSavefig(fig(ifig).h, ...
            'figType', fig(ifig).type, ...
            'figDir', fullfile(lifeFolder), ...
            'figName',fig(ifig).name)
    end
    
    % saves strength of evidence for subject
    subjectSeName = fullfile(lifeFolder,[subjects{isubj} '_rh_se_roicombo.mat']);
    save(subjectSeName, 'se');
    
    % close figures for subject
    %close all
    
    % clear variables to save RAM
    clear se fe wbc nWBCfibers wbcMerged TOI fasciclesRoi1ToRoi2Clean
    
  
end

return