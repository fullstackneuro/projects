%save jpg of fibergroups alone

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures/elsfigs';

subjects = {'els079'};
%{
'els013','els014','els016','els017', ...
            'els024','els025','els026','els028','els032','els033','els039', ...
            'els041','els042','els045','els046','els047','els048', ...
            'els049','els050','els053','els054','els055','els056','els057', ...
            'els064','els065','els067','els068','els069','els070', ...
            'els072','els073','els074','els076','els077','els079','els081', ...
            'els083','els085','els087','els088','els093', ...
            'els006','els009','els012','els034','els040','els058','els059', ...
            'els060','els061','els062','els075','els086','els089','els090', ...
            'els092','els095','els097','els099','els100'
%}

for isubj = 1:length(subjects)
    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti60trilin/fibers/mrtrix');
    
    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    lInsulaFile = fullfile(mrtrixDir, 'clean_lh_antshortins_nacc.mat');
    rInsulaFile = fullfile(mrtrixDir, 'clean_rh_antshortins_nacc.mat');

    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    linsula   = fgRead(lInsulaFile);
    rinsula   = fgRead(rInsulaFile);
 end

    %right hemisphere insula tract
    rfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[-1 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 1 0])
    mbaDisplayBrainSlice(ti,[0 0 -13])
    [rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
    delete(rlh);
    view(158,8);
    axis([0 60 -50 90 -9 70]);
    rlh = lightangle(130,20);
    %save figure
    feSavefig(rfh,'figName',[subjects{isubj} '_rh'],'figDir',figuresDir,'figType','jpg')
    
    %create left insula plot
    lfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[1 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 1 0])
    mbaDisplayBrainSlice(ti,[0 0 -13])
    [lfh, llh] = mbaDisplayConnectome(linsula.fibers,lfgh,[0.96,0.84,0.6],'single',[],[],.3);
    delete(llh);
    view(202,8);
    axis([-60 0 -50 90 -9 70]);
    llh = lightangle(230,20);
    %save figure
    feSavefig(lfh,'figName',[subjects{isubj} '_lh'],'figDir',figuresDir,'figType','jpg')
    
    %both hemispheres
    bfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[0 1 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 0 -13])
    [bfh, blh] = mbaDisplayConnectome(rinsula.fibers,bfgh,[0.7,0.4,0.4],'single',[],[],0.3);
    delete(blh);
    [bfh, blh] = mbaDisplayConnectome(linsula.fibers,bfgh,[0.96,0.84,0.6],'single',[],[],.3);
    delete(blh);
    view(145,8);
    %axis([0 60 -50 90 -9 70]);
    blh = lightangle(130,20);
    %save figure
    feSavefig(bfh,'figName',[subjects{isubj} '_both'],'figDir',figuresDir,'figType','jpg')