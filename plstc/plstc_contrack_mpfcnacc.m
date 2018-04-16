% lcne contrack

% rh mpfc nacc
lcnectr = ctrInitBatchParams;
lcnectr.projectName = 'mpfcnacc';
lcnectr.logName = 'rmpfcnacc';
lcnectr.baseDir = '/media/lcne/matproc';
lcnectr.dtDir = 'dti96trilin';
lcnectr.roiDir = 'ROIs';
lcnectr.subs = {'nb081015_1','nb081015_2'};
lcnectr.roi1 = 'rh_mpfc_5mm.mat';
lcnectr.roi2 = 'rh_nacc_aseg_fd.mat';

ctrInitBatchTrack(lcnectr)

% lh mpfc nacc
lcnectr = ctrInitBatchParams;
lcnectr.projectName = 'mpfcnacc';
lcnectr.logName = 'lmpfcnacc';
lcnectr.baseDir = '/media/lcne/matproc';
lcnectr.dtDir = 'dti96trilin';
lcnectr.roiDir = 'ROIs';
lcnectr.subs = {'nb081015_1','nb081015_2'};
lcnectr.roi1 = 'lh_mpfc_5mm.mat';
lcnectr.roi2 = 'lh_nacc_aseg_fd.mat';

ctrInitBatchTrack(lcnectr)

%scoring fibers
%right hemisphere
ctrInitBatchScore('/media/lcne/matproc/ConTrack/mpfcnacc/logs/mpfcnacc_lmpfcnacc_ctrInitLog_30-Nov-2017_14h54m33s.mat', 500,1);

%left hemisphere
%ctrInitBatchScore('/media/storg/matproc/ConTrack/mpfcnacc/logs/mpfcnacc_lmpfcnacc_ctrInitLog_08-Aug-2017_15h25m34s.mat', 500,1);


% storg contrack

% rh mpfc nacc
lcnectr = ctrInitBatchParams;
lcnectr.projectName = 'mpfcnacc';
lcnectr.logName = 'rmpfcnacc';
lcnectr.baseDir = '/media/storg/matproc';
lcnectr.dtDir = 'dti96trilin';
lcnectr.roiDir = 'ROIs';
lcnectr.subs = {'lf052813','sn061213','tw062113'};
lcnectr.roi1 = 'rh_mpfc_4mm.mat';
lcnectr.roi2 = 'rh_nacc_aseg.mat';
lcnectr.multiThread = 1;

%ctrInitBatchTrack(lcnectr)

% lh mpfc nacc
lcnectr = ctrInitBatchParams;
lcnectr.projectName = 'mpfcnacc';
lcnectr.logName = 'lmpfcnacc';
lcnectr.baseDir = '/media/storg/matproc';
lcnectr.dtDir = 'dti96trilin';
lcnectr.roiDir = 'ROIs';
lcnectr.subs = {'lf052813','sn061213','tw062113'};
lcnectr.roi1 = 'lh_mpfc_4mm.mat';
lcnectr.roi2 = 'lh_nacc_aseg.mat';
lcnectr.multiThread = 1;

%ctrInitBatchTrack(lcnectr)
