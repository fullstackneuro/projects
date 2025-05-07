function fs_dtiConvFSroi2mat(matpath, sublist)
%
% This function loads a series of subjects and performs 
% dtiConvertFreeSurferRoiToMat for each one of them
%

%generate subject list from textfile
str = fileread(sublist);
sublist = regexp(str, '\n', 'split');
subjects = sublist(~cellfun('isempty',sublist));


for isubj = 1:length(subjects)
    
    %establish subject-level paths
    rawName=sublist{isubj};
    subName=['sub-' rawName(1:15)];
    timePoint=['ses-' rawName(17:34)];    
    
    try
        % Build the file names for aseg.nii.gz
        matProcPath   = fullfile(matpath, subName, timePoint, 'ROIs');
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
        dtiConvertFreeSurferRoiToMat(asegPath, 17, 'lh_hipp_aseg');
        dtiConvertFreeSurferRoiToMat(asegPath, 53, 'rh_hipp_aseg');
        
        %control regions
        dtiConvertFreeSurferRoiToMat(asegPath, 251, 'cc_post_aseg');
        dtiConvertFreeSurferRoiToMat(asegPath, 252, 'cc_midpost_aseg');
        dtiConvertFreeSurferRoiToMat(asegPath, 253, 'cc_cent_aseg');
        dtiConvertFreeSurferRoiToMat(asegPath, 254, 'cc_midant_aseg');
        dtiConvertFreeSurferRoiToMat(asegPath, 255, 'cc_ant_aseg');
        dtiConvertFreeSurferRoiToMat(asegPath, 11132, 'lh_subcallosal_a2009s');
        dtiConvertFreeSurferRoiToMat(asegPath, 12132, 'rh_subcallosal_a2009s');
        
    catch e
        
       disp('unable to parcellate subject freesurfer file.');
       disp(['error identifier is: ' e.identifier]);
       disp(['error message is: ' e.message]);
       
    end
end
