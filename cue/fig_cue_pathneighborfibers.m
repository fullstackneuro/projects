%tract and path neighborhood fibers

baseDir = '/media/lcne/matproc';
figuresDir = '/media/storg/lcne/figures/vlpfc';

subjects = {'ac160415'};

%load t1
ti = niftiRead('/media/lcne/matproc/ac160415/ac160415_t1_acpc.nii.gz');

%fiber directory
mrtrix_wd = '/media/lcne/matproc/ac160415/dti96trilin/fibers/mrtrix';

%right hemisphere
%load vlpfc-ins tract
rh_vlpfcinsName = fullfile(mrtrix_wd,'clean_rh_frontorb_shortins.mat');
rh_vlpfcins = fgRead(rh_vlpfcinsName);

fgh = figure('position',[0 0 1000 900]);
mbaDisplayBrainSlice(ti,[-3 0 0])
hold on
mbaDisplayBrainSlice(ti,[0 -28 0])
mbaDisplayBrainSlice(ti,[0 0 -13])
[fh, lh] = mbaDisplayConnectome(rh_vlpfcins.fibers,fgh,[0,0.2,0.38],'single',[],[],0.2);
delete(lh);
[fh, lh] = mbaDisplayConnectome(rh_presmastn.fibers,fgh,[0.33, 0.16, 0.31],'single',[],[],0.2);
delete(lh);
view(105,8);
axis([-5 60 -30 90 -10 80]);
lh = lightangle(90,10);

%save figure
rfigurename = ['ps160508_rh_vlpfcpresmastn'];
feSavefig(fh,'figName',rfigurename,'figDir','/media/lcne/matproc/figures/vlpfc','figType','jpg')
    
%create right hemisphere plot of all tracts`
rfgh = figure('position',[100 200 1000 900]);
mbaDisplayBrainSlice(ti,[2 0 0])
hold on
mbaDisplayBrainSlice(ti,[0 9 0])
mbaDisplayBrainSlice(ti,[0 0 -13])
[rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
delete(rlh);
view(155,17);
axis([0 60 -50 90 -9 70]);
rlh = lightangle(135,17);
%save figure
feSavefig(rfh,'figName',[subjects{isubj} '_rh_insnaccfibersonly'],'figDir','/media/storg/matproc/dp092612/dti96trilin/fibers/life/forfigs','figType','jpg')


%random sample 5% path neighborhood fibers
fibers2display = randsample(1:length(rinsPathFibers.fibers),ceil(0.05*length(rinsPathFibers.fibers)));

%plot fibers with path neighborhood (add ROIs?), on anatomy
rfgh = figure('position',[100 200 1000 900]);
mbaDisplayBrainSlice(ti,[-1 0 0])
hold on
mbaDisplayBrainSlice(ti,[0 9 0])
mbaDisplayBrainSlice(ti,[0 0 -13])
[rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
delete(rlh);
[rfh, rlh] =  mbaDisplayConnectome(mbaFiberSplitLoops(...
    rinsPathFibers.fibers(fibers2display)),rfgh, [.91 .9 .89],'single',[],[],.2);
delete(rlh);
view(165,19);
axis([0 60 -50 90 -9 70]);
rlh = lightangle(130,20);

%test colors of path neighborhood fibers
rfgh = figure('position',[100 200 1000 900]);
mbaDisplayBrainSlice(ti,[-1 0 0])
hold on
mbaDisplayBrainSlice(ti,[0 -28 0])
mbaDisplayBrainSlice(ti,[0 0 -13])
[rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
delete(rlh);
[rfh, rlh] =  mbaDisplayConnectome(mbaFiberSplitLoops(...
    rinsPathFibers.fibers(fibers2display)),rfgh, [.93 .89 .79],'single',[],[],.2);
delete(rlh);
view(150,10);
axis([0 60 -50 90 -9 70]);
rlh = lightangle(130,20);


%first have to fgWrite path neighborhood fibers during feVirtualLesion,
%after se = feComputeEvidence (line 85)
tmp_fas = feGet(feNoLesion,'fibers acpc');
fgWrite(tmp_fas, '/media/storg/matproc/dp092612/dti96trilin/fibers/life/forfigs/dp092612_fasacpc.mat','.mat')


%defaults from feVirtualLesion
tmp_fas = feGet(feNoLesion,'fibers acpc');
fig(5).name = sprintf('pathneighborhood_AND_tract_%s',mfilename);
fig(5).h   = figure('name',fig(5).name,'color',[.1 .45 .95]);
fig(5).type = 'jpg';
[fig(5).h, fig(5).light] =  mbaDisplayConnectome(mbaFiberSplitLoops(fasAcpc.fibers),fig(5).h, [.1 .45 .95],'single',[],[],.2);
view(-23,-23);delete(fig(5).light);
hold on
[fig(5).h, fig(5).light] =  mbaDisplayConnectome(mbaFiberSplitLoops(...
    tmp_fas.fibers(fibers2display)),fig(5).h, [.95 .45 .1],'single',[],.6,.2);
view(-23,-23);delete(fig(5).light); fig(5).light = camlight('right');
    
    