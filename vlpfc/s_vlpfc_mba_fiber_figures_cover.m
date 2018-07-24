%save plot for all fibergroups of every subject

baseDir = '/media/storg/matproc';
figuresDir = '/media/storg/matproc/figures/mididti';

subjects = {'al151016','bb160402','bp160213','cs160214','jc160320','jc160321','jg151121', ...
            'jv151030','jw160316','pk160319','ps151001','rb160407','rf160313','zl150930'};
%cs160214, bk032113
subjects = {'ml061013'};
isubj=1
        
for isubj = 1:length(subjects)
    
    %build subject directories
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti96trilin/fibers/mrtrix');
    %mpfcDir   = fullfile(subDir, 'dti96trilin/fibers/conTrack/frontostriatal');
    mpfcDir   = fullfile(subDir, 'dti96trilin/fibers/conTrack/mpfcnacc');

    %build file names
    t1File      = fullfile(subDir, [subjects{isubj} '_t1_acpc.nii.gz']);
    %rVlpfcStnFile = fullfile(mrtrixDir, 'clean_rh_frontorb_stn.mat');
    %rPresmaStnFile = fullfile(mrtrixDir, 'clean_rh_presma_stn.mat');
    %rMpfcNAccFile = fullfile(mpfcDir, 'clean_rh_mpfc_nacc.mat');
    rInsulaFile = fullfile(mrtrixDir, 'clean_rh_antshortins_nacc.mat');
    rVlpfcFile = fullfile(mrtrixDir, 'clean_rh_frontorb_shortins.mat');

    %load t1
    ti        = niftiRead(t1File);
    %read fiber groups
    %rvlpfcstn = fgRead(rVlpfcStnFile);
    %rpresmastn = fgRead(rPresmaStnFile);
    %rmpfcnacc = fgRead(rMpfcNAccFile);
    rinsula    = fgRead(rInsulaFile);
    rvlpfc     = fgRead(rVlpfcFile);
    
    %create right hemisphere plot
    lfgh = figure('position',[100 200 1000 900]);
    mbaDisplayBrainSlice(ti,[3 0 0])
    hold on
    mbaDisplayBrainSlice(ti,[0 5 0])
    mbaDisplayBrainSlice(ti,[0 0 -10])
    %[lfh, llh] = mbaDisplayConnectome(rvlpfcstn.fibers,lfgh,[0.98,0.57,0.45],'single',[],[],.3);
    %delete(llh);
    %[lfh, llh] = mbaDisplayConnectome(rpresmastn.fibers,lfgh,[.48,0.62,0.78],'single',[],[],.3);
    %delete(llh);
    %[lfh, llh] = mbaDisplayConnectome(rmpfcnacc.fibers,lfgh,[0.7,0.98,0.98],'single',[],[],.3);
    %delete(llh);
    [lfh, llh] = mbaDisplayConnectome(rinsula.fibers,lfgh,[0.7,0.4,0.4],'single',[],[],0.3);
    delete(llh);
    [lfh, llh] = mbaDisplayConnectome(rvlpfc.fibers,lfgh,[0.7,0.58,0.73],'single',[],[],0.3);
    delete(llh);
    view(174,2);
    axis([3 75 -20 90 -10 90]);
    llh = lightangle(150,10);
    %save figure
    feSavefig(lfh,'figName',[subjects{isubj} '_cover_cor1'],'figDir',figuresDir,'figType','jpg')

    clear lfh
    
end


