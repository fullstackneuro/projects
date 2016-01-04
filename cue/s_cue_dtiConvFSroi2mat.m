function s_cue_dtiConvFSroi2mat
%
% This function loads a series of subjects and performs 
% dtiConvertFreeSurferRoiToMat for each one of them
%

matpath  = '/media/storg/matproc';

subjects = {'aa151010','al151016','dw151003','ps151001','zl150930'};

for isubj = 1:length(subjects)
    % Build the file names for aseg.nii.gz
    matProcPath   = fullfile(matpath, subjects{isubj}, 'ROIs');
    asegFile  = dir(fullfile(matProcPath,'a2009seg2acpc.nii.gz'));
    asegFname = asegFile.name;
    asegPath  = fullfile(matProcPath, asegFname);

    %create mat rois based on fs seg lookup table
    dtiConvertFreeSurferRoiToMat(asegPath, 11113, 'lh_frontorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12113, 'rh_frontorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11163, 'lh_latorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12163, 'rh_latorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11124, 'lh_orb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12124, 'rh_orb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11114, 'lh_frontinfang_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12114, 'rh_frontinfang_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 18, 'lh_amyg_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 54, 'rh_amyg_a2009s');
    %{
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
   %}
end
