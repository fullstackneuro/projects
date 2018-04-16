

subjects = {'ac160415','cm160510','ja160416','jr160507','mp160511','ps160508','rt160420','yl160507', ...
            'jb161004','rc161007','se161021','mr161024', ...
            'gm161101','hw161104','ph161104','kd170115', ...
            'er170121','al170316','jd170330','jw170330', ...
            'tg170423','jc170501','hp170601','rl170603' };

afq_dir = '/media/lcne/matproc/';

afq_subs = {};
for i = 1:length(subjects)
    afq_subs{i} = [afq_dir subjects{i} '/dti96trilin'];
end

%split groups controls v addicts
afq_group = [0 1 1 0 0 0 1 0 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1];

%no group split
%afq_group = repmat(0,1,length(subjects));

%afq run
AFQ_run(afq_subs, afq_group)