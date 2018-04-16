function s_subval_dtiConvFSroi2mat
%
% This function loads a series of subjects and performs 
% dtiConvertFreeSurferRoiToMat for each one of them
%

matpath  = '/media/lcne/matproc/subval';

subjects = {'SV_002','SV_003','SV_005','SV_007','SV_009','SV_015','SV_016', ...
            'SV_020','SV_021','SV_025','SV_027','SV_032','SV_034','SV_035', ...
            'SV_036','SV_038','SV_041','SV_045','SV_047','SV_048','SV_061', ...
            'SV_062','SV_064','SV_065','SV_066','SV_068','SV_071','SV_073', ...
            'SV_081','SV_082','SV_086','SV_088','SV_090','SV_093','SV_096', ...
            'SV_100','SV_101','SV_103','SV_106','SV_107','SV_109','SV_111', ...
            'SV_115','SV_116','SV_119','SV_120','SV_123','SV_128','SV_129', ...
            'SV_131','SV_136','SV_139','SV_140','SV_141','SV_142','SV_145', ...
            'SV_146','SV_147','SV_149','SV_150','SV_151','SV_152','SV_153', ...
            'SV_157','SV_158','SV_161','SV_162','SV_163','SV_165','SV_166'};


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
    dtiConvertFreeSurferRoiToMat(asegPath, 18, 'lh_amyg_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 54, 'rh_amyg_a2009s');
    
end
