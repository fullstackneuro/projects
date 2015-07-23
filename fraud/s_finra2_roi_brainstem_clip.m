function s_finra2_roi_brainstem_clip
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/storg/matproc';

subjects = {'ab071412','bc050913','bk032113','bk053012','ch101612', ...
            'cs050813','dc050213','dp092612','ds080712','ec081912', ...
            'en062813','fg092712','gr051513','hg101012','hm062513', ...
            'jh042913','jl071912','jo081312','jt062413','jw072512', ...
            'kr030113','lc052213','lf052813','lw061713','md072512', ...
            'mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713', ...
            'pw061113','ra053013','rb073112','rb082212','sd040313', ...
            'sh010813','sl080912','sn061213','sp061313','tr101312', ...
            'tw062113','vv060313','wb071812'};
        
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = dir(fullfile(roiPath,'brainstem_aseg.mat'));
    oldRoi = roi.name;
    oldRoiPath = fullfile(roiPath, oldRoi);
    outRoi = [roiPath '/brainstem_clip.mat'];
    oldRoiLoad = dtiReadRoi(oldRoiPath);
    
    %clip in two steps
    %rl_coords1 = [-80 -50];
    %RH coords [50 80]
    %LH coords [-80 -50]
    %ap_coords1 = [-120 -40];
    si_coords1 = [-60 -30];
    
    newRoi     = dtiRoiClip(oldRoiLoad,[], [], si_coords1);
    
    dtiWriteRoi(newRoi, outRoi);
end