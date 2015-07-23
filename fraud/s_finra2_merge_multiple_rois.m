function s_finra2_merge_multiple_rois
% merges several mat rois, saves as single mat roi
%
%
%

datapath = '/media/storg/matproc';

subjects = {'ab071412','bc050913','bk032113','ch101612', ...
            'cs050813','dc050213','dp092612','ds080712','ec081912', ...
            'en062813','fg092712','gr051513','hg101012','hm062513', ...
            'jh042913','jl071912','jo081312','jt062413','jw072512', ...
            'kr030113','lc052213','lf052813','lw061713','md072512', ...
            'mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713', ...
            'pw061113','ra053013','rb073112','rb082212','sd040313', ...
            'sh010813','sl080912','sn061213','sp061313','tr101312', ...
            'tw062113','vv060313','wb071812'};    
       
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    roi1    = dtiReadRoi(fullfile(roiPath,'rh_wmmask_ins_fd.mat'));
    roi2    = dtiReadRoi(fullfile(roiPath,'rh_amyg_a2009s.mat'));
    %roi3    = dtiReadRoi(fullfile(roiPath,'lh_infins_a2009s.mat'));
    %roi4    = dtiReadRoi(fullfile(roiPath,'lh_medins_a2009s.mat'));
    newRoiName = fullfile(roiPath,'rh_wmmask_amyg_fd.mat');
    %newRoi   = dtiMergeROIs(roi1,roi2);
    %newRoi2  = dtiMergeROIs(newRoi,roi3);
    finalRoi = dtiMergeROIs(roi1, roi2);
    dtiWriteRoi(finalRoi, newRoiName)
end
