%manual plotting and tweaking for all fibergroups of every subject

%ac160415

baseDir = '/media/lcne/matproc';
figuresDir = '/media/storg/matproc/figures';

%load t1
ti = niftiRead('/media/lcne/matproc/ps160508/ps160508_t1_acpc.nii.gz');

%fiber directory
mrtrix_wd = '/media/lcne/matproc/ps160508/dti96trilin/fibers/mrtrix';

%right hemisphere
%load vlpfc-stn tract
rh_vlpfcstnName = fullfile(mrtrix_wd,'clean_rh_frontorb_stn.mat');
rh_vlpfcstn = fgRead(rh_vlpfcstnName);
%load mpfc tract
rh_presmastnName = fullfile(mrtrix_wd,'clean_rh_presma_stn.mat');
rh_presmastn = fgRead(rh_presmastnName);

fgh = figure('position',[0 0 1000 900]);
mbaDisplayBrainSlice(ti,[-3 0 0])
hold on
mbaDisplayBrainSlice(ti,[0 -28 0])
mbaDisplayBrainSlice(ti,[0 0 -13])
[fh, lh] = mbaDisplayConnectome(rh_vlpfcstn.fibers,fgh,[0,0.2,0.38],'single',[],[],0.2);
delete(lh);
[fh, lh] = mbaDisplayConnectome(rh_presmastn.fibers,fgh,[0.33, 0.16, 0.31],'single',[],[],0.2);
delete(lh);
view(105,8);
axis([-5 60 -30 90 -10 80]);
lh = lightangle(90,10);

%save figure
rfigurename = ['ps160508_rh_vlpfcpresmastn'];
feSavefig(fh,'figName',rfigurename,'figDir','/media/lcne/matproc/figures/vlpfc','figType','jpg')





%%%%old code for figures
%{
%right hemisphere
%load insula tract
mrtrix_wd = '/media/storg/matproc/dp092612/dti96trilin/fibers/mrtrix';
rh_insula = fullfile(mrtrix_wd,'clean_rh_antshortins_nacc.mat');
rinsula = fgRead(rh_insula);
%load mpfc tract
mpfc_wd = '/media/storg/matproc/dp092612/dti96trilin/fibers/conTrack/frontostriatal';
rh_mpfc = fullfile(mpfc_wd,'clean_rh_mpfc_nacc.mat');
rmpfc = fgRead(rh_mpfc);              
%load vta tract
vta_wd = '/media/storg/matproc/dp092612/dti96trilin/fibers/conTrack/mesolimbic';
rh_vta = fullfile(vta_wd,'clean_rh_vta_nacc.mat');
rvta = fgRead(rh_vta);
%plot
rfgh = figure('position',[0 0 1000 900]);
mbaDisplayBrainSlice(ti,[3 0 0])
hold on
mbaDisplayBrainSlice(ti,[0 -28 0])
mbaDisplayBrainSlice(ti,[0 0 -13])
[rfh, rlh] = mbaDisplayConnectome(rmpfc.fibers,rfgh,[0.7,0.98,0.98],'single',[],[],0.3);
%delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rvta.fibers,rfgh,[0.96,0.84,0.6],'single',[],[],0.3);
%delete(lh);
view(130,20);
axis([0 60 -50 90 -9 70]);
rlh = lightangle(130,20);
%save figure
feSavefig(rfh,'figName','dp092612_rh_insula','figDir','/media/storg/matproc/figures','figType','jpg')
%}
