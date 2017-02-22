function s_cue_wmmask_clip_insnacc
%
% This script loads a NIFTI wmMask ROI, clips specific coordinates
% makes smallest wmmask for LiFE on insula->nacc fibers
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/lcne/matproc/';
%datapath = '/media/storg/matproc/';
subjects = {'am160914','kn160918','ld160918','li160927'};

%{
'ac160415','jh160702','jr160507','mp160511','ps160508'
subjects = {'al151016','bb160402','bp160213','cs160214', ...
            'jc160320','jc160321','jg151121', ...
            'jv151030','jw160316', ...
            'pk160319','ps151001','rb160407','rf160313', ...
            'zl150930'};

        %add for loop to go across hemispheres
%}
for isubj = 1:length(subjects)
    refImg = fullfile(datapath, subjects{isubj}, [subjects{isubj} '_t1_acpc.nii.gz']);
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    roi = dir(fullfile(roiPath,'rh_wmmask_fs_fd.mat'));
    oldRoi = roi.name;
    oldRoiPath = fullfile(roiPath, oldRoi);
    outRoiMat = [roiPath '/rh_wmmask_clip_ainsnacc.mat'];
    %outRoiMat = [roiPath '/lh_wmmask_clip_ainsnacc.mat'];
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