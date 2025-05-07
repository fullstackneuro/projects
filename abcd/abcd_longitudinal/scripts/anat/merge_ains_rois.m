function merge_ains_rois(datapath, sublist)
% merges two mat rois, saves as single mat roi

%generate subject list from textfile
str = fileread(sublist);
sublist = regexp(str, '\n', 'split');
subjects = sublist(~cellfun('isempty',sublist));
            
hemis = {'lh','rh'};

for isubj = 1:length(subjects)
    
    %establish subject-level paths
    rawName=subjects{isubj};
    subName=['sub-' rawName(1:15)];
    timePoint=['ses-' rawName(17:34)];    
    
    roiPath = fullfile(datapath,subName,timePoint,'ROIs');
    for hemi = 1:length(hemis)
        try
            roi1name = [hemis{hemi} '_antins_a2009s.mat'];
            roi2name = [hemis{hemi} '_shortins_a2009s.mat'];
            roi1    = dtiReadRoi(fullfile(roiPath, roi1name));
            roi2    = dtiReadRoi(fullfile(roiPath, roi2name));
            newRoiName = fullfile(roiPath,[hemis{hemi} '_antshortins.mat']);
            newRoi     = dtiMergeROIs(roi1,roi2);
            dtiWriteRoi(newRoi, newRoiName)
        catch e
            disp(e.identifier);
            disp(e.message);
        end
    end
end



end