function s_duke_dtiConvFSroi2mat
%
% This function loads a series of subjects and performs 
% dtiConvertFreeSurferRoiToMat for each one of them
%

matpath  = '/cylon/matproc';

subjects = {'dnd029', 'dnd039', 'dnd060', 'dnd069', 'dnd070', 'dnd092', 'dnd097', 'dnd099', 'dnd109', 'dnd114', 'dnd121'};


%lh 16 2 10 11 12 13 26 28 11106 11107 11108 11109 11110 11113 11115 11116 11117 11118 11124 11139 11148 11149 11154 11155 11163 11164 11165
%rh 16 41 49 50 51 52 58 60 12106 12107 12108 12109 12110 12113 12115 12116 12117 12118 12124 12139 12148 12149 11154 12155 12163 12164 12165

for isubj = 1:length(subjects)
    % Build the file names for aseg.nii.gz
    matProcPath   = fullfile(matpath, subjects{isubj}, 'ROIs');
    asegFile  = dir(fullfile(matProcPath,'a2009seg2acpc.nii.gz'));
    asegFname = asegFile.name;
    asegPath  = fullfile(matProcPath, asegFname);

    %create mat rois based on fs seg lookup table
    
    % pfc
    dtiConvertFreeSurferRoiToMat(asegPath, 11113, 'lh_frontorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12113, 'rh_frontorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11163, 'lh_latorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12163, 'rh_latorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11124, 'lh_orb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12124, 'rh_orb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11114, 'lh_frontinfang_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12114, 'rh_frontinfang_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11115, 'lh_frontmidlat_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12115, 'rh_frontmidlat_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11116, 'lh_supfront_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12116, 'rh_supfront_a2009s');
    
    % insula
    dtiConvertFreeSurferRoiToMat(asegPath, 11117, 'lh_medins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12117, 'rh_medins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11148, 'lh_antins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12148, 'rh_antins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11118, 'lh_shortins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12118, 'rh_shortins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11149, 'lh_infins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12149, 'rh_infins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11150, 'lh_supins_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12150, 'rh_supins_a2009s');
    
    % striatum
    dtiConvertFreeSurferRoiToMat(asegPath, 26, 'lh_nacc_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 58, 'rh_nacc_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 10, 'lh_thal_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 49, 'rh_thal_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 11, 'lh_caud_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 50, 'rh_caud_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 12, 'lh_put_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 51, 'rh_put_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 13, 'lh_pal_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 52, 'rh_pal_aseg');
    
    % cingulate
    dtiConvertFreeSurferRoiToMat(asegPath, 11106, 'lh_antcing_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12106, 'rh_antcing_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11107, 'lh_midantcing_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12107, 'rh_midantcing_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11108, 'lh_midpostcing_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12108, 'rh_midpostcing_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11109, 'lh_dorspostcing_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12109, 'rh_dorspostcing_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11110, 'lh_ventpostcing_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12110, 'rh_ventpostcing_a2009s');
    
    % deep brain
    dtiConvertFreeSurferRoiToMat(asegPath, 16, 'brainstem_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 28, 'lh_ventraldc_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 60, 'rh_ventraldc_aseg');
    
    dtiConvertFreeSurferRoiToMat(asegPath, 18, 'lh_amyg_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 54, 'rh_amyg_aseg');
end