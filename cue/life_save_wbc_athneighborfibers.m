%save whole brain connectome fibers which intersect with tract in LiFE

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures/mbafigs';

%first have to fgWrite path neighborhood fibers during feVirtualLesion,
%after se = feComputeEvidence (line 85)
tmp_fas = feGet(feNoLesion,'fibers acpc');
fgWrite(tmp_fas, '/media/lcne/matproc/ac160415/dti96trilin/fibers/life/ac160415_lifefibssacpc.mat','.mat')


% old %

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
    
    