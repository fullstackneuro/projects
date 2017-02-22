function s_cue_roi_clip_presma
%
% This script loads a NIFTI wmMask ROI, clips specific coordinates
% makes smallest wmmask for LiFE on insula->nacc fibers
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/lcne/matproc';

subjects = {'zl150930'};

%{
'am160914','kn160918','ld160918','li160927'
'ac160415','jh160702','jr160507','mp160511','ps160508'
'ab071412','al151016','bb160402','bk032113','bp160213','cs160214','dc050213', ...
            'ds080712','en062813','gr051513','hm062513','jc160320','jc160321','jg151121', ...
            'jl071912','jt062413','jv151030','jw072512','jw160316','lc052213', ...
            'mk021913','ml061013','np072412','pk160319','ps151001','pw060713','rb160407', ...
            'rf160313','sp061313','wb071812','zl150930'
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