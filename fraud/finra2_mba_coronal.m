%manual plotting and tweaking for all fibergroups of every subject

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures';
subjects = {'ds080712'};
%{
            'bc050913','bk032213','ch101612','cs050813', ...
            'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            'gr051513','hg101012','hm062513','jh042913','jl071912','jo081312', ...
            'jt062413','jw072512','kr030113','lc052213','lf052813','lw061713', ...
            'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'};
%}
%load t1
ti = niftiRead('/media/storg/matproc/dp092612/dp092612_t1_acpc.nii.gz');
%load insula tract
mrtrix_wd = '/media/storg/matproc/dp092612/dti96trilin/fibers/mrtrix';
rh_insula = fullfile(mrtrix_wd,'clean_rh_antshortins_nacc.mat');
rinsula = fgRead(rh_insula);
lh_insula = fullfile(mrtrix_wd,'clean_lh_antshortins_nacc.mat');
linsula = fgRead(lh_insula);
rfgh = figure('position',[0 0 1000 900]);
mbaDisplayBrainSlice(ti,[0 10 0])
hold on
[rfgh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
delete(rlh);
[rfgh, rlh] = mbaDisplayConnectome(linsula.fibers,rfgh,[0, 0.20, 0.38],'single',[],[],0.3);
delete(rlh)
view(180,0);
rlh = lightangle(180,20);
feSavefig(rfgh,'figName','ainsnacccoronal','figDir','/media/storg/matproc/figures/cover','figType','jpg')




lh_insula = fullfile(mrtrix_wd,'clean_lh_antshortins_nacc.mat');
linsula = fgRead(lh_insula);
%load afq tracts
afq_wd = '/media/storg/matproc/dp092612/dti96trilin/fibers/afq';
rh_unc = fullfile(afq_wd,'r_uncinate_lmax10.mat');
runc = fgRead(rh_unc);
rh_ifof = fullfile(afq_wd,'r_ifof_lmax10.mat');
rifof = fgRead(rh_ifof);
rh_cst = fullfile(afq_wd,'r_cst_lmax10.mat');
rcst = fgRead(rh_cst);
%plot
rfgh = figure('position',[0 0 1000 900]);
mbaDisplayBrainSlice(ti,[3 0 0])
hold on
mbaDisplayBrainSlice(ti,[0 14 0])
mbaDisplayBrainSlice(ti,[0 0 -17])
%[rfgh, rlh] = mbaDisplayConnectome(runc.fibers,rfgh,[0.7,0.98,0.98],'single',[],[],0.3);
%delete(rlh);
[rfgh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
delete(rlh);
%[rfgh, rlh] = mbaDisplayConnectome(rifof.fibers,rfgh,[0.96,0.84,0.6],'single',[],[],0.3);
%delete(rlh);
[rfgh, rlh] = mbaDisplayConnectome(rcst.fibers,rfgh,[0.96,0.84,0.6],'single',[],[],0.3);
delete(rlh);
view(0,5);
axis([0 60 -50 90 -9 70]);
rlh = lightangle(0,50);
%save figure
feSavefig(rfh,'figName','dp092612_rh_insula','figDir','/media/storg/matproc/figures','figType','jpg')
