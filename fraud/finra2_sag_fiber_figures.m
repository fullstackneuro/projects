%manual plotting and tweaking for all fibergroups of every subject

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures';

subjects = {'ml061013'};
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
ti = niftiRead('/media/storg/matproc/ml061013/ml061013_t1_acpc.nii.gz');
%right hemisphere
%load insula tract
mrtrix_wd = '/media/storg/matproc/ml061013/dti96trilin/fibers/mrtrix';
rh_insula = fullfile(mrtrix_wd,'clean_rh_antshortins_nacc.mat');
rinsula = fgRead(rh_insula);
%load mpfc tract
mpfc_wd = '/media/storg/matproc/ml061013/dti96trilin/fibers/conTrack/frontostriatal';
rh_mpfc = fullfile(mpfc_wd,'clean_rh_mpfc_nacc.mat');
rmpfc = fgRead(rh_mpfc);              
%load vta tract
vta_wd = '/media/storg/matproc/ml061013/dti96trilin/fibers/conTrack/mesolimbic';
rh_vta = fullfile(vta_wd,'clean_rh_vta_nacc.mat');
rvta = fgRead(rh_vta);
%load afq-wbc tracts
afq_wd = '/media/storg/matproc/ml061013/dti96trilin/fibers/afq';
rharc = fullfile(afq_wd,'r_arcuate_lmax10.mat');
rhcing = fullfile(afq_wd,'r_cingcing_lmax10.mat');
rhhippo = fullfile(afq_wd,'r_cinghippo_lmax10.mat');
rhcst = fullfile(afq_wd,'r_cst_lmax10.mat');
rhifof = fullfile(afq_wd,'r_ifof_lmax10.mat');
rhilf = fullfile(afq_wd,'r_ilf_lmax10.mat');
rhofof = fullfile(afq_wd,'r_ofof_lmax10.mat');
rhslf = fullfile(afq_wd,'r_slf_lmax10.mat');
rhthal = fullfile(afq_wd,'r_thalrad_lmax10.mat');
rhunc = fullfile(afq_wd,'r_uncinate_lmax10.mat');
rarc = fgRead(rharc);
rcing = fgRead(rhcing);
rhippo = fgRead(rhhippo);
rcst = fgRead(rhcst);
rifof = fgRead(rhifof);
rilf = fgRead(rhilf);
rofof = fgRead(rhofof);
rslf = fgRead(rhslf);
rthal = fgRead(rhthal);
runc = fgRead(rhunc);
%plot
rfgh = figure('position',[0 0 1000 900]);
mbaDisplayBrainSlice(ti,[3 0 0])
hold on
mbaDisplayBrainSlice(ti,[0 -28 0])
mbaDisplayBrainSlice(ti,[0 0 -13])
[rfh, rlh] = mbaDisplayConnectome(rmpfc.fibers,rfgh,[0.7,0.98,0.98],'single',[],[],0.3);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rvta.fibers,rfgh,[0.96,0.84,0.6],'single',[],[],0.3);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rarc.fibers,rfgh,[1,0.89,0.77],'single',[],0.05,0.18,[]);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rcing.fibers,rfgh,[1,0.89,0.77],'single',[],0.05,0.18,[]);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rhippo.fibers,rfgh,[1,0.89,0.77],'single',[],0.05,0.18,[]);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rcst.fibers,rfgh,[1,0.89,0.77],'single',[],0.05,0.18,[]);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rifof.fibers,rfgh,[1,0.89,0.77],'single',[],0.05,0.18,[]);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rilf.fibers,rfgh,[1,0.89,0.77],'single',[],0.05,0.18,[]);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rofof.fibers,rfgh,[1,0.89,0.77],'single',[],0.05,0.18,[]);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rslf.fibers,rfgh,[1,0.89,0.77],'single',[],0.05,0.18,[]);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rthal.fibers,rfgh,[1,0.89,0.77],'single',[],0.05,0.18,[]);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(runc.fibers,rfgh,[1,0.89,0.77],'single',[],0.05,0.18,[]);
delete(rlh);
view(130,20);
axis([0 60 -50 90 -9 70]);
rlh = lightangle(130,20);
%save figure
feSavefig(rfh,'figName','allfibers1','figDir','/media/storg/matproc/figures/cover','figType','jpg')




