


merged_fg_name = 'merge_1_3_rh_mpfc_nacc';
%load fg1
fg1 = mrvSelectFile('r',{'*.mat';'*.*'}, 'Select fiber group 1');
fg1 = fgRead(fg1);
%load fg2
fg2 = mrvSelectFile('r',{'*.mat';'*.*'}, 'Select fiber group 2');
fg2 = fgRead(fg2);
%merge fg
merged_fg = dtiMergeFiberGroups(fg1,fg2,merged_fg_name);
%save fg
fgWrite(merged_fg,['/media/storg/matproc/hm082514/fibers/' merged_fg_name], 'mat');