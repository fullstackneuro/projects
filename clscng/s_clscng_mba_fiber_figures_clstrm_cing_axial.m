%save plot for all fibergroups of every subject

baseDir = '/media/lcne/matproc';
figuresDir = '/media/lcne/matproc/figures/clscng';
subjects = {'am160914'};

for isubj = 1:length(subjects)
    isubj = 1
    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti96trilin/fibers/mrtrix/clscng');
    
    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    rClsMidantcingFile = fullfile(mrtrixDir, 'clean_rh_clstrm_midantcing.mat');
    rClsMidpostcingFile = fullfile(mrtrixDir, 'clean_rh_clstrm_midpostcing.mat');
    rClsDorspostcingFile = fullfile(mrtrixDir, 'clean_rh_clstrm_dorspostcing.mat');
    rClsVentpostcingFile = fullfile(mrtrixDir, 'clean_rh_clstrm_ventpostcing.mat');

    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    rClsMidantcing    = fgRead(rClsMidantcingFile);
    rClsMidpostcing     = fgRead(rClsMidpostcingFile);
    rClsDorspostcing    = fgRead(rClsDorspostcingFile);
    rClsVentpostcing     = fgRead(rClsVentpostcingFile);
    
    %create right hemisphere plot
    rfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[1 0 0])
    hold on
    %mbaDisplayBrainSlice(ti,[0 -10 0])
    mbaDisplayBrainSlice(ti,[0 0 -5])
    [rfh, rlh] = mbaDisplayConnectome(rClsMidantcing.fibers,rfgh,[0.93,0.31,0.2],'single',[],[],0.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rClsMidpostcing.fibers,rfgh,[0.85,0.4,0.12],'single',[],[],0.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rClsDorspostcing.fibers,rfgh,[1,0.71,0.08],'single',[],[],0.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rClsVentpostcing.fibers,rfgh,[0.77,0.51,0.05],'single',[],[],0.3);
    delete(rlh);
    view(1,90);
    axis([1 60 -60 80 -5 80]);
    rlh = lightangle(110,20);
    %save figure
    feSavefig(rfh,'figName',[subjects{isubj} '_rh_clstrm_cing_ax'],'figDir',figuresDir,'figType','jpg')
    
    clear rfh rlh
end
