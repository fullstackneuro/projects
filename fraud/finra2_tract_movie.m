 
myslices = [-5:20]
slices = {[0 5 0],[0 7 0],[0 9 0],[0 11 0],[0 13 0],[0 15 0],[0 17 0],[0 19 0],[0 21 0]};

pwd1 = '/media/storg/matlab_proc/wb071812_mrdiff/dti96trilin/fibers/life';
fl1 = fullfile(pwd1,'2981_10_1_aligned_trilin_csd_lmax12_rh_nacc_aseg_rh_antins_a2009s_rh_nacc_aseg_nonZero_MaskROI_rh_antins_a2009s_nonZero_MaskROI_union_wmMask_large_tracking_prob.pdb');
fg_mrt = fgRead(fl1);

pwd2 = '/media/storg/matlab_proc/wb071812_mrdiff/dti96trilin/fibers/conTrack/clean_post';
fl2 = fullfile(pwd2,'scored_fg_rh_antins_nacc_clean_post_140515.mat');
fg_con = fgRead(fl2);
                
ti = niftiRead('/media/storg/matlab_proc/wb071812_mrdiff/wb071812_t1_acpc.nii.gz');

fgh = figure('position',[100 200 1000 900]);
mbaDisplayBrainSlice(ti,[1 0 0])
hold on
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