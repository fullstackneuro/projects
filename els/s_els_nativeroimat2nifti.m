function s_els_nativeroimat2nifti
%
% This function loads a series of subjects and performs 
% dtiConvertFreeSurferRoiToMat for each one of them
%

baseDir  = '/media/storg/matproc';

subjects = {'els006','els009','els012','els013','els014','els016','els017', ...
            'els024','els025','els026','els028','els032','els033','els034', ...
            'els039','els041','els042','els046','els047','els048', ...
            'els049','els050','els053','els054','els055','els056','els057', ...
            'els058','els059','els060','els061','els062','els064','els065', ...
            'els067','els068','els069','els070','els072','els073','els074', ...
            'els075','els076','els077','els079','els081','els083','els085', ...
            'els086','els087','els088','els089','els090','els093', ...
            'els095','els097','els099','els100'};
        %'els045','els092' still recon
        
for isubj = 1:length(subjects)
    
    subjectDir    = [subjects{isubj}];
    subjectRefImg = [subjects{isubj} '_T1.nii.gz'];
    refImg = fullfile(baseDir, subjectDir, subjectRefImg);
    
    % Build the file names for aseg.nii.gz
    roiProcPath   = fullfile(baseDir, subjects{isubj}, 'ROIs');
    roiSavePath   = fullfile(baseDir, 'elsrois');
    
    lhroiname = fullfile(roiProcPath,'lh_nacc_aseg2nat');
    rhroiname = fullfile(roiProcPath,'rh_nacc_aseg2nat');
    
    %lhsavename = fullfile(roiSavePath,[subjects{isubj} '_lh_nacc_aseg2nat']);
    %rhsavename = fullfile(roiSavePath,[subjects{isubj} '_rh_nacc_aseg2nat']);

    dtiRoiNiftiFromMat(lhroiname,refImg,lhroiname,1);
    dtiRoiNiftiFromMat(rhroiname,refImg,rhroiname,1);
       
    %{
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
