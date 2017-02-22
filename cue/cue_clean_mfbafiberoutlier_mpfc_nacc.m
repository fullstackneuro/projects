
subjects = {'am160914'};
%{
89 diff dir ='nb160221',         
'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
            'jv151030','ps151001','si151120','sr151031','tf151127','vm151031', ...
            'wr151127','zl150930'
            'ac160415','cm160510','ja160416','jr160507','mp160511','ps160508','rt160420','yl160507'    
'as160129','bp160213','cs160214','kl160122', ...
            'rp160205','ss160205','wh160130'
thirdwave
'bb160402','bk032113','jc160320','jc160321','jh160702','jw160316','pk160319','rb160407','rf160313','zl150930'
            'mp160511','jn160403',
            'wb071812'jt062413
ab071412,dc050213,ds080712,gr051513,hm062513,jc160320,jg151121,jh042913,jl071912,jt062413,
jw072512,lc052213,mk021913,ml061013,mp160511,rb160407

'al151016','bb160402','bp160213','cs160214','jc160320','jc160321','jg151121',
'jv151030','jw160316','pk160319','ps151001','rb160407','rf160313','zl150930'

%}

cd('/media/storg/matproc/zl150930/dti96trilin/fibers/conTrack/mpfcnacc');

%manually load fiber group, clean outliers, save cleaned fiber group
rh_fg_name = mrvSelectFile('r',{'*.mat';'*.*'}, 'Select fiber group file');
rh_fg_unclean = fgRead(rh_fg_name);
[rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
fgWrite(rh_fg_clean, 'clean_rh_mpfc_nacc','mat');

lh_fg_name = mrvSelectFile('r',{'*.mat';'*.*'}, 'Select fiber group file');
lh_fg_unclean = fgRead(lh_fg_name);
[lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
fgWrite(lh_fg_clean, 'clean_lh_mpfc_nacc','mat');



