subjects = {'els013','els014','els016','els017', ...
            'els024','els025','els026','els028','els032','els033','els039', ...
            'els041','els042','els045','els046','els047','els048', ...
            'els049','els050','els053','els054','els055','els056','els057', ...
            'els064','els065','els067','els068','els069','els070', ...
            'els072','els073','els074','els076','els077','els079','els081', ...
            'els083','els085','els087','els088','els093'};
        
afq_dir = '/media/storg/matproc/';]

afq_subs = {};
for i = 1:length(subjects)
    afq_subs{i} = [afq_dir subjects{i} '/dti60trilin'];
end

%split groups at 12 y.o.
afq_group = [1 0 0 0 ...
             1 0 0 0 0 0 0 ...
             1 1 1 0 1 0 ...
             0 1 0 0 0 1 0 ...
             0 0 0 1 0 1 ...
             0 1 0 0 1 0 0 ...
             1 0 0 1 1];

%no group split
afq_group = repmat(0,1,length(subjects));