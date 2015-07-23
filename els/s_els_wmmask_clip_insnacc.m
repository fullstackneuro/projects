function s_els_wmmask_clip_insnacc
%
% This script loads a NIFTI wmMask ROI, clips specific coordinates
% makes smallest wmmask for LiFE on insula->nacc fibers
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/storg/matproc';

subjects =  {'els006','els009','els012','els034','els040','els058','els059', ...
             'els060','els061','els062','els075','els086','els089','els090', ...
             'els092','els095','els097','els099','els100'};

for isubj = 1:length(subjects)
    refImg = fullfile(datapath, subjects{isubj}, [subjects{isubj} '_t1_acpc.nii.gz']);
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = dir(fullfile(roiPath,'rh_wmmask_fs_fd.mat'));
    oldRoi = roi.name;
    oldRoiPath = fullfile(roiPath, oldRoi);
    outRoiMat = [roiPath '/rh_wmmask_fs_fd_clip_insnacc.mat'];
    %outRoiNii = [roiPath '/lh_wmmask_fs_fd_clip_insnacc.nii.gz'];
    oldRoiLoad = dtiReadRoi(oldRoiPath);
    
    %clip in two steps
    ap_coords1 = [-120 -10];
    si_coords1 = [10 80];
    newRoi     = dtiRoiClip(oldRoiLoad, [], ap_coords1, si_coords1);
    
    ap_coords2 = [30 80];
    newRoi2 = dtiRoiClip(newRoi, [], ap_coords2, []);
    
    %save as mat and nifti
    dtiWriteRoi(newRoi2, outRoiMat);
    dtiRoiNiftiFromMat(outRoiMat,refImg,[],1);
end