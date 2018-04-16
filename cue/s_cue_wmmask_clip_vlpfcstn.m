function s_cue_wmmask_clip_vlpfcstn
%
% This script loads a NIFTI wmMask ROI, clips specific coordinates
% makes smallest wmmask for LiFE on insula->nacc fibers
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/storg/matproc/';

subjects = {'lf052813','sn061213','tw062113'};
        
for isubj = 1:length(subjects)
    refImg = fullfile(datapath, subjects{isubj}, [subjects{isubj} '_t1_acpc.nii.gz']);
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = dir(fullfile(roiPath,'rh_wmmask_fs_fd.mat'));
    oldRoi = roi.name;
    oldRoiPath = fullfile(roiPath, oldRoi);
    outRoiMat = [roiPath '/rh_wmmask_clip_vlpfcstn.mat'];
    oldRoiLoad = dtiReadRoi(oldRoiPath);
    
    %clip in two steps
    ap_coords1 = [-120 -30];
    si_coords1 = [30 80];
    %right hemi= [-80 0];
    %left hemi = [0 80];
    lr_coords1 = [-80 0];
    newRoi     = dtiRoiClip(oldRoiLoad, lr_coords1, ap_coords1, si_coords1);
    
    ap_coords2 = [45 80];
    si_coords2 = [-60 -10];
    newRoi2 = dtiRoiClip(newRoi, [], ap_coords2, si_coords2);
    
    %save as mat and nifti
    dtiWriteRoi(newRoi2, outRoiMat);
    dtiRoiNiftiFromMat(outRoiMat,refImg,[],1);
end