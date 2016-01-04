function s_plasticity_make_ant_nacc_roi
%
% This script loads a NIFTI thalamus ROI, intersects it with fibers,
% creates new ROI. Use these ROIs as thalamic parcellations to mask DWI.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/storg/matproc';

subjects = {'mm080915_1_hardi1','mm080915_1_hardi2','mm080915_1_hardi3','mm080915_1_hardi4', ...
            'mm080915_2_hardi1','mm080915_2_hardi2','mm080915_2_hardi3','mm080915_2_hardi4', ...
            'nb081015_1_hardi1','nb081015_1_hardi2','nb081015_1_hardi3','nb081015_1_hardi4', ...
            'nb081015_2_hardi1','nb081015_2_hardi2','nb081015_2_hardi3','nb081015_2_hardi4', ...
            'ld080115_1_hardi1','ld080115_1_hardi2','ld080115_1_hardi3','ld080115_1_hardi4', ...
            'ld080115_2_hardi1','ld080115_2_hardi2','ld080115_2_hardi3','ld080115_2_hardi4', ...
            'lp080215_1_hardi1','lp080215_1_hardi2','lp080215_1_hardi3','lp080215_1_hardi4', ...
            'lp080215_2_hardi1','lp080215_2_hardi2','lp080215_2_hardi3','lp080215_2_hardi4', ...
            'lt081615_1_hardi1','lt081615_1_hardi2','lt081615_1_hardi3','lt081615_1_hardi4', ...
            'lt081615_2_hardi1','lt081615_2_hardi2','lt081615_2_hardi3','lt081615_2_hardi4'};

%load nacc ROI
naccmat = 'rh_nacc_aseg.mat';
%load each tract
%tracts = {'unclean_lh_vta_nacc.mat', ...
%          'unclean_lh_mpfc_nacc.mat'};

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    naccRoi = dtiReadRoi(fullfile(roiPath, naccmat));
    %fibersFolder = fullfile(datapath, subjects{isubj}, '/dti96trilin/fibers/conTrack');
    meancoord = mean(naccRoi.coords(:,2));
    stdcoord = std(naccRoi.coords(:,2));
    cutoff = round(meancoord + stdcoord);
    antidx = naccRoi.coords(:,2) > cutoff;
    antCoords = naccRoi.coords(antidx,1:3);
    newRoi = dtiNewRoi(naccmat);
    newRoi.coords = antCoords;
    outRoi = fullfile(roiPath, ['antnaccROI_' naccmat]);
    dtiWriteRoi(newRoi, outRoi);
end