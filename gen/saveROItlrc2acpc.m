% convert talairach ROI
% (1) mat
% (2) acpc space

% convert nifti to mat
outType = 'mat';
dtiRoiFromNifti(roipath, outType);
dtiImportRoiFromNifti(roipath, '/media/lcne/matproc/ROIs/rPVTtlrc.mat');

% load tlrc pvt
roipath = '/media/lcne/matproc/ROIs/rPVTtlrc.mat';
roiload = load(roipath);

% load subject acpc
dt6path = '/media/lcne/matproc/jh160702/dti96trilin/dt6.mat';
dt6load = dtiLoadDt6(dt6path);

% compute acpc2tlrc transform
mrAnatAcpc2Tal(talScale, dt6);

% compute tlrc2acpc transform
brainmaskpath = '/media/lcne/matproc/jh160702/jh160702_t1_acpc.nii.gz';
brainmask = niftiRead(brainmaskpath);
brainmaskxform = load('/media/lcne/matproc/jh160702/jh160702_aligned_trilin_acpcXform');

talScale = mrAnatGetTalairachScalesFromMask(brainmask.data, brainmaskxform.acpcXform);

%dtiRoiCoordsFromImg(roiload.data, roiload.

% compute xform
newroicoords = mrAnatTal2Acpc(talScale, roiload.roi.coords);

% save coords to acpc mat?
dtiRoiToImg(newroicoords, brainmaskxform.acpcXform);

