

subjects = {'ac160415','cm160510','ja160416','jr160507','mp160511','ps160508','rt160420','yl160507'};


afq_dir = '/media/lcne/matproc/';

afq_subs = {};
for i = 1:length(subjects)
    afq_subs{i} = [afq_dir subjects{i} '/dti96trilin'];
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

%afq run
AFQ_run(afq_subs, afq_group)