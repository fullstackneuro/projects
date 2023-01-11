function a_abcd_make_and_smooth_roi
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/mnt/acorn/abcd/matproc';

%subjects = a_abcd_generate_sublists('fd');
%subjects = {'NDARINVMWCVEXRK'};
%read subjects in from text file
subjects={};
file=fopen('/mnt/acorn/abcd/matproc/scripts/amyg_xform_makeup.txt','r');
tline=fgetl(file);
while ischar(tline)
    disp(tline)
    subjects=[subjects, tline];
    tline=fgetl(file);
end

%subjects={'NDARINVLGJH5VV9'};
rois = {'lh_amygnacc_merged', 'rh_amygnacc_merged'};

%{
  'lh_antins_a2009s', 'rh_antins_a2009s', 'lh_shortins_a2009s', 'rh_shortins_a2009s', 'lh_mpfc8mmmni', 'rh_mpfc8mmmni', ...
    'lh_vtapbp', 'rh_vtapbp', 'lh_amyg_aseg', 'rh_amyg_aseg', 'lh_nacc_aseg', 'rh_nacc_aseg', 'lh_wmmask_fs', 'rh_wmmask_fs'  
%}
              
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    disp(['working on subject ' subjects{isubj}]);
    for iroi = 1:length(rois)
        try
            roi = fullfile(roiPath, [rois{iroi} '.mat']);
            outRoi = fullfile(roiPath, [rois{iroi} '_fd.mat']);
            smoothKernel = 0; % size of the 3D smoothing Kernel in mm
            %operations   = ['fillholes', 'dilate', 'removesat']; 
            operations   = [1, 1, 0]; 

            % fillholes = fill any hole in the ROI. Pass '' to not apply this
            %             operation
            % dilate     = expand the ROI in 3D. Pass '' to not apply this
            %             operation
            % removesat  = remove any voxel disconnected from the rest of the voxels. 
            %              Pass '' to not apply this operation

            oldRoiLoad = dtiReadRoi(roi);
            newRoi = dtiRoiClean(oldRoiLoad, smoothKernel, operations);
            dtiWriteRoi(newRoi, outRoi);
        catch e
            disp(e.identifier);
            disp(e.message);
        end
    end
end