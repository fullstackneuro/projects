%save plot for all fibergroups of every subject

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures/macfigs';

subjects = {'mac03218_2','mac12826_1','mac12826_2', ...
            'mac18000_1','mac18000_2','mac18622_1'};
%'mac03218_1' bushy ,'mac18622_2' weird raw

for isubj = 1:length(subjects)

    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti64trilin/fibers/mrtrix');
    
    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    lInsulaFile = fullfile(mrtrixDir, 'clean_lh_antshortins_nacc.mat');
    %lVlpfcFile = fullfile(mrtrixDir, 'clean_lh_frontorb_shortins.mat');
    rInsulaFile = fullfile(mrtrixDir, 'clean_rh_antshortins_nacc.mat');
    %rVlpfcFile = fullfile(mrtrixDir, 'clean_rh_frontorb_shortins.mat');

    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    linsula    = fgRead(lInsulaFile);
    %lvlpfc     = fgRead(lVlpfcFile);
    rinsula    = fgRead(rInsulaFile);
    %rvlpfc     = fgRead(rVlpfcFile);
    
    %create left hemisphere plot
    lfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[-3 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -10 0])
    mbaDisplayBrainSlice(ti,[0 0 -10])
    [lfh, llh] = mbaDisplayConnectome(linsula.fibers,lfgh,[0.7,0.4,0.4],'single',[],[],.3);
    delete(llh);
    %[lfh, llh] = mbaDisplayConnectome(lvlpfc.fibers,lfgh,[.96,0.84,0.6],'single',[],[],.3);
    %delete(llh);
    view(250,10);
    axis([-60 0 -20 90 -10 80]);
    llh = lightangle(230,20);
    %save figure
    feSavefig(lfh,'figName',[subjects{isubj} '_ainsnacc_sag_lh'],'figDir',figuresDir,'figType','jpg')
    
    
    %create right hemisphere plot
    rfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[3 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -10 0])
    mbaDisplayBrainSlice(ti,[0 0 -10])
    [rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
    delete(rlh);
    %[rfh, rlh] = mbaDisplayConnectome(rvlpfc.fibers,rfgh,[0.7,0.58,0.73],'single',[],[],0.3);
    %delete(rlh);
    view(110,10);
    axis([0 60 -20 90 -10 80]);
    rlh = lightangle(110,20);
    %save figure
    feSavefig(rfh,'figName',[subjects{isubj} '_ainsnacc_sag_rh'],'figDir',figuresDir,'figType','jpg')
    
    clear lfh rfh
end
