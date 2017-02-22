%save plot for all fibergroups of every subject

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures/mididti';

%lcne
%subjects = {'ac160415','am160914','jh160702','jr160507','kn160918','ld160918','li160927','mp160511','ps160508'};

%storg
subjects = {'ab071412','bk032113','dc050213','ds080712','en062813','gr051513','hm062513', ...
            'jl071912','jt062413','jw072512','lc052213','mk021913','ml061013','np072412', ...
            'pw060713','sp061313','wb071812', ...
            'al151016','bb160402','bp160213','cs160214','jc160320','jc160321','jg151121', ...
            'jv151030','jw160316','pk160319','ps151001','rb160407','rf160313','zl150930'};


for isubj = 1:length(subjects)

    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti96trilin/fibers/mrtrix');
    
    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    lInsulaFile = fullfile(mrtrixDir, 'clean_lh_antshortins_nacc.mat');
    lVlpfcFile = fullfile(mrtrixDir, 'clean_lh_frontorb_shortins.mat');
    rInsulaFile = fullfile(mrtrixDir, 'clean_rh_antshortins_nacc.mat');
    rVlpfcFile = fullfile(mrtrixDir, 'clean_rh_frontorb_shortins.mat');

    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    %linsula    = fgRead(lInsulaFile);
    %lvlpfc     = fgRead(lVlpfcFile);
    rinsula    = fgRead(rInsulaFile);
    rvlpfc     = fgRead(rVlpfcFile);
    %{
    %create left hemisphere plot
    lfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[-2 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -10 0])
    mbaDisplayBrainSlice(ti,[0 0 -10])
    [lfh, llh] = mbaDisplayConnectome(linsula.fibers,lfgh,[0.7,0.4,0.4],'single',[],[],.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(lvlpfc.fibers,lfgh,[.96,0.84,0.6],'single',[],[],.3);
    delete(llh);
    view(250,10);
    axis([-60 0 -20 90 -10 80]);
    llh = lightangle(230,20);
    %save figure
    feSavefig(lfh,'figName',[subjects{isubj} '_ainsnaccvlpfc_sag_lh'],'figDir',figuresDir,'figType','jpg')
    %}
    
    %create right hemisphere plot
    rfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[2 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -10 0])
    mbaDisplayBrainSlice(ti,[0 0 -10])
    [rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rvlpfc.fibers,rfgh,[0.7,0.58,0.73],'single',[],[],0.3);
    delete(rlh);
    view(110,10);
    axis([0 60 -20 90 -10 80]);
    rlh = lightangle(110,20);
    %save figure
    feSavefig(rfh,'figName',[subjects{isubj} '_ainsnaccvlpfc_sag_rh'],'figDir',figuresDir,'figType','jpg')
    
    clear lfh rfh
end
