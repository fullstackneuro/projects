 
myslices = [-5:20]
slices = {[0 5 0],[0 7 0],[0 9 0],[0 11 0],[0 13 0],[0 15 0],[0 17 0],[0 19 0],[0 21 0]};

subjects= {'ab071412','ds080712','en062813','gr051513','hm062513', 'jw072512','na060213','sp061313','tr101312', 'vv060313', 'wb071812'};

subjects = 'ab071412';        
baseDir = '/media/storg/matlab_proc/';
subjectDir = [subjects '_mrdiff'];
subjectRefImg = [subjects '_t1_acpc.nii.gz'];
dtFile = fullfile(baseDir, subjectDir, '/dti96trilin/dt6.mat');
refImg = fullfile(baseDir, subjectDir, subjectRefImg);
fibersFolder = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/life/');

cd(fibersFolder);
fg_pdb = ls('*curvrad1*.pdb');
fg_pdb = str(fg_pdb);
fg_fullpath = [fibersFolder fg_pdb];
fga = fgRead(fg_pdb);

pwd1 = '/media/storg/matlab_proc/wb071812_mrdiff/dti96trilin/fibers/life';
fl1 = fullfile(pwd1,'2981_10_1_aligned_trilin_csd_lmax12_rh_nacc_aseg_rh_antins_a2009s_rh_nacc_aseg_nonZero_MaskROI_rh_antins_a2009s_nonZero_MaskROI_union_wmMask_large_tracking_prob.pdb');
fg_mrt = fgRead(fl1);       
ti = niftiRead(refImg);

fgh = figure('position',[100 200 1000 900]);
mbaDisplayBrainSlice(ti,[0 1 0])
hold on
[fh, lh] = mbaDisplayConnectome(fga.fibers,fgh,[200 200 100],'single',[],[],.1);

for i = 1:length(slices)
    ah = mbaDisplayBrainSlice(ti,slices{i});
    [fh, lh] = mbaDisplayConnectome(fg_con.fibers,fgh,[.7 .6 .2],'single',[],[],.1);
    delete(lh);
    %[fh, lh] = mbaDisplayConnectome(fg_mrt.fibers,fgh,[.6 .2 .7],'single',[],[],.1);
    % set(gcf,'position',[100 200 1000 900])
    delete(lh)
    lh = light;
    view(0,0)
    drawnow
    F(i) = getframe(fgh);
%     f = warndlg('Close to advance to the next slice.');
    if ~(i == length(slices))
        %         waitfor(f);
        delete(ah);
    end

end

movie(F,3)
movie2avi(F, 'test.avi')