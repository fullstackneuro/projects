cd('/media/storg/matproc/hm082514_hardi3/dti96trilin/fibers/conTrack/plasticity');

%right hemisphere mpfc
mpfc_fg_name = mrvSelectFile('r',{'*.mat';'*.*'}, 'Select fiber group file');
mpfc_fg_unclean = fgRead(mpfc_fg_name);
[mpfc_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(mpfc_fg_unclean, 4, 2, 100);
fgWrite(mpfc_fg_clean, 'clean_scoredFG_plasticity_rh_mpfc_4mm_rh_nacc_aseg_top500','mat');

%left hemisphere mpfc
lh_mpfc_fg_name = mrvSelectFile('r',{'*.mat';'*.*'}, 'Select fiber group file');
lh_mpfc_fg_unclean = fgRead(lh_mpfc_fg_name);
[lh_mpfc_fg_clean, lh_fg_keep_vec] = mbaComputeFibersOutliers(lh_mpfc_fg_unclean, 4, 2, 100);
fgWrite(lh_mpfc_fg_clean, 'clean_scoredFG_plasticity_lh_mpfc_4mm_lh_nacc_aseg_top500','mat');

%vta_fg_name = mrvSelectFile('r',{'*.pdb';'*.*'}, 'Select fiber group file');
%vta_fg_unclean = fgRead(vta_fg_name);
%[vta_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(vta_fg_unclean, 4, 2, 100);
%fgWrite(vta_fg_clean, 'rh_vta_nacc_fgclean','mat');