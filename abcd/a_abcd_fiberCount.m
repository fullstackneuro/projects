function a_abcd_fiberCount

filePath = '/mnt/acorn/abcd/matproc';

subjects = {};
%produces subject list:
subjects={};
file=fopen(fullfile(filePath, 'scripts', 'amyg_xform_makeup.txt'),'r');
tline=fgetl(file);
while ischar(tline)
    %disp(tline);
    subjects=[subjects, tline];
    tline=fgetl(file);
end
fclose(file);


missingLeft = {};
missingRight = {};
missingBoth = {};

nofileLeft={};
nofileRight={};
nofileBoth={};


minimum = 5;
leftCount = 0;
rightCount = 0;
bothCount = 0;
leftnofileCount=0;
rightnofileCount=0;
bothnofileCount=0;

for isubj = 1:length(subjects)
   subDir = [subjects{isubj}];
   l_filename = [subDir '_dwi_y1_aligned_trilin_csd_lmax6_lh_nacc_aseg_fd_lh_lateralamyg_fd_lh_nacc_aseg_fd_nonZero_MaskROI_lh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_lh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_nfibers1000_prob.pdb'];
   r_filename = [subDir '_dwi_y1_aligned_trilin_csd_lmax6_rh_nacc_aseg_fd_rh_lateralamyg_fd_rh_nacc_aseg_fd_nonZero_MaskROI_rh_lateralamyg_fd_nonZero_MaskROI_union.nii.gz_rh_amygnacc_merged_fd_cut002_initcut002_curv1_step02_nfibers1000_prob.pdb'];
   
   l_file = fullfile(filePath, subDir, '/dti60trilin/fibers/mrtrix/', l_filename);
   r_file = fullfile(filePath, subDir, '/dti60trilin/fibers/mrtrix/', r_filename);
   
   if exist(l_file,'file')==2 && exist(r_file,'file')==2
       l_fiber = dtiLoadFiberGroup(l_file);
       r_fiber = dtiLoadFiberGroup(r_file);

       l_fiberlength = length(l_fiber.fibers);
       r_fiberlength = length(r_fiber.fibers);

       if(l_fiberlength <= minimum || r_fiberlength <= minimum)
          disp(subDir);
          if(l_fiberlength <= minimum && r_fiberlength > minimum)
             missingLeft = [missingLeft subDir];
             leftCount = leftCount + 1;
          elseif(r_fiberlength <= minimum && l_fiberlength > minimum)
             missingRight = [missingRight subDir];
             rightCount = rightCount + 1;
          else
             missingBoth = [missingBoth subDir];
             bothCount = bothCount + 1;
          end
       end 
   else
       if exist(l_file,'file')==2 && exist(r_file,'file')~=2
            nofileLeft = [nofileLeft subDir];
            leftnofileCount = leftnofileCount + 1;
       elseif exist(r_file,'file')==2 && exist(l_file,'file')~=2
            nofileRight = [nofileRight subDir];
            rightnofileCount = rightnofileCount + 1;
       else
            nofileBoth = [nofileBoth subDir];
            bothnofileCount = bothnofileCount + 1;
       end
   end
end

disp(['missing only left fibers: ' num2str(leftCount)]);
%disp(missingLeft);
disp(['missing only right fibers: ' num2str(rightCount)]);
%disp(missingRight);
disp(['missing fibers both hemispheres: ' num2str(bothCount)]);
%disp(missingBoth);

disp(['missing only left file: ' num2str(leftnofileCount)]);
%disp(nofileLeft);
disp(['missing only right file: ' num2str(rightnofileCount)]);
%disp(nofileRight);
disp(['missing both files: ' num2str(bothnofileCount)]);
%disp(nofileBoth);

missing=[missingLeft missingRight missingBoth];
nofile=[nofileLeft nofileRight nofileBoth];

%write missing to text file
fid=fopen('/mnt/acorn/abcd/matproc/scripts/amyg_makeup_unfin.txt','w');
for i = 1:length(missing)
   fprintf(fid, [missing{i} '\n']); 
end
fclose(fid);


end



