function s_plstc_roi_clip_presma
%
% This script loads a NIFTI wmMask ROI, clips specific coordinates
% makes smallest wmmask for LiFE on insula->nacc fibers
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/lcne/matproc';

subjects = {'ad082014_2','hm082514_2','ml082214_2', ...
            'ld080115_1','ld080115_2', ...
            'lp080215_1','lp080215_2', ...
            'lt081615_1','lt081615_2', ...
            'mm080915_1','mm080915_2', ...
            'nb081015_1','nb081015_2'};
%{
'ad082014_1','ad082014_2', ...
            'hm082514_1','hm082514_2', ...
            'ml082214_1','ml082214_2', ...
            'yw083014_1','yw083014_2'};
%}

hemis = {'lh','rh'};

for isubj = 1:length(subjects)
    refImg = fullfile(datapath, subjects{isubj}, [subjects{isubj} '_t1_acpc.nii.gz']);
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    for hemi = 1:length(hemis)
        oldroiName = [hemis{hemi} '_supfront_a2009s_fd.mat'];
        newroiName = [hemis{hemi} '_supfront_clip_presma.mat'];
        roi = dir(fullfile(roiPath, oldroiName));
        oldRoi = roi.name;
        oldRoiPath = fullfile(roiPath, oldRoi);
        outRoiMat = [roiPath '/' newroiName];
        oldRoiLoad = dtiReadRoi(oldRoiPath);
        
        %clip in two steps
        ap_coords1 = [-120 0];
        %si_coords1 = [0 80];
        newRoi     = dtiRoiClip(oldRoiLoad, [], ap_coords1, []);
        
        ap_coords2 = [36 80];
        newRoi2 = dtiRoiClip(newRoi, [], ap_coords2, []);
        
        %save as mat and nifti
        dtiWriteRoi(newRoi2, outRoiMat);
        dtiRoiNiftiFromMat(outRoiMat,refImg,[],1);
    end
end