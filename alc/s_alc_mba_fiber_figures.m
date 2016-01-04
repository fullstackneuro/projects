%save plot for all fibergroups of every subject

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures/macfigs';

subjects = {'mac03218_1','mac03218_2','mac12826_1','mac12826_2', ...
            'mac18000_1','mac18000_2'};

for isubj = 1:length(subjects)
    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti64trilin/fibers/mrtrix');
    
    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    ltempFile = fullfile(mrtrixDir, 'clean_lh_temporal.mat');
    rtempFile = fullfile(mrtrixDir, 'clean_rh_temporal.mat');
    lantFile   = fullfile(mrtrixDir, 'clean_lh_anterior.mat');
    rantFile   = fullfile(mrtrixDir, 'clean_rh_anterior.mat');
    lmotFile    = fullfile(mrtrixDir, 'clean_lh_motor.mat');
    rmotFile    = fullfile(mrtrixDir, 'clean_rh_motor.mat');
    
    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    ltemp   = fgRead(ltempFile);
    lant     = fgRead(lantFile);
    lmot      = fgRead(lmotFile);
    rtemp   = fgRead(rtempFile);
    rant     = fgRead(rantFile);
    rmot      = fgRead(rmotFile);
    
    %create left hemisphere plot
    lfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[3 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -35 0])
    mbaDisplayBrainSlice(ti,[0 0 -13])
    [lfh, llh] = mbaDisplayConnectome(lant.fibers,lfgh,[0.7,0.98,0.98],'single',[],[],.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(ltemp.fibers,lfgh,[0.7,0.4,0.4],'single',[],[],.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(lmot.fibers,lfgh,[.96,0.84,0.6],'single',[],[],.3);
    delete(llh);
    view(230,20);
    axis([-60 0 -50 90 -9 70]);
    llh = lightangle(230,20);
    %save figure
    feSavefig(lfh,'figName',[subjects{isubj} '_lh'],'figDir',figuresDir,'figType','jpg')
    
    %create right hemisphere plot
    rfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[-3 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -35 0])
    mbaDisplayBrainSlice(ti,[0 0 -13])
    [rfh, rlh] = mbaDisplayConnectome(rant.fibers,rfgh,[0.7,0.98,0.98],'single',[],[],0.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rtemp.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rmot.fibers,rfgh,[0.96,0.84,0.6],'single',[],[],0.3);
    delete(rlh);
    view(130,20);
    axis([0 60 -50 90 -9 70]);
    rlh = lightangle(130,20);
    %save figure
    feSavefig(rfh,'figName',[subjects{isubj} '_rh'],'figDir',figuresDir,'figType','jpg')
end