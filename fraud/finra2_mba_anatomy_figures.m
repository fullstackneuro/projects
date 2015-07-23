%manual plotting and tweaking for all fibergroups of every subject

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures';

subjects = {'dp092612'};
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

%left hemisphere
%load insula tract
mrtrix_wd = '/media/storg/matproc/dp092612/dti96trilin/fibers/mrtrix';
lh_insula = fullfile(mrtrix_wd,'clean_lh_antshortins_nacc.mat');
linsula = fgRead(lh_insula);
%load mpfc tract
mpfc_wd = '/media/storg/matproc/dp092612/dti96trilin/fibers/conTrack/frontostriatal';
lh_mpfc = fullfile(mpfc_wd,'clean_lh_mpfc_nacc.mat');
lmpfc = fgRead(lh_mpfc);              
%load vta tract
vta_wd = '/media/storg/matproc/dp092612/dti96trilin/fibers/conTrack/mesolimbic';
lh_vta = fullfile(vta_wd,'clean_lh_vta_nacc.mat');
lvta = fgRead(lh_vta);
%load ROIs
roi_wd = '/media/storg/matproc/dp092612/ROIs';
lh_ins = fullfile(roi_wd,'lh_antshortins_fd.mat');
lins = roiLoad(lh_ins);

fgh = figure('position',[0 0 1000 900]);
mbaDisplayBrainSlice(ti,[0 12 0])
hold on
mbaDisplayBrainSlice(ti,[0 0 -13])
view(180,5);
axis([-60 0 -50 90 -9 70]);
lh = lightangle(230,20);
%axis equal
%save figure
feSavefig(fh,'figName','dp092612_lh_insula','figDir','/media/storg/matproc/figures','figType','jpg')


%%%%old code for figures
%{
%right hemisphere
%load insula tract
mrtrix_wd = '/media/storg/matproc/dp092612/dti96trilin/fibers/mrtrix';
rh_insula = fullfile(mrtrix_wd,'clean_rh_antshortins_nacc.mat');
rinsula = fgRead(rh_insula);
%load mpfc tract
mpfc_wd = '/media/storg/matproc/dp092612/dti96trilin/fibers/conTrack/frontostriatal';
rh_mpfc = fullfile(mpfc_wd,'clean_rh_mpfc_nacc.mat');
rmpfc = fgRead(rh_mpfc);              
%load vta tract
vta_wd = '/media/storg/matproc/dp092612/dti96trilin/fibers/conTrack/mesolimbic';
rh_vta = fullfile(vta_wd,'clean_rh_vta_nacc.mat');
rvta = fgRead(rh_vta);
%plot
rfgh = figure('position',[0 0 1000 900]);
mbaDisplayBrainSlice(ti,[3 0 0])
hold on
mbaDisplayBrainSlice(ti,[0 -28 0])
mbaDisplayBrainSlice(ti,[0 0 -13])
[rfh, rlh] = mbaDisplayConnectome(rmpfc.fibers,rfgh,[0.7,0.98,0.98],'single',[],[],0.3);
%delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rinsula.fibers,rfgh,[0.7,0.4,0.4],'single',[],[],0.3);
delete(rlh);
[rfh, rlh] = mbaDisplayConnectome(rvta.fibers,rfgh,[0.96,0.84,0.6],'single',[],[],0.3);
%delete(lh);
view(130,20);
axis([0 60 -50 90 -9 70]);
rlh = lightangle(130,20);
%save figure
feSavefig(rfh,'figName','dp092612_rh_insula','figDir','/media/storg/matproc/figures','figType','jpg')
%}
