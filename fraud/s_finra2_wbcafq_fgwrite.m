function s_finra2_wbcafq_fgwrite
%script to output fiber groups from wbc-afq solution
%
baseDir = '/media/storg/matproc';
subjects = {'ab071412','bc050913','bk032113','ch101612','cs050813', ...
            'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            'gr051513','hg101012','hm062513','jh042913','jl071912','jo081312', ...
            'jt062413','jw072512','kr030113','lc052213','lf052813','lw061713', ...
            'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'};
%}
for isubj = 1:length(subjects)
    %build directory path
    subDir   = fullfile(baseDir,subjects{isubj});
    dt6Dir   = fullfile(subDir,'dti96trilin');
    fiberDir = fullfile(subDir,'dti96trilin/fibers/afq');
    
    %load wbc_Afq
    fibersFileName2Load = fullfile(fiberDir, 'lmax10_wbc-AFQ.mat');
    wbc_afq = load(fibersFileName2Load);
    
    %write fibers
    fgWrite(wbc_afq.fascicles(1,1), fullfile(fiberDir,'l_thalrad_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,2), fullfile(fiberDir,'r_thalrad_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,3), fullfile(fiberDir,'l_cst_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,4), fullfile(fiberDir,'r_cst_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,5), fullfile(fiberDir,'l_cingcing_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,6), fullfile(fiberDir,'r_cingcing_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,7), fullfile(fiberDir,'l_cinghippo_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,8), fullfile(fiberDir,'r_cinghippo_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,9), fullfile(fiberDir,'forcepsmaj_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,10), fullfile(fiberDir,'forcepsmin_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,11), fullfile(fiberDir,'l_ifof_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,12), fullfile(fiberDir,'r_ifof_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,13), fullfile(fiberDir,'l_ilf_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,14), fullfile(fiberDir,'r_ilf_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,15), fullfile(fiberDir,'l_slf_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,16), fullfile(fiberDir,'r_slf_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,17), fullfile(fiberDir,'l_uncinate_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,18), fullfile(fiberDir,'r_uncinate_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,19), fullfile(fiberDir,'l_arcuate_lmax10'), 'mat');
    fgWrite(wbc_afq.fascicles(1,20), fullfile(fiberDir,'r_arcuate_lmax10'), 'mat');
end
end