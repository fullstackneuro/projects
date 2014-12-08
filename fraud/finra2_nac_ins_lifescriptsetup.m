%set up script for LiFE guinea pig

%path to: 
%dwi.bvec, 
%dwi.bvals, 
%dwi_trilin_aligned.nii.gz, 
%t1w_acpc.nii.gz, 
%wmmask.nii.gz, (roi2roi tracking one)
%nac_roi.nii.gz (use dtiRoiNiftifromMat)
%insula_roi.nii.gz
%whole_brain_tractography.mat/pdb, (import .pdb, save as .mat)
%tract_nac_to_insula.mat/pdb 

%1. clip WBC to the WM mask
%2. find fibers in clipped WBC touching ROI1 and ROI1
%3. clean the fibers found (using length? or also volume?)
%4. Remove these fibers from WBC? Or add them to the TRACT?
%5. combine WBC with TRACT
%6. build a life model with WBC+TRACT
%7. Fit the LiFE model
%8. perform a virtual lesion

subjects= {'ab071412','ds080712','en062813','gr051513','hm062513', ...
            'jw072512','na060213','sp061313','tr101312', 'vv060313', 'wb071812'};
        
baseDir = '/media/storg/matlab_proc/';

for isbj = 1:length(subjects)

subjectDir = [subjects{isubj} '_mrdiff'];
subjectRefImg = [subjects{isubj} '_t1_acpc.nii.gz'];

subjectFolder = fullfile(baseDir, subjectDir);
fibersFolder = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/life/');
roiFolder = fullfile(baseDir, subjectDir, '/ROIs/');
fullsubjectAcqName = dir(fullfile(subjectFolder, '*.bvals'));
[~, subAcqName,~] = fileparts(fullsubjectAcqName.name);

sub_dwi_bvec = fullfile(subjectFolder, subAcqName, '.bvecs');
sub_dwi_bval = fullfile(subjectFolder, subAcqName, '.bvals'));
sub_dwi_raw = fullfile(subjectFolder, subAcqName, '.nii.gz'));
sub_t1w_acpc = fullfile(subjectFolder, subjectRefImg);
sub_wmmask_track = fullfile(roiFolder, 'rh_wmMask_large_tracking.nii.gz');
sub_roi1 = fullfile(roiFolder, 'rh_antins_short_merge_fds.nii.gz'};
sub_roi2 = fullfile(roiFolder, 'rh_nacc_aseg_ds.nii.gz');
sub_wbc = fullfile(fibersFolder, 'rh_wmMask_lmax8.mat');
sub_roi2roi_track = fullfile(fibersFolder, 'rh_antmed_nacc_fgclean.mat');

end
return