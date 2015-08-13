%manual plotting and tweaking for all fibergroups of every subject

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures';
    
subjects = {'ab071412','bc050913','ch101612','cs050813', ...
            'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            'gr051513','hg101012','hm062513','jh042913','jl071912','jo081312', ...
            'jt062413','jw072512','kr030113','lc052213','lf052813','lw061713', ...
            'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'};
   %,'bk032213'

for isubj = 1:length(subjects)
    %folders
    t1name = ['/media/storg/matproc/' subjects{isubj} '/' subjects{isubj} '_t1_acpc.nii.gz'];
    afq_wd = ['/media/storg/matproc/' subjects{isubj} '/dti96trilin/fibers/afq'];
    mrtrix_wd = ['/media/storg/matproc/' subjects{isubj} '/dti96trilin/fibers/mrtrix'];
    mpfc_wd = ['/media/storg/matproc/' subjects{isubj} '/dti96trilin/fibers/conTrack/frontostriatal'];
    vta_wd = ['/media/storg/matproc/' subjects{isubj} '/dti96trilin/fibers/conTrack/mesolimbic'];
    
    %load t1
    ti = niftiRead(t1name);
    
    %left hemisphere
    %load tracts
    lh_uncus = fullfile(afq_wd, 'l_uncinate_lmax10.mat');
    luncus = fgRead(lh_uncus);
    lh_amyg = fullfile(mrtrix_wd, 'clean_lh_amyg_nacc.mat');
    lamyg = fgRead(lh_amyg);
    lh_insula = fullfile(mrtrix_wd,'clean_lh_antshortins_nacc.mat');
    linsula = fgRead(lh_insula);
    %lh_mpfc = fullfile(mpfc_wd,'clean_lh_mpfc_nacc.mat');
    %lmpfc = fgRead(rh_mpfc);
    %lh_vta = fullfile(vta_wd,'clean_lh_vta_nacc.mat');
    %lvta = fgRead(rh_vta);
    fgh = figure('position',[0 0 1000 900]);
    mbaDisplayBrainSlice(ti,[-3 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -28 0])
    mbaDisplayBrainSlice(ti,[0 0 -13])
    [fh, lh] = mbaDisplayConnectome(luncus.fibers,fgh,[1,0.89,0.77],'single',[],0.2,0.1);
    delete(lh);
    [fh, lh] = mbaDisplayConnectome(lamyg.fibers,fgh,[0, 0.20, 0.38],'single',[],[],0.3);
    delete(lh);
    [fh, lh] = mbaDisplayConnectome(linsula.fibers,fgh,[0.7,0.4,0.4],'single',[],[],.3);
    delete(lh);
    %[fh, lh] = mbaDisplayConnectome(lmpfc.fibers,fgh,[0.7,0.98,0.98],'single',[],[],.3);
    %delete(lh);
    %[fh, lh] = mbaDisplayConnectome(lvta.fibers,fgh,[.96,0.84,0.6],'single',[],[],.3);
    view(240,8);
    axis([-60 0 -40 60 -30 40]);
    lh = lightangle(230,20);
    %save fig
    lfigurename = [subjects{isubj} '_lh_uncusamyginsnacc_sag'];
    feSavefig(fh,'figName',lfigurename,'figDir','/media/storg/matproc/figures/mbafigs','figType','jpg')
    
    %right hemisphere
    %load tracts
    rh_uncus = fullfile(afq_wd, 'r_uncinate_lmax10.mat');
    runcus = fgRead(rh_uncus);
    rh_amyg = fullfile(mrtrix_wd, 'clean_rh_amyg_nacc.mat');
    ramyg = fgRead(rh_amyg);
    rh_insula = fullfile(mrtrix_wd,'clean_rh_antshortins_nacc.mat');
    rinsula = fgRead(rh_insula);
    %rh_mpfc = fullfile(mpfc_wd,'clean_rh_mpfc_nacc.mat');
    %rmpfc = fgRead(rh_mpfc);
    %rh_vta = fullfile(vta_wd,'clean_rh_vta_nacc.mat');
    %rvta = fgRead(rh_vta);
    fgh = figure('position',[0 0 1000 900]);
    mbaDisplayBrainSlice(ti,[-3 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 -28 0])
    mbaDisplayBrainSlice(ti,[0 0 -13])
    [fh, lh] = mbaDisplayConnectome(runcus.fibers,fgh,[1,0.89,0.77],'single',[],0.1,0.08);
    delete(lh);
    [fh, lh] = mbaDisplayConnectome(ramyg.fibers,fgh,[0, 0.20, 0.38],'single',[],[],0.3);
    delete(lh);
    [fh, lh] = mbaDisplayConnectome(rinsula.fibers,fgh,[0.7,0.4,0.4],'single',[],[],.3);
    delete(lh);
    view(120,8);
    axis([0 60 -40 60 -30 40]);
    lh = lightangle(130,20);
    %save figure
    rfigurename = [subjects{isubj} '_rh_uncusamyginsnacc_sag'];
    feSavefig(fh,'figName',rfigurename,'figDir','/media/storg/matproc/figures/mbafigs','figType','jpg')
end