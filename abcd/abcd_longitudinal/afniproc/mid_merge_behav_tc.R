#check for requires packages
if(!("jsonlite" %in% rownames(installed.packages()))){
  print('installing jsonlite...')
  install.packages('jsonlite')
}
library(jsonlite)

if(!("reshape2" %in% rownames(installed.packages()))){
  print('installing reshape2...')
  install.packages('reshape2')
}
library(reshape2)

if(!("dplyr" %in% rownames(installed.packages()))){
  print('installing dplyr...')
  install.packages('dplyr')
}
library(dplyr)

#read in parameters from json arg file
jsonfile=paste(getwd(), 'args.json', sep='/')
print(jsonfile)

args=read_json(jsonfile)

subs = read.delim(args$txt, head=F) #read sublist that has complete MID fmri data.
behavPath=paste(args$out, args$timeval, 'afniproc', sep='/') # establish afniproc path.

#ROI timecourses to be concatenated to behav file
rois=c('lmid_mbnf_nacc8mm_mni.1D',
       'rmid_mbnf_nacc8mm_mni.1D',
       'bmid_mbnf_nacc8mm_mni.1D',
       'lmid_mbnf_ains8mmkg_mni.1D',
       'rmid_mbnf_ains8mmkg_mni.1D',
       'bmid_mbnf_ains8mmkg_mni.1D',
       'lmid_mbnf_mpfc8mm_mni.1D',
       'rmid_mbnf_mpfc8mm_mni.1D',
       'bmid_mbnf_mpfc8mm_mni.1D',
       'lmid_mbnf_MNI152_prob_atlas_vta_pauli_thr03_bin_short.1D',
       'rmid_mbnf_MNI152_prob_atlas_vta_pauli_thr03_bin_short.1D',
       'bmid_mbnf_MNI152_prob_atlas_vta_pauli_thr03_bin_short.1D')

#loop across subjects
for(sub in 1:nrow(subs)){
  subject = subs$V1[sub]
  print(subject)
  behav = read.csv(paste(behavPath, subject, paste(subject, '_behavior_expanded.csv', sep=''), sep='/'), head=T)
  for(roival in 1:length(rois)){
    roiname = rois[roival]
    roi = read.delim(paste(args$out, args$timeval, 'afniproc', subject, roiname,sep='/'), head=F)
    
    #using start index in behav file, pull relevant roi values
    for(row in 1:nrow(behav)){
      reltr = behav$startIndex[row] + (behav$TR[row]-1)
      behav[row,roiname] = roi$V1[reltr]
    }
    
  }
  #replace col names of rois to be sensible
  colnames(behav)[colnames(behav)=='lmid_mbnf_nacc8mm_mni.1D'] = 'l_nacc'
  colnames(behav)[colnames(behav)=='rmid_mbnf_nacc8mm_mni.1D'] = 'r_nacc'
  colnames(behav)[colnames(behav)=='bmid_mbnf_nacc8mm_mni.1D'] = 'b_nacc'
  colnames(behav)[colnames(behav)=='lmid_mbnf_ains8mmkg_mni.1D'] = 'l_ains'
  colnames(behav)[colnames(behav)=='rmid_mbnf_ains8mmkg_mni.1D'] = 'r_ains'
  colnames(behav)[colnames(behav)=='bmid_mbnf_ains8mmkg_mni.1D'] = 'b_ains'
  colnames(behav)[colnames(behav)=='lmid_mbnf_mpfc8mm_mni.1D'] = 'l_mpfc'
  colnames(behav)[colnames(behav)=='rmid_mbnf_mpfc8mm_mni.1D'] = 'r_mpfc'
  colnames(behav)[colnames(behav)=='bmid_mbnf_mpfc8mm_mni.1D'] = 'b_mpfc'
  colnames(behav)[colnames(behav)=='lmid_mbnf_MNI152_prob_atlas_vta_pauli_thr03_bin_short.1D'] = 'l_vta'
  colnames(behav)[colnames(behav)=='rmid_mbnf_MNI152_prob_atlas_vta_pauli_thr03_bin_short.1D'] = 'r_vta'
  colnames(behav)[colnames(behav)=='bmid_mbnf_MNI152_prob_atlas_vta_pauli_thr03_bin_short.1D'] = 'b_vta'
  
  #save out subject-level dataframe
  write.csv(behav, paste(args$out, args$timeval, 'afniproc', subject, paste(subject, '_behavior_tc.csv', sep=''), sep='/'), row.names = F)
  
  #convert to long form across ROIs
  behav_long=melt(behav, id.vars = c(colnames(behav)[1:23]), variable.name='roi')
  #extract hemi data as separate column
  behav_long$hem[grepl('l_', behav_long$roi)]='lh'
  behav_long$hem[grepl('r_', behav_long$roi)]='rh'
  behav_long$hem[grepl('b_', behav_long$roi)]='bh'
  #shorten roi names accordingly
  behav_long$roi=substr(behav_long$roi, 3,100)
  
  #save out subject-level long-form csv
  write.csv(behav_long, paste(behavPath, subject, paste(subject, '_behavior_tc_long.csv', sep=''), sep='/'), row.names = F)
  
  #summarize means per hem, roi, cond, trialphase
  behav_sum = behav_long %>% group_by(subject, hem, roi, mid_anticipationtype, brainstep) %>% summarize(mean_act=mean(value, na.rm=T), se_act=sd(value, na.rm=T)/sqrt(n()))
  #write out summarized data
  write.csv(behav_sum, paste(behavPath, subject, paste(subject, '_behavior_tc_sum.csv', sep=''), sep='/'), row.names = F)
  
  #summarize data as before, including hit or miss
  behav_sum_acc = behav_long %>% group_by(subject, hem, roi, mid_anticipationtype, brainstep, mid_acc) %>% summarize(mean_act=mean(value, na.rm=T), se_act=sd(value, na.rm=T)/sqrt(n()))
  #write out summarized data
  write.csv(behav_sum_acc, paste(behavPath, subject, paste(subject, '_behavior_tc_sum_acc.csv', sep=''), sep='/'), row.names = F)
  
  #reshape both summarized dataframes to wide form
  behav_sum_wide = dcast(behav_sum[, c(1:(ncol(behav_sum)-1))], subject ~ hem + roi + mid_anticipationtype + brainstep, value.var = 'mean_act')
  behav_sum_acc$mid_acc[behav_sum_acc$mid_acc==1]='hit'
  behav_sum_acc$mid_acc[behav_sum_acc$mid_acc==0]='miss'
  behav_sum_acc_wide = dcast(behav_sum_acc[, c(1:(ncol(behav_sum_acc)-1))], subject ~ hem + roi + mid_anticipationtype + brainstep + mid_acc, value.var = 'mean_act')
  
  write.csv(behav_sum_wide, paste(behavPath, subject, paste(subject, '_behavior_tc_sum_wide.csv', sep=''), sep='/'), row.names = F)
  write.csv(behav_sum_acc_wide, paste(behavPath, subject, paste(subject, '_behavior_tc_sum_acc_wide.csv', sep=''), sep='/'), row.names = F)
}

