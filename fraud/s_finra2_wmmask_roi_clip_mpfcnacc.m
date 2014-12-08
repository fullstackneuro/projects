function s_finra2_wmmask_roi_clip_mpfcnacc
%
% This script loads a NIFTI wmMask ROI, clips specific coordinates
% makes smallest wmmask for LiFE on insula->nacc fibers
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/storg/matproc';

subjects = {'ab071412','bc050913','bk032113','ch101612', ...
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
    refImg = fullfile(datapath, subjects{isubj}, [subjects{isubj} '_t1_acpc.nii.gz']);
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = dir(fullfile(roiPath,'rh_wmmask_fs_fd_clip_mpfc_fiberRoi.mat'));
    oldRoi = roi.name;
    oldRoiPath = fullfile(roiPath, oldRoi);
    outRoiMat = [roiPath '/rh_wmmask_fs_fd_clip_mpfcnacc.mat'];
    %outRoiNii = [roiPath '/lh_wmmask_fs_fd_clip_insnacc.nii.gz'];
    oldRoiLoad = dtiReadRoi(oldRoiPath);
    
    %clip in two steps
    % right hemisphere:: rl_coords1 = [20 60];
    %left hemisphererl_coords1 = [-60 -25];
    rl_coords1 = [25 60];
    ap_coords1 = [-100 0];
    si_coords1 = [20 80];
    newRoi     = dtiRoiClip(oldRoiLoad, rl_coords1, ap_coords1, si_coords1);
    
    %ap_coords2 = [30 80];
    %newRoi2 = dtiRoiClip(newRoi, [], ap_coords2, []);
    
    %save as mat and nifti
    dtiWriteRoi(newRoi, outRoiMat);
    dtiRoiNiftiFromMat(outRoiMat,refImg,[],1);
end