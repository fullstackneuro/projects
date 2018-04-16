function s_clscng_dtiConvFSroi2mat
%
% This function converts freesurfer ROIs into mat files for each subject
%

% Path to subjects
datapath = '/media/lcne/matproc';

% Subject names
subjects = {'am160914','kn160918','ld160918','li160927','ac160415','jh160702','jr160507', ...
            'mp160511','ps160508', 'al151016', 'jg151121', 'jv151030','ps151001','zl150930'};

%{          
storg            
'ab071412','bb160402','bk032113','bp160213', ...
'cs160214','dc050213','ds080712','en062813','gr051513','hm062513','jc160320', ...
 'jc160321','jl071912','jt062413', 'jw072512','jw160316', ...     
'lc052213','mk021913','ml061013','np072412','pk160319'                   
%}
            
for isubj = 1:length(subjects)
    % Build the file names for aseg.nii.gz
    matProcPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    asegFile  = dir(fullfile(matProcPath,'a2009seg2acpc.nii.gz'));
    asegFname = asegFile.name;
    asegPath  = fullfile(matProcPath, asegFname);

    %create mat rois based on fs seg lookup table
    %{
    % pfc
    dtiConvertFreeSurferRoiToMat(asegPath, 11113, 'lh_frontorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12113, 'rh_frontorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11163, 'lh_latorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12163, 'rh_latorb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11124, 'lh_orb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12124, 'rh_orb_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 11114, 'lh_frontinfang_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 12114, 'rh_frontinfang_a2009s');
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
    %}
    
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
    
    %{
    % deep brain
    dtiConvertFreeSurferRoiToMat(asegPath, 16, 'brainstem_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 28, 'lh_ventraldc_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 60, 'rh_ventraldc_aseg');
    dtiConvertFreeSurferRoiToMat(asegPath, 18, 'lh_amyg_a2009s');
    dtiConvertFreeSurferRoiToMat(asegPath, 54, 'rh_amyg_a2009s');
    %}  
    
end
