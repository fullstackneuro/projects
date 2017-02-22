function s_cue_wmmask_clip_mpfcnacc
%
% This script loads a NIFTI wmMask ROI, clips specific coordinates
% makes smallest wmmask for LiFE on insula->nacc fibers
%
% Copyright Franco Pestilli (c) Stanford University, 2014

%datapath = '/media/lcne/matproc/';
%subjects = {'am160914','kn160918','ld160918','li160927','ac160415','jh160702','jr160507','mp160511','ps160508'};

datapath = '/media/storg/matproc/';
subjects = {'ab071412','al151016','bb160402','bk032113','bp160213','cs160214','dc050213', ...
            'ds080712','en062813','gr051513','hm062513','jc160320','jc160321','jg151121', ...
            'jl071912','jt062413','jv151030','jw072512','jw160316','lc052213', ...
            'mk021913','ml061013','np072412','pk160319','ps151001','pw060713','rb160407', ...
            'rf160313','sp061313','wb071812','zl150930'};
       
for isubj = 1:length(subjects)
    refImg = fullfile(datapath, subjects{isubj}, [subjects{isubj} '_t1_acpc.nii.gz']);
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = dir(fullfile(roiPath,'lh_wmmask_fs_fd.mat'));
    oldRoi = roi.name;
    oldRoiPath = fullfile(roiPath, oldRoi);
    outRoiMat = [roiPath '/lh_wmmask_clip_mpfcnacc.mat'];
    oldRoiLoad = dtiReadRoi(oldRoiPath);
    
    %clip in two steps
    ap_coords1 = [-120 10];
    si_coords1 = [-60 -10];
    %right hemi= [-80 0] ; left hemi = [0 80];
    lr_coords1 = [0 80];
    newRoi     = dtiRoiClip(oldRoiLoad, lr_coords1, ap_coords1, si_coords1);
    
    ap_coords2 = [60 80];
    si_coords2 = [20 80];
    %right hemi = [40 80] ; left hemi = [-80 -40]
    lr_coords2 = [-80 -40];
    newRoi2 = dtiRoiClip(newRoi, lr_coords2, ap_coords2, si_coords2);
    
    %save as mat and nifti
    dtiWriteRoi(newRoi2, outRoiMat);
    dtiRoiNiftiFromMat(outRoiMat,refImg,[],1);
end