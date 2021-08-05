%save plot for all fibergroups of every subject

baseDir = '/mnt/acorn/cylon/matproc';
figuresDir = '/mnt/acorn/cylon/matproc/figures/duke';

subjects = {'val048'}


%mbaDisplayConnectome(lmpfc.fibers,fgh,[0.7,0.98,0.98],'single',[],[],.3);
%Teal
%[fh, lh] = mbaDisplayConnectome(lvta.fibers,fgh,[.96,0.84,0.6],'single',[],[],.3);
%Gold
%redo val048 lh


for isubj = 1:length(subjects)

    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    %mrtrixDir = fullfile(subDir, 'dti64trilin/fibers');
    %contrackDir = fullfile(subDir, 'dti64trilin/fibers');
    fiberDir = fullfile(subDir, 'dti32trilin/fibers');
    
    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    lInsulaFile = fullfile(fiberDir, 'lh_ains_nacc.mat');
    lAmygFile = fullfile(fiberDir, 'lh_amyg_nacc.mat');
    rInsulaFile = fullfile(fiberDir, 'rh_ains_nacc.mat');
    rAmygFile = fullfile(fiberDir, 'rh_amyg_nacc.mat');
    lMpfcFile = fullfile(fiberDir, 'lh_mpfc_nacc.mat');
    lVtaFile = fullfile(fiberDir, 'lh_vta_nacc.mat');
    rMpfcFile = fullfile(fiberDir, 'rh_mpfc_nacc.mat');
    rVtaFile = fullfile(fiberDir, 'rh_vta_nacc.mat');

    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    linsula    = fgRead(lInsulaFile);
    lamyg      = fgRead(lAmygFile);
    rinsula    = fgRead(rInsulaFile);
    ramyg      = fgRead(rAmygFile);
    lmpfc    = fgRead(lMpfcFile);
    lvta      = fgRead(lVtaFile);
    rmpfc    = fgRead(rMpfcFile);
    rvta      = fgRead(rVtaFile);
    
    %create left hemisphere plot
    lfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[-3 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -13 0])
    mbaDisplayBrainSlice(ti,[0 0 -10])
    [lfh, llh] = mbaDisplayConnectome(linsula.fibers,lfgh,[0.7,0.4,0.4],'single',[],[],.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(lamyg.fibers,lfgh,[.08,0.4,0.6],'single',[],[],.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(lmpfc.fibers,lfgh,[0.7,0.98,0.98],'single',[],[],.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(lvta.fibers,lfgh,[.96,0.84,0.6],'single',[],[],.3);
    delete(llh);
    view(240,25);
    axis([-65 0 -20 90 -20 80]);
    llh = lightangle(240,20);
    %save figure
    %feSavefig(lfh,'figName',[subjects{isubj} '_connacctome_lh'],'figDir',figuresDir,'figType','jpg') <- doesn't work with current matlab version, I guess.
    saveas(lfh, fullfile(figuresDir, 'lh', [subjects{isubj} '_connacctome_lh']), 'epsc')
    saveas(lfh, fullfile(figuresDir, 'lh', [subjects{isubj} '_connacctome_lh']), 'jpg')
    
    %create right hemisphere plot
    rfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[3 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -13 0])
    mbaDisplayBrainSlice(ti,[0 0 -10])
    [rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(ramyg.fibers,rfgh,[.08,0.4,0.6],'single',[],[],.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rmpfc.fibers,rfgh,[0.7,0.98,0.98],'single',[],[],.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rvta.fibers,rfgh,[.96,0.84,0.6],'single',[],[],.3);
    delete(rlh);
    view(120,25);
    axis([0 65 -20 90 -20 80]);
    rlh = lightangle(120,20);
    %save figure
    %feSavefig(lfh,'figName',[subjects{isubj} '_connacctome_lh'],'figDir',figuresDir,'figType','jpg') <- doesn't work with current matlab version, I guess.
    saveas(rfh, fullfile(figuresDir, 'rh', [subjects{isubj} '_connacctome_rh']), 'epsc')
    saveas(rfh, fullfile(figuresDir, 'rh', [subjects{isubj} '_connacctome_rh']), 'jpg')
    
    clear lfh rfh
end
