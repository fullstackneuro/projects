library(stringr)

#Top level
args = commandArgs(trailingOnly=T)

#read arguments from bash wrapper script
basePath=args[1]
bidsPath=args[2]
subFiles=read.delim(args[3], head=F)$V1


#for testing
#basePath='/mnt/acorn/ethan/afniproc'
#bidsPath='/mnt/acorn/ethan/bids'
#subFiles=read.delim('/mnt/acorn/ethan/scripts/behav/subs.txt', head=F)$V1


for(file in 1:length(subFiles)){
  
  #subPathParts = strsplit(subFiles[file], "/")
  #subName = subPathParts[[1]][8]
  #csvName = paste(subName, "_behavior.csv", sep="")
  
  subparts=strsplit(subFiles[file], split='_')[[1]] #ignore this weird little index thingy. Basically lets you access the array component.
  #extract subject ID, add 'sub-' to beginning to match folder name
  subID=paste('sub-', subparts[1], subparts[2], sep='')
  #extract relevant timepoint, add 'ses-' to beginning to match folder name
  #extract relevant timepoint, add 'ses-' to beginning to match folder name
  if(subparts[3]=='baseline'){
    tval=paste('ses-', subparts[3], str_to_title(subparts[4]), subparts[5], str_to_title(subparts[6]), subparts[7], sep='')
  }else{
    tval=paste('ses-', subparts[3], str_to_title(subparts[4]), str_to_title(subparts[5]), str_to_title(subparts[6]), str_to_title(subparts[7]), str_to_title(subparts[8]), subparts[9], sep='')
  }
  
  csvName=gsub('zip','csv',subFiles[file])
  csvFile=paste(bidsPath, subID, tval, 'behav', csvName, sep='/')
  event1 = paste(basePath, subID, tval, 'mid_event_file1.csv', sep='/')
  event2 = paste(basePath, subID, tval, 'mid_event_file2.csv', sep='/') 
  
  
  #afniproc dir contains modified event files. Use these for timing info
  print(paste("Working on subject", subID, sep=" "))
  behav = read.csv(csvFile, head=T)
  e1 = read.csv(event1, head=T)
  e2 = read.csv(event2, head=T)
  
  #add block column, combine e1 and e2 into one events file
  e1$block = 1
  e2$block = 2
  
  events=rbind(e1, e2)

  #each trial is double represented in events table (antic + feedback). Subset this down to antic only, since this
  #represents true start times
  events_antic = subset(events, !(grepl("feedback", events$trial_type)))
  
  #for each row in this data, compute startTR
  events_antic$startTR = floor(events_antic$onset/.8) + 1
  
  #we cut off lead in in our processed data. They did not. First start TR will be offset by 10. Subtract so that it is 1.
  events_antic$startTR = events_antic$startTR - 10
  
  #we kept lead-out for padding when creating timecourses. Total mid file is 806 TRs long. 2 runs of 403. So add 403 to block 2.
  events_antic$startTR[events_antic$block==2] = events_antic$startTR[events_antic$block==2] + 401
  
  #no time shift necessary here. Hemodynamic lag accounted for by 3dDeconvolve
  
  #Will want these regressor 1D files...
  #period vectors (cue = 1, ant = 1, long ant (any after 3) = 1, target = 1, and resp = 1)
  # large gain (+1) vs. neutral (-1)
  # large loss (-1) vs. neutral (+1)
  # large gain X hit (+1 hit, -1 miss)
  # large loss X hit (+1 hit, -1 miss)
  
  #for hits vs. miss, will need behavior. mid_acc column.

  #start with period regressors:
  cueVec = vector(mode="numeric", length=802) #number of TRs in whole session
  antVec = cueVec
  longAntVec = cueVec
  targVec = cueVec
  outVec = cueVec
  
  #iterate through events, take start index of every trial.
  #cue was 2 TRs long (floored)

  print('generating period regressor vectors...')
  for(row in 1:nrow(events_antic)){
    #print(row)
    #cue first (startTR and startTR+1)
    cueVec[(events_antic$startTR[row]):(events_antic$startTR[row]+1)] = 1
    #ant vec (startTR+2 -> startTR + 1 + 3) #first 3 ant TRs every trial has in common
    antVec[(events_antic$startTR[row]+2):(events_antic$startTR[row]+4)] = 1 #+2, +3, and +4 (3 TRs)
    #longAntVec - anything in excess of the first three antTRs.
    longAntVec[(events_antic$startTR[row]+5):(events_antic$startTR[row]+1+events_antic$ant_tr[row])] = 1
    #targVec - This one is trickier. target + response period was 150-500 ms total - less than 1 TR.
    #to cleanly separate from longAnt, call the TR immediately after the end of ANT the targTR.
    targVec[(events_antic$startTR[row]+2+events_antic$ant_tr[row])] = 1
    #outVec - outcome. Everything from just after target TR to end of trial. Special attention to lead out.
    if(row != 50 && row != 100){ #special attention must be paid to end of blocks
      outVec[(events_antic$startTR[row]+3+events_antic$ant_tr[row]):(events_antic$startTR[row+1]-1)] = 1
    }else{ #if end of block, hardcode outcome to be two TRs. Otherwise it counts lead-out as outcome (which is wrong)
      outVec[(events_antic$startTR[row]+3+events_antic$ant_tr[row]):(events_antic$startTR[row]+4+events_antic$ant_tr[row])] = 1
    }

  }
  
  #trialtype contrasts. 
  lgn_vec = vector(mode="numeric", length=802) #large gain (+1) v neutral (-1)
  lln_vec = lgn_vec #large loss (+1) v neutral (-1)
  lgh_vec = lgn_vec #large gain hit (+1) v miss (-1)
  llh_vec = lgn_vec #large loss hit (+1) v miss (-1)
  
  print('generating trial-type contrast vectors...')
  for(row in 1:nrow(behav)){
    #print(row)
    #first conditions vs. neutral
    if(row != 100){
      endTrial = events_antic$startTR[row+1]-1
    }else{
      endTrial = length(lgh_vec)
    }
    
    #print('cond v. neutral')
    if(behav$mid_anticipationtype[row] == "LR"){
      lgn_vec[(events_antic$startTR[row]):endTrial] = 1
    }else if(behav$mid_anticipationtype[row] == "LL"){
      lln_vec[(events_antic$startTR[row]):endTrial] = 1
    }else if(behav$mid_anticipationtype[row] == "Neutral"){
      lgn_vec[(events_antic$startTR[row]):endTrial] = -1
      lln_vec[(events_antic$startTR[row]):endTrial] = -1
    }
    
    #now hits vs. miss
    #print('hit v miss')
    if(behav$mid_anticipationtype[row] == "LR"){
      if(behav$mid_acc[row] == 1){
        lgh_vec[(events_antic$startTR[row]):endTrial] = 1
      }else{
        lgh_vec[(events_antic$startTR[row]):endTrial] = -1
      }
    }else if(behav$mid_anticipationtype[row] == "LL")
      if(behav$mid_acc[row] == 1){
        llh_vec[(events_antic$startTR[row]):endTrial] = 1
      }else{
        llh_vec[(events_antic$startTR[row]):endTrial] = -1
      }
    
    #reset lead-out TRs to 0, in case they've been set to 1.
    if(row == 50 || row == 100){
      lgn_vec[(events_antic$startTR[row]+5+events_antic$ant_tr[row]):endTrial]=0
      lln_vec[(events_antic$startTR[row]+5+events_antic$ant_tr[row]):endTrial]=0
      lgh_vec[(events_antic$startTR[row]+5+events_antic$ant_tr[row]):endTrial]=0
      llh_vec[(events_antic$startTR[row]+5+events_antic$ant_tr[row]):endTrial]=0
    }
    
  }
  
  
  #Once files are produced, write them all out as 1D files within subject directory.
  savePath = paste(basePath, subID, tval, sep='/')
  
  #Check if files already exist. If so, remove them.
  if(file.exists(paste(savePath, 'cue.1D', sep='/'))){
    file.remove(paste(savePath, 'cue.1D', sep='/'))
  }
  if(file.exists(paste(savePath, 'ant.1D', sep='/'))){
    file.remove(paste(savePath, 'ant.1D', sep='/'))
  }
  if(file.exists(paste(savePath, 'longAnt.1D', sep='/'))){
    file.remove(paste(savePath, 'longAnt.1D', sep='/'))
  }
  if(file.exists(paste(savePath, 'targ.1D', sep='/'))){
    file.remove(paste(savePath, 'targ.1D', sep='/'))
  }
  if(file.exists(paste(savePath, 'out.1D', sep='/'))){
    file.remove(paste(savePath, 'out.1D', sep='/'))
  }
  if(file.exists(paste(savePath, 'gain_neut.1D', sep='/'))){
    file.remove(paste(savePath, 'gain_neut.1D', sep='/'))
  }
  if(file.exists(paste(savePath, 'loss_neut.1D', sep='/'))){
    file.remove(paste(savePath, 'loss_neut.1D', sep='/'))
  }
  if(file.exists(paste(savePath, 'gain_hit.1D', sep='/'))){
    file.remove(paste(savePath, 'gain_hit.1D', sep='/'))
  }
  if(file.exists(paste(savePath, 'loss_hit.1D', sep='/'))){
    file.remove(paste(savePath, 'loss_hit.1D', sep='/'))
  }
  
  #write period regressors
  #cueVec
  write(cueVec, file=paste(savePath, 'cue.1D', sep='/'), ncolumns = 1, append=T, sep=" ")
  #antVec
  write(antVec, file=paste(savePath, 'ant.1D', sep='/'), ncolumns = 1, append=T, sep=" ")
  #longAntVec
  write(longAntVec, file=paste(savePath, 'longAnt.1D', sep='/'), ncolumns = 1, append=T, sep=" ")
  #targVec
  write(targVec, file=paste(savePath, 'targ.1D', sep='/'), ncolumns = 1, append=T, sep=" ")  
  #outVec
  write(outVec, file=paste(savePath, 'out.1D', sep='/'), ncolumns = 1, append=T, sep=" ")
  
  #write condition contrasts
  #large gain v neutral
  write(lgn_vec, file=paste(savePath, 'gain_neut.1D', sep='/'), ncolumns = 1, append=T, sep=" ")  
  #large loss v neutral
  write(lln_vec, file=paste(savePath, 'loss_neut.1D', sep='/'), ncolumns = 1, append=T, sep=" ")
  
  #write out hit v miss contrasts
  #large gain hit v miss
  write(lgh_vec, file=paste(savePath, 'gain_hit.1D', sep='/'), ncolumns = 1, append=T, sep=" ") 
  #large loss hit v miss
  write(llh_vec, file=paste(savePath, 'loss_hit.1D', sep='/'), ncolumns = 1, append=T, sep=" ")
  
  
  print(paste("Finished subject", subID, sep=" "))
}

