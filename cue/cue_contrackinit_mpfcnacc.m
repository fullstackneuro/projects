% lcne contrack

% rh mpfc nacc
lcnectr = ctrInitBatchParams;
lcnectr.projectName = 'mpfcnacc';
lcnectr.logName = 'rmpfcnacc';
lcnectr.baseDir = '/media/lcne/matproc';
lcnectr.dtDir = 'dti96trilin';
lcnectr.roiDir = 'ROIs';
lcnectr.subs = {'hw161104','ph161104'};
lcnectr.roi1 = 'rh_mpfc_4mm.mat';
lcnectr.roi2 = 'rh_nacc_aseg_fd.mat';

%ctrInitBatchTrack(lcnectr)

% lh mpfc nacc
lcnectr = ctrInitBatchParams;
lcnectr.projectName = 'mpfcnacc';
lcnectr.logName = 'lmpfcnacc';
lcnectr.baseDir = '/media/lcne/matproc';
lcnectr.dtDir = 'dti96trilin';
lcnectr.roiDir = 'ROIs';
lcnectr.subs = {'hw161104','ph161104'};
lcnectr.roi1 = 'lh_mpfc_4mm.mat';
lcnectr.roi2 = 'lh_nacc_aseg_fd.mat';

%ctrInitBatchTrack(lcnectr)

%scoring fibers
%right hemisphere
%ctrInitBatchScore('/media/storg/matproc/ConTrack/mpfcnacc/logs/mpfcnacc_rmpfcnacc_ctrInitLog_08-Aug-2017_15h25m27s.mat', 500,1);

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
