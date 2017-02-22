%save plot for all fibergroups of every subject

baseDir = '/media/lcne/matproc';
figuresDir = '/media/lcne/matproc/figures/elsdti';

subjects = {'els070-T2','els081-T2','els087-T2','els089x-T2','els092-T2','els100-T2'};

%{
             'els006-T2','els012-T2','els013-T2','els014-T2','els016-T2','els017-T2','els025-T2',...
             'els026-T2','els032x-T2','els042-T2','els047-T2','els048-T2','els049-T2','els050-T2', ...
             'els054-T2','els056-T2','els061-T2','els064-T2','els065-T2','els067-T2','els068-T2', ...
             'els069-T2',
%}
         
for isubj = 1:length(subjects)

    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti60trilin/fibers/mrtrix');
    
    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    lInsulaFile = fullfile(mrtrixDir, 'clean_lh_ains_nacc.mat');
    rInsulaFile = fullfile(mrtrixDir, 'clean_rh_ains_nacc.mat');

    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    linsula    = fgRead(lInsulaFile);
    rinsula    = fgRead(rInsulaFile);
    
    %create left hemisphere plot
    lfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[-2 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -10 0])
    mbaDisplayBrainSlice(ti,[0 0 -10])
    [lfh, llh] = mbaDisplayConnectome(linsula.fibers,lfgh,[0.7,0.4,0.4],'single',[],[],.3);
    delete(llh);
    view(250,10);
    axis([-60 0 -20 90 -10 80]);
    llh = lightangle(230,20);
    %save figure
    feSavefig(lfh,'figName',[subjects{isubj} '_t2_ainsnacc_sag_lh'],'figDir',figuresDir,'figType','jpg')

    
    %create right hemisphere plot
    rfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[6 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -10 0])
    mbaDisplayBrainSlice(ti,[0 0 -8])
    [rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
    delete(rlh);
    view(110,10);
    axis([0 60 -20 90 -10 80]);
    rlh = lightangle(110,20);
    %save figure
    feSavefig(rfh,'figName',[subjects{isubj} '_t2_ainsnacc_sag_rh'],'figDir',figuresDir,'figType','jpg')
    
    clear lfh rfh
end
