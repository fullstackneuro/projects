function s_dtiInit_across_subjects
%
% This function loads a series of subjects and performs dtiInit for each
% one of them
%

datapath = '/media/storg/matproc';
subjects = {'yw083014_hardi1','yw083014_hardi2','yw083014_hardi3'};       
            %{
            'ab071412','bc050913','bk032113','bk053012','ch101612', ...
            'cs050813','dc050213','dp092612','ds080712','ec081912', ...
            'en062813','fg092712','gr051513','hg101012','hm062513', ...
            'jh042913','jl071912','jo081312','jt062413','jw072512', ...
            'kr030113','lc052213','lf052813','lw061713','md072512', ...
            'mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713', ...
            'pw061113','ra053013','rb073112','rb082212','sd040313', ...
            'sh010813','sl080912','sn061213','sp061313','tr101312', ...
            'tw062113','vv060313','wb071812' 
            %}
        
        
for isubj = 1:length(subjects)
    % Build the file names for dwi, bvecs/bvals
    %dwiPath = dir(fullfile(datapath,subjects{iSbj},'*DTI*'));
    dwiPath = fullfile(datapath,subjects{isubj},'raw');
    dwiFile = dir(fullfile(dwiPath,'*.nii.gz'));
    %dwiFile = fullfile(datapath,subjects{iSbj},dwiFile.name);
    %dwiBvec = [dwiFile(1:end-6),'bvec'];
    %dwiBval = [dwiFile(1:end-6),'bval'];
    t1Path = dir(fullfile(datapath,subjects{isubj},'*t1_acpc.nii.gz'));
    t1File = fullfile(datapath,subjects{isubj},t1Path.name);

    cd(fullfile(dwiPath))
    dwiParams = dtiInitParams;
    dwiParams.dwOutMm = [2, 2, 2];
    dtiInit(dwiFile.name, t1File, dwiParams);
end
