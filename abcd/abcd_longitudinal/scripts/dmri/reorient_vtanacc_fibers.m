function reorient_vtanacc_fibers(baseDir, sublist)

%generate subject list from textfile
str = fileread(sublist);
sublist = regexp(str, '\n', 'split');
subjects = sublist(~cellfun('isempty',sublist));

for isubj = 1:length(subjects)
    
   %establish subject-level paths
   rawName=subjects{isubj};
   subName=['sub-' rawName(1:15)];
   timePoint=['ses-' rawName(17:34)];
    
   subjectDir = fullfile(baseDir, subName, timePoint);
   roiDir = fullfile(subjectDir, 'ROIs');
   fiberDir = fullfile(subjectDir, '/dti60trilin/fibers/mrtrix');
   
   disp(subName);
   
   %left
   try
       leftToRoifile = fullfile(roiDir, 'lh_nacc_aseg_fd.mat');
       leftFromRoifile = fullfile(roiDir, 'lh_vtapbp_nihpd_fd.mat');
       leftFGfile = fullfile(fiberDir, [subName '_dwi_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_vtapbp_nihpd_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_vtapbp_nihpd_fd_nonZero_MaskROI_union.nii.gz_lh_vta_nacc_nihpd_bin01_1mm_fd_clip_cut003_initcut003_curv1_step02_nfibers2000_prob.pdb']);
       leftFG = fgRead(leftFGfile);
       leftToRoi = dtiReadRoi(leftToRoifile);
       leftFromRoi = dtiReadRoi(leftFromRoifile);
       leftFGFlipped = AFQ_ReorientFibers(leftFG, leftFromRoi, leftToRoi);
       fgWrite(leftFGFlipped, fullfile(fiberDir, 'flip_lh_vta_nacc.mat')); %save out new fibergroup.
       
   catch e
       disp(e.identifier);
       disp(e.message);
   end
   
   %right
   try
       rightToRoifile = fullfile(roiDir, 'rh_nacc_aseg_fd.mat');
       rightFromRoifile = fullfile(roiDir, 'rh_vtapbp_nihpd_fd.mat');
       rightFGfile = fullfile(fiberDir, [subName '_dwi_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_vtapbp_nihpd_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_vtapbp_nihpd_fd_nonZero_MaskROI_union.nii.gz_rh_vta_nacc_nihpd_bin01_1mm_fd_clip_cut003_initcut003_curv1_step02_nfibers2000_prob.pdb']);
       rightFG = fgRead(rightFGfile);
       rightToRoi = dtiReadRoi(rightToRoifile);
       rightFromRoi = dtiReadRoi(rightFromRoifile);
       rightFGFlipped = AFQ_ReorientFibers(rightFG, rightFromRoi, rightToRoi);
       fgWrite(rightFGFlipped, fullfile(fiberDir, 'flip_rh_vta_nacc.mat')); %save out new fibergroup.

   catch e
       disp(e.identifier);
       disp(e.message);
   end
   
   
end