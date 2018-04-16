function s_cue_roi_clip_rh_stn
%
% This script loads a NIFTI wmMask ROI, clips specific coordinates
% makes smallest wmmask for LiFE on insula->nacc fibers
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/storg/matproc';
subjects = {'sh010813','sn061213'};

%{
presma-stn and vlpfc-stn same
storg
'ec081912','jh042913','jo081312','kr030113','lf052813','ps022013','ra053013','sd040313','sh010813','sn061213','tw062113
lcne
'er170121','gm161101','hw161104','jw170330','ph161104'

left ains-vlpfc
'ec081912','jh042913','jo081312','kr030113','lf052813','ps022013','ra053013','sd040313','sh010813','sn061213','tw062113'

mpfc-nacc?
%}

for isubj = 1:length(subjects)
    refImg = fullfile(datapath, subjects{isubj}, [subjects{isubj} '_t1_acpc.nii.gz']);
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = dir(fullfile(roiPath,'rh_ventraldc_aseg_fd.mat'));
    oldRoi = roi.name;
    oldRoiPath = fullfile(roiPath, oldRoi);
    outRoiMat = [roiPath '/rh_ventraldc_clip_stn.mat'];
    oldRoiLoad = dtiReadRoi(oldRoiPath);
    
    %clip in two steps
    lr_coords1 = [16 80];
    ap_coords1 = [-120 -21];
    si_coords1 = [1 80];
    newRoi     = dtiRoiClip(oldRoiLoad, lr_coords1, ap_coords1, si_coords1);
    
    lr_coords2 = [-80 4];
    ap_coords2 = [-9 80];
    si_coords2 = [-60 -11];
    newRoi2 = dtiRoiClip(newRoi, lr_coords2, ap_coords2, si_coords2);
    
    %save as mat and nifti
    dtiWriteRoi(newRoi2, outRoiMat);
    dtiRoiNiftiFromMat(outRoiMat,refImg,[],1);
end