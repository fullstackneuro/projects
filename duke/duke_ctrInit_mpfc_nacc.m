% contrack

% rh mpfc nacc
mpfcctr = ctrInitBatchParams;
mpfcctr.projectName = 'mpfcnacc';
mpfcctr.logName = 'rmpfcnacc';
mpfcctr.baseDir = '/cylon/matproc';
mpfcctr.dtDir = 'dti64trilin';
mpfcctr.roiDir = 'ROIs';
mpfcctr.subs = {};
 %{
'dnd005','dnd006','dnd007','dnd011','dnd013','dnd014', ...
                'dnd016','dnd018','dnd019','dnd021','dnd022','dnd023','dnd027'
'dnd029','dnd030','dnd031','dnd032','dnd033','dnd034','dnd037', ...
                'dnd039','dnd041','dnd042','dnd043','dnd044','dnd045'
 'dnd046','dnd048','dnd050','dnd052','dnd057','dnd058','dnd060', ...
                'dnd062','dnd065','dnd069','dnd070','dnd072','dnd073','dnd074'
'dnd077','dnd078','dnd080','dnd083','dnd084','dnd087','dnd088', ...
                'dnd089','dnd090','dnd091','dnd092','dnd093','dnd094','dnd096'
'dnd097','dnd098','dnd099','dnd100','dnd102','dnd104','dnd105'
'dnd107','dnd109','dnd110','dnd111','dnd113','dnd114','dnd115', ...
                'dnd118','dnd119','dnd121'
%}
%dnd040 no dwi
%dnd012 no dt6
mpfcctr.roi1 = 'rh_mpfc_5mm.mat';
mpfcctr.roi2 = 'rh_nacc_aseg_fd.mat';
%tracking
%ctrInitBatchTrack(mpfcctr);
%scoring
ctrInitBatchScore('/cylon/matproc/ConTrack/mpfcnacc/logs/mpfcnacc_lmpfcnacc_ctrInitLog_18-Jan-2021_16h07m45s.mat', 500,1);


%left hemisphere
lmpfcctr = ctrInitBatchParams;
lmpfcctr.projectName = 'mpfcnacc';
lmpfcctr.logName = 'lmpfcnacc';
lmpfcctr.baseDir = '/cylon/matproc';
lmpfcctr.dtDir = 'dti64trilin';
lmpfcctr.roiDir = 'ROIs';
lmpfcctr.subs = {};
lmpfcctr.roi1 = 'lh_mpfc_5mm.mat';
lmpfcctr.roi2 = 'lh_nacc_aseg_fd.mat';
%tracking
%ctrInitBatchTrack(lmpfcctr);
%scoring
%ctrInitBatchScore('/media/lcne/matproc/ConTrack/mpfcnacc/logs/mpfcnacc_lmpfcnacc_ctrInitLog_18-Nov-2016_17h33m50s.mat', 500,1);