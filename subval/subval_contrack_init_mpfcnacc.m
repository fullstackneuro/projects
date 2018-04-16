% lcne contrack

% rh mpfc nacc
lcnectr = ctrInitBatchParams;
lcnectr.projectName = 'mpfcnacc';
lcnectr.logName = 'rmpfcnacc';
lcnectr.baseDir = '/media/lcne/matproc/subval';
lcnectr.dtDir = 'dti32trilin';
lcnectr.roiDir = 'ROIs';
lcnectr.subs = {'SV_002','SV_003','SV_005','SV_007','SV_015','SV_016', ...
            'SV_020','SV_021','SV_025','SV_027','SV_034','SV_035', ...
            'SV_036','SV_038','SV_041','SV_045','SV_047','SV_048','SV_061', ...
            'SV_062','SV_064','SV_065','SV_066','SV_068','SV_071','SV_073', ...
            'SV_081','SV_082','SV_086','SV_088','SV_090','SV_093','SV_096', ...
            'SV_100','SV_101','SV_103','SV_106','SV_107','SV_109','SV_111', ...
            'SV_115','SV_116','SV_119','SV_120','SV_123','SV_128','SV_129', ...
            'SV_131','SV_136','SV_139','SV_140','SV_141','SV_142','SV_145', ...
            'SV_146','SV_147','SV_149','SV_150','SV_151','SV_152','SV_153', ...
            'SV_157','SV_158','SV_161','SV_162','SV_165','SV_166'};
lcnectr.roi1 = 'rh_mpfc_4mm.mat';
lcnectr.roi2 = 'rh_nacc_aseg_fd.mat';

%ctrInitBatchTrack(lcnectr)

% lh mpfc nacc
lcnectr = ctrInitBatchParams;
lcnectr.projectName = 'mpfcnacc';
lcnectr.logName = 'lmpfcnacc';
lcnectr.baseDir = '/media/lcne/matproc/subval';
lcnectr.dtDir = 'dti32trilin';
lcnectr.roiDir = 'ROIs';
lcnectr.subs = {'SV_002','SV_003','SV_005','SV_007','SV_015','SV_016', ...
            'SV_020','SV_021','SV_025','SV_027','SV_034','SV_035', ...
            'SV_036','SV_038','SV_041','SV_045','SV_047','SV_048','SV_061', ...
            'SV_062','SV_064','SV_065','SV_066','SV_068','SV_071','SV_073', ...
            'SV_081','SV_082','SV_086','SV_088','SV_090','SV_093','SV_096', ...
            'SV_100','SV_101','SV_103','SV_106','SV_107','SV_109','SV_111', ...
            'SV_115','SV_116','SV_119','SV_120','SV_123','SV_128','SV_129', ...
            'SV_131','SV_136','SV_139','SV_140','SV_141','SV_142','SV_145', ...
            'SV_146','SV_147','SV_149','SV_150','SV_151','SV_152','SV_153', ...
            'SV_157','SV_158','SV_161','SV_162','SV_165','SV_166'};
lcnectr.roi1 = 'lh_mpfc_4mm.mat';
lcnectr.roi2 = 'lh_nacc_aseg_fd.mat';

%ctrInitBatchTrack(lcnectr)

%scoring fibers
%right hemisphere

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
