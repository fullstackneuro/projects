function a_abcd_merge_rois
% merges two mat rois, saves as single mat roi

datapath = '/mnt/acorn/abcd/matproc';
%subjects = dir(fullfile(datapath,'NDAR*'));
%sublist = {};

%for isubj =1:numel(subjects)
%     lh_mask_loc = ['/mnt/acorn/abcd/matproc/' subjects(isubj).name '/ROIs/lh_wmmask_fs_fd.mat'];
%     rh_mask_loc = ['/mnt/acorn/abcd/matproc/' subjects(isubj).name '/ROIs/rh_wmmask_fs_fd.mat'];
%     lh_amyg_loc = ['/mnt/acorn/abcd/matproc/' subjects(isubj).name '/ROIs/lh_lateralamyg_fd.mat'];
%     rh_amyg_loc = ['/mnt/acorn/abcd/matproc/' subjects(isubj).name '/ROIs/rh_lateralamyg_fd.mat'];
%     if exist(lh_mask_loc,'file') == 2 && exist(rh_mask_loc, 'file') == 2 && exist(rh_amyg_loc, 'file') == 2 && exist(lh_amyg_loc, 'file') == 2
%        sublist=[sublist, subjects(isubj).name];
%     end
%end

sublist={};
file=fopen('/mnt/acorn/abcd/matproc/scripts/amyg_xform_makeup.txt','r');
tline=fgetl(file);
while ischar(tline)
    disp(tline)
    sublist=[sublist, tline];
    tline=fgetl(file);
end
            
hemis = {'lh','rh'};

for isubj = 1:length(sublist)
    roiPath = fullfile(datapath,sublist{isubj},'ROIs');
    for hemi = 1:length(hemis)
        try
            disp(sublist{isubj});
            roi1name = [hemis{hemi} '_amygnacc_amyg.mat']; %amygnacc_amyg
            roi2name = [hemis{hemi} '_nacc_aseg_fd.mat'];
            roi1    = dtiReadRoi(fullfile(roiPath, roi1name));
            roi2    = dtiReadRoi(fullfile(roiPath, roi2name));
            newRoiName = fullfile(roiPath,[hemis{hemi} '_amygnacc_merged.mat']); %_amygnacc_merged
            newRoi     = dtiMergeROIs(roi1,roi2);
            dtiWriteRoi(newRoi, newRoiName)
        catch e
            disp(e.identifier);
            disp(e.message);
        end
    end
end