function s_fe_make_wm_mask
%
% This script makes the white-matter mask used to track the connectomes in
% Pestilli et al., LIFE paper.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

% Get the base directory for the data
anatomypath = getenv('SUBJECTS_DIR');
subjects = {...   
    'subjects', ...
    };

for isbj = 1:length(subjects)
    wmMaskFile = fullfile(anatomypath,matchSubject2FSSUBJ(subjects{isbj}),'wm_mask.nii.gz');
    
    fs_wm = matchfiles(fullfile(anatomypath,matchSubject2FSSUBJ(subjects{isbj}),'mri','aseg.mgz'));
    eval(sprintf('!mri_convert  --out_orientation RAS %s %s', fs_wm{1}, wmMaskFile));
    wm = niftiRead(wmMaskFile);
    invals  = [2 41 16 17 28 60 51 53 12 52 13 18 54 50 11 251 252 253 254 255 10 49];
    origvals = unique(wm.data(:));
    fprintf('\n[%s] Converting voxels... ',mfilename);
    wmCounter=0;noWMCounter=0;
    for ii = 1:length(origvals);
        if any(origvals(ii) == invals)
            wm.data( wm.data == origvals(ii) ) = 1;
            wmCounter=wmCounter+1;
        else            
            wm.data( wm.data == origvals(ii) ) = 0;
            noWMCounter = noWMCounter + 1;
        end
    end
    fprintf('converted %i regions to White-matter (%i regions left outside of WM)\n\n',wmCounter,noWMCounter);
    niftiWrite(wm);
end

end % Main function

function FS_SUBJECT = matchSubject2FSSUBJ(subject)

switch subject
    case {'menon'}
        FS_SUBJECT = 'sm';
                
    otherwise
        keyboard
end
end