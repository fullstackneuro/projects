#read in parameters from json arg file
jsonfile=paste(getwd(), 'args.json', sep='/')
print(jsonfile)

args=read_json(jsonfile)

subs = read.delim(args$txt, head=F) #read sublist that has complete MID fmri data.
behavPath=paste(args$out, args$timeval, 'afniproc', sep='/') # establish afniproc path.

trs=c('beg1','beg2','beg3','beg4','cue1','cue2','ant1','ant2','ant3','ant4','ant5','ant6','rsp1','rsp2','rsp3','rsp4','rsp5','rsp6','rsp7','rsp8')
rois=c('vta','mpfc','ains','nacc')
conds=c('LL','SL','LR','SR','Neutral')
hems=c('lh','rh','bh')
accvals=c('hit','miss')

bulk=NA
bulk_acc=NA

for(sub in 1:nrow(subs)){
  subject=subs$V1[sub]
  print(subject)
  
  #read in subject wide-form dataframes
  wide_name=paste(behavPath, subject, paste(subject, '_behavior_tc_sum_wide.csv', sep=''), sep='/')
  wide_acc_name=paste(behavPath, subject, paste(subject, '_behavior_tc_sum_acc_wide.csv', sep=''), sep='/')
  
  wide=read.csv(wide_name, head=T)
  wide_acc=read.csv(wide_acc_name, head=T)
  
  for(hem in 1:length(hems)){
    for(roi in 1:length(rois)){
      for(cond in 1:length(conds)){
        for(tr in 1:length(trs)){
          for(acc in 1:length(accvals)){
            colname = paste(hems[hem], rois[roi], conds[cond], trs[tr], accvals[acc], sep="_")
            if(!(colname %in% colnames(wide_acc))){
              wide_acc[,colname]=NA
            }
          }
        }
      }
    }
  }
  
  if(sub == 1){
    bulk=wide
    bulk_acc=wide_acc
  }else{
    bulk=rbind(bulk,wide)
    bulk_acc=rbind(bulk_acc,wide_acc)
  }
  
  
}


#write out wide-form cross-subject data
write.csv(bulk, paste(behavPath, 'mid_tc_wide.csv', sep='/'), row.names=F)
write.csv(bulk_acc, paste(behavPath, 'mid_tc_acc_wide.csv', sep='/'), row.names=F)

#convert both to long form, save
bulk_long=melt(bulk, id.vars = 'subject')
bulk_long$hem[grepl('lh_', bulk_long$variable)]='lh'
bulk_long$hem[grepl('rh_', bulk_long$variable)]='rh'
bulk_long$hem[grepl('bh_', bulk_long$variable)]='bh'
bulk_long$roi[grepl('nacc', bulk_long$variable)]='nacc'
bulk_long$roi[grepl('vta', bulk_long$variable)]='vta'
bulk_long$roi[grepl('ains', bulk_long$variable)]='ains'
bulk_long$roi[grepl('mpfc', bulk_long$variable)]='mpfc'
bulk_long$roi[grepl('nacc', bulk_long$variable)]='nacc'
bulk_long$tr[grepl('beg1', bulk_long$variable)]='beg1'
bulk_long$tr[grepl('beg2', bulk_long$variable)]='beg2'
bulk_long$tr[grepl('beg3', bulk_long$variable)]='beg3'
bulk_long$tr[grepl('beg4', bulk_long$variable)]='beg4'
bulk_long$tr[grepl('cue1', bulk_long$variable)]='cue1'
bulk_long$tr[grepl('cue2', bulk_long$variable)]='cue2'
bulk_long$tr[grepl('ant1', bulk_long$variable)]='ant1'
bulk_long$tr[grepl('ant2', bulk_long$variable)]='ant2'
bulk_long$tr[grepl('ant3', bulk_long$variable)]='ant3'
bulk_long$tr[grepl('ant4', bulk_long$variable)]='ant4'
bulk_long$tr[grepl('ant5', bulk_long$variable)]='ant5'
bulk_long$tr[grepl('ant6', bulk_long$variable)]='ant6'
bulk_long$tr[grepl('rsp1', bulk_long$variable)]='rsp1'
bulk_long$tr[grepl('rsp2', bulk_long$variable)]='rsp2'
bulk_long$tr[grepl('rsp3', bulk_long$variable)]='rsp3'
bulk_long$tr[grepl('rsp4', bulk_long$variable)]='rsp4'
bulk_long$tr[grepl('rsp5', bulk_long$variable)]='rsp5'
bulk_long$tr[grepl('rsp6', bulk_long$variable)]='rsp6'
bulk_long$tr[grepl('rsp7', bulk_long$variable)]='rsp7'
bulk_long$tr[grepl('rsp8', bulk_long$variable)]='rsp8'


