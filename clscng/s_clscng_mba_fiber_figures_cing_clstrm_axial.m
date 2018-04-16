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
    rMidantcingClsFile = fullfile(mrtrixDir, 'clean_rh_midantcing_clstrm.mat');
    rMidpostcingClsFile = fullfile(mrtrixDir, 'clean_rh_midpostcing_clstrm.mat');
    rDorspostcingClsFile = fullfile(mrtrixDir, 'clean_rh_dorspostcing_clstrm.mat');
    %rVentpostcingClsFile = fullfile(mrtrixDir, 'clean_rh_ventpostcing_clstrm.mat');

    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    rMidantcingCls    = fgRead(rMidantcingClsFile);
    rMidpostcingCls     = fgRead(rMidpostcingClsFile);
    rDorspostcingCls    = fgRead(rDorspostcingClsFile);
    %rVentpostcingCls     = fgRead(rVentpostcingClsFile);
    
    %create right hemisphere plot
    rfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[1 0 0])
    hold on
    %mbaDisplayBrainSlice(ti,[0 -10 0])
    mbaDisplayBrainSlice(ti,[0 0 -5])
    [rfh, rlh] = mbaDisplayConnectome(rMidantcingCls.fibers,rfgh,[0.55,0.08,0.08],'single',[],[],0.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rMidpostcingCls.fibers,rfgh,[0.55,0.08,0.08],'single',[],[],0.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rDorspostcingCls.fibers,rfgh,[0.55,0.08,0.08],'single',[],[],0.3);
    delete(rlh);
    %[rfh, rlh] = mbaDisplayConnectome(rVentpostcingCls.fibers,rfgh,[0.77,0.51,0.05],'single',[],[],0.3);
    %delete(rlh);
    view(1,90);
    axis([1 60 -60 80 -5 80]);
    rlh = lightangle(110,20);
    %save figure
    feSavefig(rfh,'figName',[subjects{isubj} '_rh_clstrm_cing_sag'],'figDir',figuresDir,'figType','jpg')
    
    clear rfh rlh
end
