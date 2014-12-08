%set up script for LiFE
%
%MAKE SURE TO EDIT HEMISPHERE

subjects = {'ab071412','bc050913','bk032113','ch101612','cs050813', ...
            'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            'gr051513','hg101012','hm062513','jh042913','jo081312', ...
            'jt062413','jw072512','kr030113','lf052813','lw061713', ...
            'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'};
    
            %all subjects
            %'ab071412','bc050913','bk032113','bk053012','ch101612','cs050813', ...
            %'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            %'gr051513','hg101012','hm062513','jh042913','jl071912','jo081312', ...
            %'jt062413','jw072512','kr030113','lc052213','lf052813','lw061713', ...
            %'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            %'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            %'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            %'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'       
        
            %done
           
baseDir = '/media/storg/matproc/';

for isubj = 1:length(subjects)
    %% (0) Set up paths and filenames
    % Base subject folder
    subjectDir    = [subjects{isubj}];
    subjectFolder = fullfile(baseDir, subjectDir);
    
    % make life folder if doesn't exist
    lifeFolder    = fullfile(subjectFolder, '/dti96trilin/fibers/conTrack/frontostriatal/life/lh_nowbc');
        if ~exist(lifeFolder,'dir'); mkdir(lifeFolder); end 
        
    % T1 high resolution anatomy
    subjectRefImg = [subjects{isubj} '_t1_acpc.nii.gz'];
    sub_t1w_acpc  = fullfile(subjectFolder, subjectRefImg);
    
    % Fibers and tracts
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix');
    sub_wbc       = fullfile(fibersFolder, 'lmax2_wbc.mat');
    
    conTrackFolder = fullfile(subjectFolder, '/dti96trilin/fibers/conTrack/frontostriatal');
    sub_roi2roi_track = fullfile(conTrackFolder, 'clean_lh_mpfc_nacc.mat');
       
    % ROIs and WM masks
    roiFolder        = fullfile(baseDir, subjectDir, '/ROIs');
    sub_wmmask_track = fullfile(roiFolder, 'lh_wmmask_fs_fd_clip_mpfcnacc.nii.gz');
    
    roiBinFolder = fullfile(subjectFolder, '/dti96trilin/bin');
    sub_roi1 = fullfile(roiBinFolder, 'lh_mpfc_4mm_lh_nacc_aseg_fd_2014-09-12_12.44.53.nii.gz');
    %sub_roi2 = fullfile(roiFolder, 'lh_nacc_aseg_fd.nii.gz');
    
    % DWI files
    fullsubjectAcqName = dir(fullfile(subjectFolder, '*.bvals'));
    [~, subAcqName,~]  = fileparts(fullsubjectAcqName.name);
    sub_dwi_bvec       = fullfile(subjectFolder, [subAcqName, '.bvecs']);
    sub_dwi_bval       = fullfile(subjectFolder, [subAcqName, '.bvals']);
    sub_dwi_processed  = fullfile(subjectFolder, [subAcqName, '.nii.gz']);
    
    %% (1) Find fibers in WB-connectome between ROI1 and ROI2
    % Find the fascicles in the connectome that touch both ROIs.
    roi1 = dtiImportRoiFromNifti(sub_roi1,'ROI1');
    %roi2 = dtiImportRoiFromNifti(sub_roi2,'ROI2');
    %roi_combined = dtiNewRoi('combined_roi');
    %roi_combined.coords   = [roi1.coords;roi2.coords];
    wbc          = fgRead(sub_wbc);
      
    tract = fgRead(sub_roi2roi_track);

    TOI = tract;
    nTOIfibers = fefgGet(TOI,'nfibers');
    
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
    subjectSeName = fullfile(lifeFolder,[subjects{isubj} '_lh_se_nowbc.mat']);
    save(subjectSeName, 'se');
    
    % close figures for subject
    %close all
    
    % clear variables to save RAM
    clear se fe wbc TOI
    
  
end

return