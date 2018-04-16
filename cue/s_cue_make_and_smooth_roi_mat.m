function s_cue_make_and_smooth_roi_mat
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/lcne/matproc';

subjects = {'ds170915','ts170927'};
%{
cue done
'ag151024','ja151218','si151120','tf151127','wh160130','wr151127'

storg new
'kr030113','ps022013','tw062113','ec081912','jh042913','jo081312','lf052813', ...
'ra053013','sd040313','sh010813'};
lcne new
'at160601','cg160715','jf160703','lm160914','mr170621','nc160905','rf170610', ...
'rs160730','rv160413','tj160529','zm160627'
lcne done
'jb161004','rc161007','se161021','mr161024', ...
            'gm161101','hw161104','kd170115', ...
            'er170121','al170316','jd170330','jw170330', ...
            'tg170423','hp170601','rl170603','jc170501'
lcne
'am160914','cm160510','ja160416','ps160508','rt160420','yl160507','ac160415', ...
'ag151024','aa151010','al151016','dw151003','ie151020','ja151218', ...
'jh160702','jr160507','kn160918','ld160918','li160927','mp160511'
?'tm160117',
storg
'bb160402','bp160213','jc160320','jc160321','jg151121','jn160403','pk160319',
'ps151001','rb160407','rf160313','rp160205','si151120','sr151031','ss160205',
'tf151127','vm151031','wh160130','wr151127','zl150930','jw160316','as160129',
'cs160214','kl160122','jv151030',
%}
rois = {'rh_nacc_aseg','lh_nacc_aseg', ...
        'rh_frontorb_a2009s','lh_frontorb_a2009s', ...
        'rh_frontinfang_a2009s','lh_frontinfang_a2009s', ...
        'rh_antins_a2009s','lh_antins_a2009s', ...
        'rh_shortins_a2009s','lh_shortins_a2009s', ...
        'rh_nacc_aseg','lh_nacc_aseg', ...
        'rh_latorb_a2009s','lh_latorb_a2009s', ...
        'rh_wmmask_fs','lh_wmmask_fs', ...
        'rh_supfront_a2009s','lh_supfront_a2009s', ...
        'rh_frontmidlat_a2009s','lh_frontmidlat_a2009s', ...
        'rh_ventraldc_aseg','lh_ventraldc_aseg'};
        
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    for iroi = 1:length(rois)
        roi = fullfile(roiPath, [rois{iroi} '.mat']);
        outRoi = fullfile(roiPath, [rois{iroi} '_fd.mat']);
        smoothKernel = 0; % size of the 3D smoothing Kernel in mm
        %operations   = ['fillholes', 'dilate', 'removesat']; 
        operations   = [1, 1, 0]; 

        % fillholes = fill any hole in the ROI. Pass '' to not apply this
        %             operation
        % dilate     = expand the ROI in 3D. Pass '' to not apply this
        %             operation
        % removesat  = remove any voxel disconnected from the rest of the voxels. 
        %              Pass '' to not apply this operation
    
        oldRoiLoad = dtiReadRoi(roi);
        newRoi = dtiRoiClean(oldRoiLoad, smoothKernel, operations);
        dtiWriteRoi(newRoi, outRoi);
    end
end