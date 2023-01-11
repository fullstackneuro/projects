function a_abcd_reorient_fibers

baseDir='/mnt/acorn/abcd/matproc';

%amyg_a:
%   r1: _dwi_y1_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_lateralamyg_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_lh_amygnacc_merged_fd_cut005_initcut005_curv1_step02_nfibers1000_prob.pdb
%       _dwi_y1_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_lateralamyg_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_rh_amygnacc_merged_fd_cut005_initcut005_curv1_step02_nfibers1000_prob.pdb
%   r2: _dwi_y1_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_lateralamyg_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_lh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_nfibers1000_prob.pdb
%       _dwi_y1_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_lateralamyg_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_rh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_nfibers1000_prob.pdb

%amyg_b:
%   r1: _dwi_y1_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_lateralamyg_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_lh_amygnacc_merged_fd_cut005_initcut005_curv1_step02_prob.pdb
%       _dwi_y1_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_lateralamyg_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_rh_amygnacc_merged_fd_cut005_initcut005_curv1_step02_prob.pdb
%   r2: _dwi_y1_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_lateralamyg_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_lh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_prob.pdb
%       _dwi_y1_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_lateralamyg_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_rh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_prob.pdb

%amyg_c:
%   r1: _dwi_y1_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_lateralamyg_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_lh_amygnacc_merged_fd_cut005_initcut005_curv1_step02_nfibers1000_prob.pdb
%       _dwi_y1_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_lateralamyg_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_rh_amygnacc_merged_fd_cut005_initcut005_curv1_step02_nfibers1000_prob.pdb
%   r2: _dwi_y1_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_lateralamyg_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_lh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_prob.pdb
%       _dwi_y1_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_lateralamyg_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_rh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_prob.pdb

%amyg_d:
%   r1: _dwi_y1_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_lateralamyg_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_lh_amygnacc_merged_fd_cut005_initcut005_curv1_step02_prob.pdb
%       _dwi_y1_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_lateralamyg_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_rh_amygnacc_merged_fd_cut005_initcut005_curv1_step02_prob.pdb
%   r2: _dwi_y1_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_lateralamyg_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_lh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_nfibers1000_prob.pdb
%       _dwi_y1_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_lateralamyg_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_rh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_nfibers1000_prob.pdb

%amyg_makeup
%   r1: _dwi_y1_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_lateralamyg_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_lh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_nfibers1000_prob.pdb
%       _dwi_y1_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_lateralamyg_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_rh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_nfibers1000_prob.pdb




%read subjects in from text file
subjects={};
file=fopen('/mnt/acorn/abcd/matproc/scripts/amyg_makeup_fin.txt','r');
tline=fgetl(file);
while ischar(tline)
    disp(tline)
    subjects=[subjects, tline];
    tline=fgetl(file);
end

bad_subs = {};

for isubj = 1:length(subjects)
   subjectDir = fullfile(baseDir, subjects{isubj});
   roiDir = fullfile(subjectDir, 'ROIs');
   fiberDir = fullfile(subjectDir, '/dti60trilin/fibers/mrtrix');
   
   disp(subjects{isubj});
   
   %left
   try
       leftToRoifile = fullfile(roiDir, 'lh_nacc_aseg_fd.mat');
       leftFromRoifile = fullfile(roiDir, 'lh_lateralamyg_fd.mat');
       leftFGfile = fullfile(fiberDir, [subjects{isubj} '_dwi_y1_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_lateralamyg_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_lh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_nfibers1000_prob.pdb']);
       leftFG = fgRead(leftFGfile);
       leftToRoi = dtiReadRoi(leftToRoifile);
       leftFromRoi = dtiReadRoi(leftFromRoifile);
       leftFGFlipped = AFQ_ReorientFibers(leftFG, leftFromRoi, leftToRoi);
       %fgWrite(leftFG, fullfile(fiberDir, 'outlie_lh_vta_nacc_old.mat')); %save out old fibergroup under new name.
       fgWrite(leftFGFlipped, fullfile(fiberDir, 'flip_lh_amyg_nacc.mat')); %save out new fibergroup.
       
   catch e
       disp(e.identifier);
       disp(e.message);
       bad_subs=[bad_subs, subjects{isubj}];
   end
   
   %right
   try
       rightToRoifile = fullfile(roiDir, 'rh_nacc_aseg_fd.mat');
       rightFromRoifile = fullfile(roiDir, 'rh_lateralamyg_fd.mat');
       rightFGfile = fullfile(fiberDir, [subjects{isubj} '_dwi_y1_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_lateralamyg_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_rh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_nfibers1000_prob.pdb']);
       rightFG = fgRead(rightFGfile);
       rightToRoi = dtiReadRoi(rightToRoifile);
       rightFromRoi = dtiReadRoi(rightFromRoifile);
       rightFGFlipped = AFQ_ReorientFibers(rightFG, rightFromRoi, rightToRoi);
       %fgWrite(rightFG, fullfile(fiberDir, 'outlie_rh_vta_nacc_old.mat')); %save out old fibergroup under new name.
       fgWrite(rightFGFlipped, fullfile(fiberDir, 'flip_rh_amyg_nacc.mat')); %save out new fibergroup.

   catch e
       disp(e.identifier);
       disp(e.message);
       bad_subs=[bad_subs, subjects{isubj}];
   end
   
   
end

bad_subs=unique(bad_subs);
disp(bad_subs);