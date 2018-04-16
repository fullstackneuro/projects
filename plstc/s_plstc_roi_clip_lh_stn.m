function s_plstc_roi_clip_lh_stn
%
% This script loads a NIFTI wmMask ROI, clips specific coordinates
% makes smallest wmmask for LiFE on insula->nacc fibers
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/lcne/matproc';

subjects = {'ad082014_1','ad082014_2', ...
            'hm082514_1','hm082514_2', ...
            'ml082214_1','ml082214_2', ...
            'yw083014_1','yw083014_2', ...
            'ld080115_1','ld080115_2', ...
            'lp080215_1','lp080215_2', ...
            'lt081615_1','lt081615_2', ...
            'mm080915_1','mm080915_2', ...
            'nb081015_1','nb081015_2'};

for isubj = 1:length(subjects)
    refImg = fullfile(datapath, subjects{isubj}, [subjects{isubj} '_t1_acpc.nii.gz']);
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = dir(fullfile(roiPath,'lh_ventraldc_aseg_fd.mat'));
    oldRoi = roi.name;
    oldRoiPath = fullfile(roiPath, oldRoi);
    outRoiMat = [roiPath '/lh_ventraldc_clip_stn.mat'];
    %outRoiNii = [roiPath '/lh_wmmask_fs_fd_clip_insnacc.nii.gz'];
    oldRoiLoad = dtiReadRoi(oldRoiPath);
    
    %clip in two steps
    lr_coords1 = [-4 80];
    ap_coords1 = [-120 -21];
    si_coords1 = [1 80];
    newRoi     = dtiRoiClip(oldRoiLoad, lr_coords1, ap_coords1, si_coords1);
    
    lr_coords2 = [-80 -16];
    ap_coords2 = [-9 80];
    si_coords2 = [-60 -11];
    newRoi2 = dtiRoiClip(newRoi, lr_coords2, ap_coords2, si_coords2);
    
    %save as mat and nifti
    dtiWriteRoi(newRoi2, outRoiMat);
    dtiRoiNiftiFromMat(outRoiMat,refImg,[],1);
end