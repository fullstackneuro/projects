% lcne contrack pvt-nacc

% rh mpfc nacc
lcnectr = ctrInitBatchParams;
lcnectr.projectName = 'pvtnacc';
lcnectr.logName = 'rpvtnacctlrc';
lcnectr.baseDir = '/media/lcne/matproc';
lcnectr.dtDir = 'dti96trilin';
lcnectr.roiDir = 'ROIs';
lcnectr.subs = {'ac160415','am160914','jh160702','jr160507','kn160918','ld160918','li160927','mp160511','ps160508'};
lcnectr.roi1 = 'rPVTtlrc.mat';
lcnectr.roi2 = 'rh_nacc_aseg_fd.mat';

ctrInitBatchTrack(lcnectr)
%{
% lh mpfc nacc
lcnectr = ctrInitBatchParams;
lcnectr.projectName = 'mpfcnacc';
lcnectr.logName = 'lmpfcnacc';
lcnectr.baseDir = '/media/lcne/matproc';
lcnectr.dtDir = 'dti96trilin';
lcnectr.roiDir = 'ROIs';
lcnectr.subs = {'ac160415','am160914','jh160702','jr160507','kn160918','ld160918','li160927','mp160511','ps160508'};
lcnectr.roi1 = 'lh_mpfc_4mm.mat';
lcnectr.roi2 = 'lh_nacc_aseg_fd.mat';

%ctrInitBatchTrack(lcnectr)
%}

%scoring fibers
%right hemisphere
ctrInitBatchScore('/media/lcne/matproc/ConTrack/pvtnacc/logs/pvtnacc_rpvtnacctlrc_ctrInitLog_13-Dec-2016_16h04m33s.mat', 500,1);

%left hemisphere
%ctrInitBatchScore('/media/lcne/matproc/ConTrack/mpfcnacc/logs/mpfcnacc_lmpfcnacc_ctrInitLog_18-Nov-2016_17h33m50s.mat', 500,1);


% storg contrack

% rh mpfc nacc
lcnectr = ctrInitBatchParams;
lcnectr.projectName = 'mpfcnacc';
lcnectr.logName = 'rmpfcnacc';
lcnectr.baseDir = '/media/storg/matproc';
lcnectr.dtDir = 'dti96trilin';
lcnectr.roiDir = 'ROIs';
lcnectr.subs = {'al151016','bb160402','bp160213','cs160214','jc160320','jc160321','jg151121','jv151030','jw160316','pk160319','ps151001','rb160407','rf160313','zl150930'};
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
lcnectr.subs = {'al151016','bb160402','bp160213','cs160214','jc160320','jc160321','jg151121','jv151030','jw160316','pk160319','ps151001','rb160407','rf160313','zl150930'};
lcnectr.roi1 = 'lh_mpfc_4mm.mat';
lcnectr.roi2 = 'lh_nacc_aseg.mat';
lcnectr.multiThread = 1;

ctrInitBatchTrack(lcnectr)



