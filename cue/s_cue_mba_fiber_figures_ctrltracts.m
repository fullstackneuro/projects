%save plot for all fibergroups of every subject

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures/mididti';

%lcne
subjects = {'ac160415','am160914','jh160702','jr160507','kn160918','ld160918','li160927','mp160511','ps160508'};

%storg 1
%subjects = {'pw060713','sp061313','wb071812'};
%'ab071412','bk032113','dc050213','ds080712','en062813','gr051513','hm062513', ...
%            'jl071912','jt062413','jw072512','lc052213','mk021913','ml061013','np072412', ...
%storg 2
subjects = {'al151016','bb160402','bp160213','cs160214','jc160320','jc160321','jg151121', ...
            'jv151030','jw160316','pk160319','ps151001','rb160407','rf160313','zl150930'};
            
for isubj = 1:length(subjects)
    
    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti96trilin/fibers/mrtrix');
    %mpfcDir   = fullfile(subDir, 'dti96trilin/fibers/conTrack/frontostriatal');
    mpfcDir   = fullfile(subDir, 'dti96trilin/fibers/conTrack/mpfcnacc');

    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    lVlpfcStnFile = fullfile(mrtrixDir, 'clean_lh_frontorb_stn.mat');
    lPresmaStnFile = fullfile(mrtrixDir, 'clean_lh_presma_stn.mat');
    lMpfcNAccFile = fullfile(mpfcDir, 'clean_lh_mpfc_nacc.mat');
    rVlpfcStnFile = fullfile(mrtrixDir, 'clean_rh_frontorb_stn.mat');
    rPresmaStnFile = fullfile(mrtrixDir, 'clean_rh_presma_stn.mat');
    rMpfcNAccFile = fullfile(mpfcDir, 'clean_rh_mpfc_nacc.mat');
    
    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    lvlpfcstn = fgRead(lVlpfcStnFile);
    lpresmastn = fgRead(lPresmaStnFile);
    lmpfcnacc = fgRead(lMpfcNAccFile);
    rvlpfcstn = fgRead(rVlpfcStnFile);
    rpresmastn = fgRead(rPresmaStnFile);
    rmpfcnacc = fgRead(rMpfcNAccFile);
    
    %create left hemisphere plot
    lfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[-1 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -20 0])
    mbaDisplayBrainSlice(ti,[0 0 -10])
    [lfh, llh] = mbaDisplayConnectome(lvlpfcstn.fibers,lfgh,[0.98,0.57,0.45],'single',[],[],.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(lpresmastn.fibers,lfgh,[.48,0.62,0.78],'single',[],[],.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(lmpfcnacc.fibers,lfgh,[0.7,0.98,0.98],'single',[],[],.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(rvlpfcstn.fibers,lfgh,[0.98,0.57,0.45],'single',[],[],.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(rpresmastn.fibers,lfgh,[.48,0.62,0.78],'single',[],[],.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(rmpfcnacc.fibers,lfgh,[0.7,0.98,0.98],'single',[],[],.3);
    delete(llh);
    view(180,10);
    axis([-70 70 -20 90 -10 80]);
    llh = lightangle(180,15);
    %save figure
    feSavefig(lfh,'figName',[subjects{isubj} '_ctrl_cor_bh'],'figDir',figuresDir,'figType','jpg')
    %{
    %create right hemisphere plot
    rfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[1 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -20 0])
    mbaDisplayBrainSlice(ti,[0 0 -10])
    [rfh, rlh] = mbaDisplayConnectome(rvlpfcstn.fibers,rfgh,[0.98,0.57,0.45],'single',[],[],.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rpresmastn.fibers,rfgh,[.48,0.62,0.78],'single',[],[],.3);
    delete(rlh);
    [rfh, rlh] = mbaDisplayConnectome(rmpfcnacc.fibers,rfgh,[0.7,0.98,0.98],'single',[],[],.3);
    delete(rlh);
    view(110,5);
    axis([0 60 -30 90 -20 80]);
    rlh = lightangle(140,15);
    %save figure
    feSavefig(rfh,'figName',[subjects{isubj} '_ctrl_sag_rh'],'figDir',figuresDir,'figType','jpg')
    %}
    clear lfh
    
end


