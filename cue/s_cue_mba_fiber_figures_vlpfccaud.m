%save plot for all fibergroups of every subject

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures/mididti';

%lcne
%subjects = {'ac160415','am160914','jh160702','jr160507','kn160918','ld160918','li160927','mp160511','ps160508'};

%storg
subjects = {'jc160320','jc160321'};

for isubj = 1:length(subjects)
isubj =2
    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti96trilin/fibers/mrtrix');
    
    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    lInsulaFile = fullfile(mrtrixDir, 'clean_lh_antshortins_nacc.mat');
    lVlpfcFile = fullfile(mrtrixDir, 'clean_lh_vlpfc_caud.mat');
    rInsulaFile = fullfile(mrtrixDir, 'clean_rh_antshortins_nacc.mat');
    rVlpfcFile = fullfile(mrtrixDir, 'clean_rh_vlpfc_caud.mat');

    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    linsula    = fgRead(lInsulaFile);
    lvlpfc     = fgRead(lVlpfcFile);
    rinsula    = fgRead(rInsulaFile);
    rvlpfc     = fgRead(rVlpfcFile);
    
    
    %create left hemisphere plot
    lfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[-2 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -10 0])
    mbaDisplayBrainSlice(ti,[0 0 -10])
    %[lfh, llh] = mbaDisplayConnectome(linsula.fibers,lfgh,[0.7,0.4,0.4],'single',[],[],.3);
    %delete(llh);
    [lfh, lh] = mbaDisplayConnectome(lvlpfc.fibers,lfgh,[0.7,0.4,0.23],'single',[],[],0.3);
    delete(llh);
    view(210,10);
    axis([-60 0 -20 90 -10 80]);
    llh = lightangle(210,10);
    %save figure
    feSavefig(lfh,'figName',[subjects{isubj} '_vlpfccaud_sag_lh'],'figDir',figuresDir,'figType','jpg')
    %}
    
    %create right hemisphere plot
    rfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[6 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -10 0])
    mbaDisplayBrainSlice(ti,[0 0 -8])
    %[rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
    %delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rvlpfc.fibers,rfgh,[0.7,0.4,0.23],'single',[],[],0.3);
    delete(rlh);
    view(130,12);
    axis([0 60 -20 90 -10 80]);
    rlh = lightangle(110,20);
    %save figure
    feSavefig(rfh,'figName',[subjects{isubj} '_vlpfccaud_sag_rh'],'figDir',figuresDir,'figType','jpg')
    
    clear lfh rfh
end
