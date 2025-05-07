library(dplyr)
library(stringr)

args = commandArgs(trailingOnly=T)

#read arguments from bash wrapper script
bidsPath=args[1]
afniPath=args[2]
subs=read.delim(args[3], head=F)

#for testing
#bidsPath='/mnt/acorn/ethan/bids'
#afniPath='/mnt/acorn/ethan/afniproc'
#subs=read.delim('/mnt/acorn/ethan/scripts/behav/subs.txt', head=F)
#subs=data.frame(V1=c(subs$V1[4], subs$V1[4]))

for(sub in 1:nrow(subs)){
  
  #construct subject ID and timeval
  #separate long subject filename into parts
  subparts=strsplit(subs$V1[sub], split='_')[[1]] #ignore this weird little index thingy. Basically lets you access the array component.
  #extract subject ID, add 'sub-' to beginning to match folder name
  subName=paste('sub-', subparts[1], subparts[2], sep='')
  #extract relevant timepoint, add 'ses-' to beginning to match folder name
  tval=paste('ses-', subparts[3], str_to_title(subparts[4]), subparts[5], str_to_title(subparts[6]), subparts[7], sep='')
  #construct name of behavior file csv
  behavName=paste(subparts[1], subparts[2], subparts[3], subparts[4], subparts[5], subparts[6], subparts[7], 'mid', sep='_')
  behavName=paste(behavName, '.csv', sep='')  
  
  
  #check if afniproc subject folder even exists. Create if it doesn't
  if(!dir.exists(paste(bidsPath, subName, tval, 'behav', sep='/'))){
    print('subject afniproc directory does not exist. Creating now...')
    dir.create(paste(behavPath, subs$V1[sub], sep='/'))
  }
  
  #construct bids folder filepath. We need event files from functional data
  subfile=paste(bidsPath, subName, tval, 'func', sep='/')
  
  #find events files
  event_files=list.files(subfile, pattern='events', full.names = T) #grab event files 1 and 2 (for runs 1 and 2 of MID)
  if(length(event_files)==2){
    event_file1 = read.delim(event_files[1])[-1,]
    event_file2 = read.delim(event_files[2])[-1,]
    
    
    ###event file 1 
    if(nrow(event_file1) == 100){ #run this loop only if event file contains 50 trials (2 rows per trial, so 100 rows)
    
      event_file1$trial_dur=NA #modify event file to contain trial duration column
      event_file1$true_trial_dur=NA #modify event file to contain true_triaL_duration column
      event_file1$ant_dur=NA #modify event file to contain anticipation duration column
      event_file1$ant_tr=NA #modify event file to contain anticipation tr number column
      for(row in 1:nrow(event_file1)){
        if(grepl('antic', event_file1$trial_type[row]) && row < 99){
          event_file1$trial_dur[row]=event_file1$onset[row+2]-event_file1$onset[row] #compute trial duration
          event_file1$trial_dur[row+1]=event_file1$trial_dur[row]
        }else if(grepl('antic', event_file1$trial_type[row])){
          event_file1$trial_dur[row]=event_file1$duration[row]+event_file1$duration[row+1]
          event_file1$trial_dur[row+1]=event_file1$trial_dur[row]
        }
        
        
        #last trial will be slightly off from true time, but close. Find whichever it's closest to and round to that. (5.5-8s)
        trial_vals=c(5.5,6,6.5,7,7.5,8) #nominal trial durations. Known from experimental design.
        trial_diffs=c()
        for(t in 1:length(trial_vals)){ #compute difference from nominal duration for each trial.
          trial_diff = abs(event_file1$trial_dur[row]-trial_vals[t])
          trial_diffs=append(trial_diffs,trial_diff)
        }
        trial_index=min(trial_diffs) #find the minimum difference (will give us the index for the true trial duration)
        trial_index = match(trial_index, trial_diffs)
        true_dur = trial_vals[trial_index]
        event_file1$true_trial_dur[row]=true_dur
        event_file1$ant_dur[row] = event_file1$true_trial_dur[row]-4 #compute ant duration by subtracting off 4 known seconds from trial dur
        ##match year 1
        if(event_file1$ant_dur[row] <= 2){ #compute ant TR num from ant duration
          event_file1$ant_tr[row] = 3
        }else if(event_file1$ant_dur[row] == 2.5){
          event_file1$ant_tr[row] = 4
        }else if(event_file1$ant_dur[row] > 2.5 && event_file1$ant_dur[row] <= 3.5){
          event_file1$ant_tr[row] = 5
        }else{
          event_file1$ant_tr[row] = 6
        }
        
      } 
    }
    
    
    ###event file 2
    if(nrow(event_file2) == 100){ #do the same as above for event file 2 (block 2)
      
      event_file2$trial_dur=NA
      event_file2$true_trial_dur=NA
      event_file2$ant_dur=NA
      event_file2$ant_tr=NA
      for(row in 1:nrow(event_file2)){
        if(grepl('antic', event_file2$trial_type[row]) && row < 99){
          event_file2$trial_dur[row]=event_file2$onset[row+2]-event_file2$onset[row]
          event_file2$trial_dur[row+1]=event_file2$trial_dur[row]
        }else if(grepl('antic', event_file2$trial_type[row])){
          event_file2$trial_dur[row]=event_file2$duration[row]+event_file2$duration[row+1]
          event_file2$trial_dur[row+1]=event_file2$trial_dur[row]
        }
        
        
        #last trial will be slightly off from true time, but close. Find whichever it's closest to and round to that. (5.5-8s)
        trial_vals=c(5.5,6,6.5,7,7.5,8)
        trial_diffs=c()
        for(t in 1:length(trial_vals)){
          trial_diff = abs(event_file2$trial_dur[row]-trial_vals[t])
          trial_diffs=append(trial_diffs,trial_diff)
        }
        trial_index=min(trial_diffs)
        trial_index = match(trial_index, trial_diffs)
        true_dur = trial_vals[trial_index]
        event_file2$true_trial_dur[row]=true_dur
        event_file2$ant_dur[row] = event_file2$true_trial_dur[row]-4
        ##match year 1
        if(event_file2$ant_dur[row] <= 2){
          event_file2$ant_tr[row] = 3
        }else if(event_file2$ant_dur[row] == 2.5){
          event_file2$ant_tr[row] = 4
        }else if(event_file2$ant_dur[row] > 2.5 && event_file2$ant_dur[row] <= 3.5){
          event_file2$ant_tr[row] = 5
        }else{
          event_file2$ant_tr[row] = 6
        }
      } 
    }

    
  }
  if(nrow(event_file1) == 100 && nrow(event_file2) == 100){ #if both event files contain the expected number of rows...
    
    
    
    #use modified events files to mod behavior files
    #behavFileName=paste(gsub("sub-", "", subname), "_behavior_expanded.csv", sep="")
    #behavFilePath=paste(behavPath, gsub("sub-", "", subname), sep='/') 
    #behavFile=paste(behavFilePath, behavFileName, sep='/')

    #behav=read.csv(behavFile)#read in expanded behavior file to ammend.
    
    # Read in behavior file from bids folder
    behavFile=paste(bidsPath, subName, tval, 'behav', behavName, sep='/')
    behav_old=read.csv(behavFile, head=T)
    
    # Artificially expand behavior file to 17 TRs per trial
    behav=NA
    for(row in 1:nrow(behav_old)){
      #print(row)
      rowvals=behav_old[row,]
      for(i in 1:17){
        if(i == 1){
          expanded=rowvals
        }else{
          expanded=rbind(expanded,rowvals)
        }
      }
      expanded$TR=c(1:17)
      expanded$brainstep=NA
      if(row == 1){
        behav=expanded
      }else{
        behav=rbind(behav, expanded)
      }
    }
    
    
    # add in MID fMRI file indices, create regressor 1D files for 3dLME
    for(row in 1:(nrow(behav)/2)){ #for first 50 rows...
      trialNum=2*behav$mid_trialnum[row] #because event files have 2 rows for each trial. Take the second. Same information
      behav$antTRnum[row] = event_file1$ant_tr[trialNum] #take ant TR num from event file (computed above)
      
      behav$startIndex[row] = floor((event_file1$onset[trialNum-1]-event_file1$onset[1])/0.8) + 1 #math: subtract off time offset caused by dummy TRs. Then shift 1 TR forward.
                                                                                                  #basically, artificially shift the first trial to start at TR 1 (like in the brain data), lock everything to that.
    }
    for(row in ((nrow(behav)/2)+1):nrow(behav)){ #for rows 51-100
      trialNum=2*behav$mid_trialnum[row] #because event files have 2 rows for each trial. Take the second. Same information
      behav$antTRnum[row] = event_file2$ant_tr[trialNum]
      #behav$startIndex[row] = floor((event_file2$onset[trialNum-1])/.8) + 404
      
      behav$startIndex[row] = floor((event_file2$onset[trialNum-1]-event_file2$onset[1])/0.8) + 404 #math: subtract off time offset caused by dummy TRs. Then shift to beginning of block 2.
      
    }
    
    
    #Now that antTRnum is known, we can reverse engineer trial order, since the other trialphases have a fixed number of TRs.
    # 4 beg TRs (padding for HRF)
    # 2 cue TRs
    # Variable ant
    # Rest is rsp
    
    #also construct 1D regressor files for 3dLME
    lg_gain=rep(0,806)
    lg_loss=rep(0,806)
    sm_gain=rep(0,806)
    sm_loss=rep(0,806)
    neut=rep(0,806)
    
    cue=rep(0,806)
    ant=rep(0,806)
    rsp=rep(0,806)
    
    for(row in 1:nrow(behav_old)){
        begRow = (row-1)*17 + 1
        numeral=1
        for(i in 0:16){
          relRow=begRow+i
          trval=behav$startIndex[begRow]+i
          if(i < 4){
            stringval=paste('beg', numeral, sep='')
          }else if(i < 6){
            stringval=paste('cue', numeral-4, sep='')
            cue[trval]=1
          }else if(i < (6 + behav$antTRnum[relRow])){
            stringval=paste('ant', numeral-6, sep='')
            ant[trval]=1
          }else{
            stringval=paste('rsp', numeral-6-behav$antTRnum[relRow], sep='')
            if((numeral-6-behav$antTRnum[relRow]) < 4){ #only include first three rsp TRs. Rest are padding
              rsp[trval]=1
            }
          }
          behav$brainstep[relRow]=stringval
          
          
          #reward conditions
          if(!grepl('beg',behav$brainstep[relRow]) && (numeral-6-behav$antTRnum[relRow]) < 4){
            if(behav_old$mid_anticipationtype[row]=='LR'){
              lg_gain[trval]=1
            }else if(behav_old$mid_anticipationtype[row]=='LL'){
              lg_loss[trval]=1
            }else if(behav_old$mid_anticipationtype[row]=='SR'){
              sm_gain[trval]=1
            }else if(behav_old$mid_anticipationtype[row]=='SL'){
              sm_loss[trval]=1
            }else if(behav_old$mid_anticipationtype[row]=='Neutral'){
              neut[trval]=1
            }
          }
          
          numeral=numeral+1
        }
    }

        
    #write out everything to afniproc
    
    #1D regressors for 3dLME:
    outDir=paste(afniPath, subName, tval, sep='/')
    
    write.table(lg_gain, paste(outDir, 'lg_gain.1D', sep='/'), quote = F, eol='\n', row.names = F, col.names = F)
    write.table(lg_loss, paste(outDir, 'lg_loss.1D', sep='/'), quote = F, eol='\n', row.names = F, col.names = F)
    write.table(sm_gain, paste(outDir, 'sm_gain.1D', sep='/'), quote = F, eol='\n', row.names = F, col.names = F)
    write.table(sm_loss, paste(outDir, 'sm_loss.1D', sep='/'), quote = F, eol='\n', row.names = F, col.names = F)
    write.table(neut, paste(outDir, 'neut.1D', sep='/'), quote = F, eol='\n', row.names = F, col.names = F)
    
    write.table(cue, paste(outDir, 'cue.1D', sep='/'), quote = F, eol='\n', row.names = F, col.names = F)
    write.table(ant, paste(outDir, 'ant.1D', sep='/'), quote = F, eol='\n', row.names = F, col.names = F)
    write.table(rsp, paste(outDir, 'rsp.1D', sep='/'), quote = F, eol='\n', row.names = F, col.names = F)

    #modified event files:
    write.csv(event_file1, paste(outDir, 'mid_event_file1.csv', sep='/'), row.names=F) #write out modified event files
    write.csv(event_file2, paste(outDir, 'mid_event_file2.csv', sep='/'), row.names=F)
    
    #modified behavior file:
    write.csv(behav, paste(outDir, paste(subName, '_behavior_expanded.csv', sep=''), sep='/'), row.names=F) #write out amended behavior file.
  }
  
  
  
  
  
}
