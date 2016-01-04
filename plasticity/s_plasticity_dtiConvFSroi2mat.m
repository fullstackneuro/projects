function s_plasticity_dtiConvFSroi2mat
%
% This function loads a series of subjects and performs 
% dtiConvertFreeSurferRoiToMat for each one of them
%

matpath  = '/media/storg/matproc';
subjects = {'lt081615_1','lt081615_2'};

%{
'mm080915_1','mm080915_2','nb081015_1','nb081015_2'
'ld080115_1','ld080115_2','lp080215_1','lp080215_2'
'ad082014_2','hm082514_2','ml082214_2','yw083014_2'
%}

for isubj = 1:length(subjects)
    % Build the file names for aseg.nii.gz
    matProcPath = fullfile(matpath, subjects{isubj});
    asegPath  = fullfile(matProcPath,'ROIs','a2009seg2acpc.nii.gz');
    
    %create mat rois based on fs seg lookup table
    dtiConvertFreeSurferRoiToMat(asegPath, 18, 'lh_amyg_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 54, 'rh_amyg_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11117, 'lh_medins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12117, 'rh_medins_a2009s');

    dtiConvertFreeSurferRoiToMat(asegPath, 26, 'lh_nacc_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 58, 'rh_nacc_aseg');
    
    dtiConvertFreeSurferRoiToMat(asegPath, 11148, 'lh_antins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12148, 'rh_antins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11118, 'lh_shortins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12118, 'rh_shortins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11149, 'lh_infins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12149, 'rh_infins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11150, 'lh_supins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12150, 'rh_supins_a2009s');
    
    dtiConvertFreeSurferRoiToMat(asegPath, 10, 'lh_thal_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 49, 'rh_thal_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 11, 'lh_caud_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 50, 'rh_caud_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 12, 'lh_put_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 51, 'rh_put_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 13, 'lh_pal_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 52, 'rh_pal_aseg');
    
    dtiConvertFreeSurferRoiToMat(asegPath, 41, 'rh_wmseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 2, 'lh_wmseg');
    
    dtiConvertFreeSurferRoiToMat(asegPath, 16, 'brainstem_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 28, 'lh_ventraldc_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 60, 'rh_ventraldc_aseg');

end
