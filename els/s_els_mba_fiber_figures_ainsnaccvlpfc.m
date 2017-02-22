
%save plot for all fibergroups of every subject

baseDir = '/media/lcne/matproc/';
figuresDir = '/media/lcne/matproc/figures/elsdti';

subjects = {'els054','els055','els056', ...
            'els057','els058','els059','els060','els061','els062','els064', ...
            'els065','els067','els068','els069','els070','els072','els073', ...
            'els074','els075','els076','els077','els079','els081','els083', ...
            'els085','els086','els087','els088','els089','els090'}; 
%{
      'els006','els009','els012','els013','els014','els016','els017', ...
            'els024','els025','els026','els028','els032','els033','els034', ...
            'els039','els040','els041','els042','els045','els046','els047', ...
            'els048','els049','els050','els053',
            %}
for isubj = 1:length(subjects)

    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti60trilin/fibers/mrtrix');
    
    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    lInsulaFile = fullfile(mrtrixDir, 'clean_lh_antshortins_nacc.mat');
    %lVlpfcFile = fullfile(mrtrixDir, 'clean_lh_ains_vlpfc.mat');
    rInsulaFile = fullfile(mrtrixDir, 'clean_rh_antshortins_nacc.mat');
    %rVlpfcFile = fullfile(mrtrixDir, 'clean_rh_ains_vlpfc.mat');

    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    linsula    = fgRead(lInsulaFile);
    %lvlpfc     = fgRead(lVlpfcFile);
    rinsula    = fgRead(rInsulaFile);
    %rvlpfc     = fgRead(rVlpfcFile);
    
    %create left hemisphere plot
    lfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[-2 0 0])
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
    mbaDisplayBrainSlice(ti,[6 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -10 0])
    mbaDisplayBrainSlice(ti,[0 0 -8])
    [rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
    delete(rlh);
    %[rfh, rlh] = mbaDisplayConnectome(rvlpfc.fibers,rfgh,[0.96,0.84,0.6],'single',[],[],0.3);
    %delete(rlh);
    view(110,10);
    axis([0 60 -20 90 -10 80]);
    rlh = lightangle(110,20);
    %save figure
    feSavefig(rfh,'figName',[subjects{isubj} '_ainsnacc_sag_rh'],'figDir',figuresDir,'figType','jpg')
    
    clear lfh rfh
end