#convert both to long form, save
bulk_acc_long=melt(bulk_acc, id.vars = 'subject')
bulk_acc_long$hem[grepl('lh_', bulk_acc_long$variable)]='lh'
bulk_acc_long$hem[grepl('rh_', bulk_acc_long$variable)]='rh'
bulk_acc_long$hem[grepl('bh_', bulk_acc_long$variable)]='bh'
bulk_acc_long$roi[grepl('nacc', bulk_acc_long$variable)]='nacc'
bulk_acc_long$roi[grepl('vta', bulk_acc_long$variable)]='vta'
bulk_acc_long$roi[grepl('ains', bulk_acc_long$variable)]='ains'
bulk_acc_long$roi[grepl('mpfc', bulk_acc_long$variable)]='mpfc'
bulk_acc_long$roi[grepl('nacc', bulk_acc_long$variable)]='nacc'
bulk_acc_long$tr[grepl('beg1', bulk_acc_long$variable)]='beg1'
bulk_acc_long$tr[grepl('beg2', bulk_acc_long$variable)]='beg2'
bulk_acc_long$tr[grepl('beg3', bulk_acc_long$variable)]='beg3'
bulk_acc_long$tr[grepl('beg4', bulk_acc_long$variable)]='beg4'
bulk_acc_long$tr[grepl('cue1', bulk_acc_long$variable)]='cue1'
bulk_acc_long$tr[grepl('cue2', bulk_acc_long$variable)]='cue2'
bulk_acc_long$tr[grepl('ant1', bulk_acc_long$variable)]='ant1'
bulk_acc_long$tr[grepl('ant2', bulk_acc_long$variable)]='ant2'
bulk_acc_long$tr[grepl('ant3', bulk_acc_long$variable)]='ant3'
bulk_acc_long$tr[grepl('ant4', bulk_acc_long$variable)]='ant4'
bulk_acc_long$tr[grepl('ant5', bulk_acc_long$variable)]='ant5'
bulk_acc_long$tr[grepl('ant6', bulk_acc_long$variable)]='ant6'
bulk_acc_long$tr[grepl('rsp1', bulk_acc_long$variable)]='rsp1'
bulk_acc_long$tr[grepl('rsp2', bulk_acc_long$variable)]='rsp2'
bulk_acc_long$tr[grepl('rsp3', bulk_acc_long$variable)]='rsp3'
bulk_acc_long$tr[grepl('rsp4', bulk_acc_long$variable)]='rsp4'
bulk_acc_long$tr[grepl('rsp5', bulk_acc_long$variable)]='rsp5'
bulk_acc_long$tr[grepl('rsp6', bulk_acc_long$variable)]='rsp6'
bulk_acc_long$tr[grepl('rsp7', bulk_acc_long$variable)]='rsp7'
bulk_acc_long$tr[grepl('rsp8', bulk_acc_long$variable)]='rsp8'
bulk_acc_long$acc[grepl('hit', bulk_acc_long$variable)]='hit'
bulk_acc_long$acc[grepl('miss', bulk_acc_long$variable)]='miss'

bulk_long=bulk_long[,-2]
bulk_acc_long=bulk_acc_long[,-2]



#write out long-form cross-subject data
write.csv(bulk_long, paste(behavPath, 'mid_tc_long.csv', sep='/'), row.names=F)
write.csv(bulk_acc_long, paste(behavPath, 'mid_tc_acc_long.csv', sep='/'), row.names=F)

