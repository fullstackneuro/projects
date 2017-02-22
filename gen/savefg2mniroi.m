%save a fiber group in subject acpc space to MNI ROI


%load fiber group
fgpath = '/media/storg/matproc/dp092612/dti96trilin/fibers/mrtrix/clean_rh_antshortins_nacc.mat';
fgload = dtiLoadFiberGroup(fgpath);

%load dt6
dt6path = '/media/storg/matproc/dp092612/dti96trilin/dt6.mat';

%compute transform to MNI
[sn,defxform] = dtiComputeFgToMNItransform(dt6path);

%save fiber group to MNI coords
fg_sn = dtiXformFiberCoords(fgload, defxform);

%convert fiber group to ROI
newroi = dtiCreateRoiFromFibers(fg_sn,'mni_rh_ains_nacc');

%load t1 reference
t1path = '/media/storg/matproc/dp092612/dp092612_t1_acpc.nii.gz';

%save new roi
dtiRoiNiftiFromMat(newroi, t1path, 'mni_rh_ains_nacc');



%left hemisphere


%load fiber group
fgpath = '/media/storg/matproc/dp092612/dti96trilin/fibers/mrtrix/cleanformni_lh_antshortins_nacc.mat';
fgload = dtiLoadFiberGroup(fgpath);

%load dt6
dt6path = '/media/storg/matproc/dp092612/dti96trilin/dt6.mat';

%compute transform to MNI
[sn,defxform] = dtiComputeFgToMNItransform(dt6path);

%save fiber group to MNI coords
fg_sn = dtiXformFiberCoords(fgload, defxform);

%convert fiber group to ROI
newroi = dtiCreateRoiFromFibers(fg_sn,'mni_lh_ains_nacc');

%load t1 reference
t1path = '/media/storg/matproc/dp092612/dp092612_t1_acpc.nii.gz';

%save new roi
dtiRoiNiftiFromMat(newroi, t1path, 'mni_lh_ains_nacc');