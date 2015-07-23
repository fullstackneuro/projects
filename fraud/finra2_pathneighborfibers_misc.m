%save jpg of fibergroups alone

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures/mbafigs';

subjects = {'dp092612'};
isubj = 1;
            %'ab071412','bc050913','bk032113','ch101612','cs050813', ...
            %'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            %'gr051513','hg101012','hm062513','jh042913','jo081312', ...
            %'jt062413','jw072512','kr030113','lf052813','lw061713', ...
            %'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            %'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            %'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            %'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'};
            
for isubj = 1:length(subjects)
    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti96trilin/fibers/mrtrix');
    mpfcDir   = fullfile(subDir, 'dti96trilin/fibers/conTrack/frontostriatal');
    vtaDir    = fullfile(subDir, 'dti96trilin/fibers/conTrack/mesolimbic');
    
    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    lInsulaFile = fullfile(mrtrixDir, 'clean_lh_antshortins_nacc.mat');
    lMpfcFile   = fullfile(mpfcDir, 'clean_lh_mpfc_nacc.mat');
    lVtaFile    = fullfile(vtaDir, 'clean_lh_vta_nacc.mat');
    rInsulaFile = fullfile(mrtrixDir, 'clean_rh_antshortins_nacc.mat');
    rMpfcFile   = fullfile(mpfcDir, 'clean_rh_mpfc_nacc.mat');
    rVtaFile    = fullfile(vtaDir, 'clean_rh_vta_nacc.mat');
    
    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    linsula   = fgRead(lInsulaFile);
    lmpfc     = fgRead(lMpfcFile);
    lvta      = fgRead(lVtaFile);
    rinsula   = fgRead(rInsulaFile);
    rmpfc     = fgRead(rMpfcFile);
    rvta      = fgRead(rVtaFile);
    
    %read path neighborhood fibers
    rinsPathFibersFile = fullfile(subDir, 'dti96trilin/fibers/life/forfigs',[subjects{isubj} '_fasacpc.mat']);
    rinsPathFibers  = fgRead(rinsPathFibersFile);
end

    %left hemisphere fibers
    lfgh = figure('position',[100 200 1000 900]);
    hold on
    [lfh, llh] = mbaDisplayConnectome(lmpfc.fibers,lfgh,[0.7,0.98,0.98],'single',[],[],.3);
    
    lfgh = figure('position',[100 200 1000 900]);
    hold on
    [lfh, llh] = mbaDisplayConnectome(linsula.fibers,lfgh,[0.7,0.4,0.4],'single',[],[],.3);
    
    lfgh = figure('position',[100 200 1000 900]);
    hold on
    [lfh, llh] = mbaDisplayConnectome(lvta.fibers,lfgh,[.96,0.84,0.6],'single',[],[],.3);

    %save figure
    feSavefig(lfh,'figName',[subjects{isubj} '_lh'],'figDir',figuresDir,'figType','jpg')
    
     %right hemisphere fibers
    rfgh = figure('position',[100 200 1000 900]);
    hold on
    [rfh, rlh] = mbaDisplayConnectome(rmpfc.fibers,rfgh,[0.7,0.98,0.98],'single',[],[],.3);
    
    rfgh = figure('position',[100 200 1000 900]);
    hold on
    [rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],.3);
    
    rfgh = figure('position',[100 200 1000 900]);
    hold on
    [rfh, rlh] = mbaDisplayConnectome(rvta.fibers,rfgh,[.96,0.84,0.6],'single',[],[],.3);

    %save figure
    feSavefig(rfh,'figName',[subjects{isubj} '_rh'],'figDir',figuresDir,'figType','jpg')
    
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
    
    