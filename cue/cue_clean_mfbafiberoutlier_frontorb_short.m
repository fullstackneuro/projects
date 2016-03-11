
subjects = {'as160129','bp160213','cs160214','kl160122', ...
            'rp160205','ss160205','wh160130'};
%{
89 diff dir ='nb160221',         
'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
            'jv151030','ps151001','si151120','sr151031','tf151127','vm151031', ...
            'wr151127','zl150930'
%}
        
cd('/media/storg/matproc/wh160130/dti96trilin/fibers/mrtrix');

%manually load fiber group, clean outliers, save cleaned fiber group
rh_fg_name = mrvSelectFile('r',{'*.pdb';'*.*'}, 'Select fiber group file');
rh_fg_unclean = fgRead(rh_fg_name);
[rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
%fgWrite(rh_fg_clean, 'clean_rh_antshortins_nacc','mat');