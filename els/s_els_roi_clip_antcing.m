function s_els_roi_clip_antcing
%
% This script loads a NIFTI wmMask ROI, clips specific coordinates
% makes smallest wmmask for LiFE on insula->nacc fibers
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/lcne/matproc';

subjects = {'els016','els026','els075'};

hemis = {'lh','rh'};

for isubj = 1:length(subjects)
    refImg = fullfile(datapath, subjects{isubj}, [subjects{isubj} '_t1_acpc.nii.gz']);
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    for hemi = 1:length(hemis)
        oldroiName = [hemis{hemi} '_antcing_a2009s_fd.mat'];
        newroiName = [hemis{hemi} '_antcing_a2009s_fd_clip.mat'];
        roi = dir(fullfile(roiPath, oldroiName));
        oldRoi = roi.name;
        oldRoiPath = fullfile(roiPath, oldRoi);
        outRoiMat = [roiPath '/' newroiName];
        oldRoiLoad = dtiReadRoi(oldRoiPath);
        
        %clip in two steps
        %ap_coords1 = [-120 -20];
        si_coords1 = [15 80];
        newRoi     = dtiRoiClip(oldRoiLoad, [], [], si_coords1);
        
        %save as mat and nifti
        dtiWriteRoi(newRoi, outRoiMat);
        dtiRoiNiftiFromMat(outRoiMat,refImg,[],1);
    end
end