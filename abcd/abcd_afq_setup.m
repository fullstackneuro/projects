% making afq subject dirs for AFQ_run
afq_dir = '/media/lcne/matproc/abcd/';

subjects = {'sub-NDARINVZYLV9BMB/dti95trilin'};
          
afq_subs = strcat(afq_dir, subjects);

afq_group = repmat(0,1,length(subjects));         

AFQ_run(afq_subs, afq_group)