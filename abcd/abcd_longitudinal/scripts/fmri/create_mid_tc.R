library(dplyr)
library(stringr)

args = commandArgs(trailingOnly=T)


#read arguments from bash wrapper script
basePath=args[1]
subFiles=read.delim(args[2], head=F)

#for testing
#basePath = '/mnt/acorn/ethan/afniproc'
#subFiles = read.delim('/mnt/acorn/ethan/scripts/behav/subs.txt', head=F)

#Loop over subjects
for(sub in 1:length(subFiles)){
  
  
  #construct subject ID and timeval
  #separate long subject filename into parts
  subparts=strsplit(subFiles$V1[sub], split='_')[[1]] #ignore this weird little index thingy. Basically lets you access the array component.
  #extract subject ID, add 'sub-' to beginning to match folder name
  subID=paste('sub-', subparts[1], subparts[2], sep='')
  #extract relevant timepoint, add 'ses-' to beginning to match folder name
  #extract relevant timepoint, add 'ses-' to beginning to match folder name
  if(subparts[3]=='baseline'){
    tval=paste('ses-', subparts[3], str_to_title(subparts[4]), subparts[5], str_to_title(subparts[6]), subparts[7], sep='')
  }else{
    tval=paste('ses-', subparts[3], str_to_title(subparts[4]), str_to_title(subparts[5]), str_to_title(subparts[6]), str_to_title(subparts[7]), str_to_title(subparts[8]), subparts[9], sep='')
  }
  #construct name of modified behavior file
  behavName=paste(subID, '_behavior_expanded.csv', sep='')
  
  #construct path to modified csv file
  csvPath <- paste(basePath, subID, tval, sep='/')
  
  #Load in behavior file
  print(subID)
  csvToRead <- paste(csvPath, behavName, sep="/")

  behavior <- read.csv(csvToRead)
  
  #Load in both hemispheres data. If error, load in NA vector of equivalent length.
  #then push subject to list, along with ROIs that failed.
  #if file not present, use pre-initialized file of equal length containing NAs
  
  b_acing=data.frame(V1=rep(NA, 802))
  b_caudate=b_acing
  b_csf=b_acing
  b_dlpfc=b_acing
  b_wm=b_acing
  b_vtapbp=b_acing
  b_ains8mmmni=b_acing
  b_ains8mmkgmni=b_acing
  b_mpfc8mmmni=b_acing
  b_nacc8mmmni=b_acing
  
  l_acing=data.frame(V1=rep(NA, 802))
  l_caudate=l_acing
  l_csf=l_acing
  l_dlpfc=l_acing
  l_wm=l_acing
  l_vtapbp=l_acing
  l_ains8mmmni=l_acing
  l_ains8mmkgmni=l_acing
  l_mpfc8mmmni=l_acing
  l_nacc8mmmni=l_acing
  
  r_acing=data.frame(V1=rep(NA, 802))
  r_caudate=r_acing
  r_csf=r_acing
  r_dlpfc=r_acing
  r_wm=r_acing
  r_vtapbp=r_acing
  r_ains8mmmni=r_acing
  r_ains8mmkgmni=r_acing
  r_mpfc8mmmni=r_acing
  r_nacc8mmmni=r_acing
  
  tryCatch(
    expr={
      b_acing <- read.csv(paste(csvPath,'bmid_mbnf_acing.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with b_acing')
    }
  )
  tryCatch(
    expr={
      b_caudate <- read.csv(paste(csvPath,'bmid_mbnf_caudate.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with b_caudate')
    }
  )
  tryCatch(
    expr={
      b_csf <- read.csv(paste(csvPath,'bmid_mbnf_csf_mask.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with b_csf')
    }
  )
  tryCatch(
    expr={
      b_dlpfc <- read.csv(paste(csvPath,'bmid_mbnf_dlpfc.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with b_dlpfc')
    }
  )
  tryCatch(
    expr={
      b_wm <- read.csv(paste(csvPath,'bmid_mbnf_wm_mask.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with b_wm')
    }
  )
  tryCatch(
    expr={
      b_vtapbp <- read.csv(paste(csvPath,'bmid_mbnf_vtapbp_nihpd_short.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with b_vta10')
    }
  )
  tryCatch(
    expr={
      b_ains8mmmni <- read.csv(paste(csvPath,'bmid_mbnf_ains8mm_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with b_ains8mmmni')
    }
  )
  tryCatch(
    expr={
      b_ains8mmkgmni <- read.csv(paste(csvPath,'bmid_mbnf_ains8mmkg_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with b_ains8mmkgmni')
    }
  )
  tryCatch(
    expr={
      b_mpfc8mmmni <- read.csv(paste(csvPath,'bmid_mbnf_mpfc8mm_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with b_mpfc8mmmni')
    }
  )
  tryCatch(
    expr={
      b_nacc8mmmni <- read.csv(paste(csvPath,'bmid_mbnf_nacc8mm_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with b_nacc8mmmni')
    }
  )
  
  #Load in left hemisphere data###################################################################################################
  tryCatch(
    expr={
      l_acing <- read.csv(paste(csvPath,'lmid_mbnf_acing.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with l_acing')
    }
  )
  tryCatch(
    expr={
      l_caudate <- read.csv(paste(csvPath,'lmid_mbnf_caudate.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with l_caudate')
    }
  )
  tryCatch(
    expr={
      l_csf <- read.csv(paste(csvPath,'lmid_mbnf_csf_mask.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with l_csf')
    }
  )
  tryCatch(
    expr={
      l_dlpfc <- read.csv(paste(csvPath,'lmid_mbnf_dlpfc.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with l_dlpfc')
    }
  )
  tryCatch(
    expr={
      l_wm <- read.csv(paste(csvPath,'lmid_mbnf_wm_mask.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with l_wm')
    }
  )
  tryCatch(
    expr={
      l_vtapbp <- read.csv(paste(csvPath,'lmid_mbnf_vtapbp_nihpd_short.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with l_vta10')
    }
  )
  tryCatch(
    expr={
      l_ains8mmmni <- read.csv(paste(csvPath,'lmid_mbnf_ains8mm_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with l_ains8mmmni')
    }
  )
  tryCatch(
    expr={
      l_ains8mmkgmni <- read.csv(paste(csvPath,'lmid_mbnf_ains8mmkg_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with l_ains8mmkgmni')
    }
  )
  tryCatch(
    expr={
      l_mpfc8mmmni <- read.csv(paste(csvPath,'lmid_mbnf_mpfc8mm_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with l_mpfc8mmmni')
    }
  )
  tryCatch(
    expr={
      l_nacc8mmmni <- read.csv(paste(csvPath,'lmid_mbnf_nacc8mm_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with l_nacc8mmmni')
    }
  )
  
  #Load in right hemisphere data#################################################################################################
  tryCatch(
    expr={
      r_acing <- read.csv(paste(csvPath,'rmid_mbnf_acing.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with r_acing')
    }
  )
  tryCatch(
    expr={
      r_caudate <- read.csv(paste(csvPath,'rmid_mbnf_caudate.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with r_caudate')
    }
  )
  tryCatch(
    expr={
      r_csf <- read.csv(paste(csvPath,'rmid_mbnf_csf_mask.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with r_csf')
    }
  )
  tryCatch(
    expr={
      r_dlpfc <- read.csv(paste(csvPath,'rmid_mbnf_dlpfc.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with r_dlpfc')
    }
  )
  tryCatch(
    expr={
      r_wm <- read.csv(paste(csvPath,'rmid_mbnf_wm_mask.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with r_wm')
    }
  )
  tryCatch(
    expr={
      r_vtapbp <- read.csv(paste(csvPath,'rmid_mbnf_vtapbp_nihpd_short.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with r_vta10')
    }
  )
  tryCatch(
    expr={
      r_ains8mmmni <- read.csv(paste(csvPath,'rmid_mbnf_ains8mm_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with r_ains8mmmni')
    }
  )
  tryCatch(
    expr={
      r_ains8mmkgmni <- read.csv(paste(csvPath,'rmid_mbnf_ains8mmkg_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with r_ains8mmkgmni')
    }
  )
  tryCatch(
    expr={
      r_mpfc8mmmni <- read.csv(paste(csvPath,'rmid_mbnf_mpfc8mm_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with r_mpfc8mmmni')
    }
  )
  tryCatch(
    expr={
      r_nacc8mmmni <- read.csv(paste(csvPath,'rmid_mbnf_nacc8mm_mni.1D',sep="/"), head=F)
    },
    error=function(e){
      print('A warning has occured with r_nacc8mmmni')
    }
  )

  
  
  behavior$subID <- subID
  
  behavior$b_acing <- NA
  behavior$b_caudate <- NA
  behavior$b_csf <- NA
  behavior$b_dlpfc <- NA
  behavior$b_wm <- NA
  behavior$b_vtapbp <- NA
  behavior$b_ains8mmmni <- NA
  behavior$b_ains8mmkgmni <- NA
  behavior$b_mpfc8mmmni <- NA
  behavior$b_nacc8mmmni <- NA
  
  behavior$l_acing <- NA
  behavior$l_caudate <- NA
  behavior$l_csf <- NA
  behavior$l_dlpfc <- NA
  behavior$l_wm <- NA
  behavior$l_vtapbp <- NA
  behavior$l_ains8mmmni <- NA
  behavior$l_ains8mmkgmni <- NA
  behavior$l_mpfc8mmmni <- NA
  behavior$l_nacc8mmmni <- NA
  
  behavior$r_acing <- NA
  behavior$r_caudate <- NA
  behavior$r_csf <- NA
  behavior$r_dlpfc <- NA
  behavior$r_wm <- NA
  behavior$r_vtapbp <- NA
  behavior$r_ains8mmmni <- NA
  behavior$r_ains8mmkgmni <- NA
  behavior$r_mpfc8mmmni <- NA
  behavior$r_nacc8mmmni <- NA
  
  
  for(row in 1:nrow(behavior)){
      #Index for brain data
      brain_index <- behavior$startIndex[row] + (behavior$TR[row]-1)
      
      #fill in table
      #both
      behavior$b_acing[row] <- b_acing$V1[brain_index]
      behavior$b_caudate[row] <- b_caudate$V1[brain_index]
      behavior$b_csf[row] <- b_csf$V1[brain_index]
      behavior$b_dlpfc[row] <- b_dlpfc$V1[brain_index]
      behavior$b_wm[row] <- b_wm$V1[brain_index]
      behavior$b_vtapbp[row] <- b_vtapbp$V1[brain_index]
      behavior$b_ains8mmmni[row] <- b_ains8mmmni$V1[brain_index]
      behavior$b_ains8mmkgmni[row] <- b_ains8mmkgmni$V1[brain_index]
      behavior$b_mpfc8mmmni[row] <- b_mpfc8mmmni$V1[brain_index]
      behavior$b_nacc8mmmni[row] <- b_nacc8mmmni$V1[brain_index]
      
      #left
      behavior$l_acing[row] <- l_acing$V1[brain_index]
      behavior$l_caudate[row] <- l_caudate$V1[brain_index]
      behavior$l_csf[row] <- l_csf$V1[brain_index]
      behavior$l_dlpfc[row] <- l_dlpfc$V1[brain_index]
      behavior$l_wm[row] <- l_wm$V1[brain_index]
      behavior$l_vtapbp[row] <- l_vtapbp$V1[brain_index]
      behavior$l_ains8mmmni[row] <- l_ains8mmmni$V1[brain_index]
      behavior$l_ains8mmkgmni[row] <- l_ains8mmkgmni$V1[brain_index]
      behavior$l_mpfc8mmmni[row] <- l_mpfc8mmmni$V1[brain_index]
      behavior$l_nacc8mmmni[row] <- l_nacc8mmmni$V1[brain_index]
      
      #right
      behavior$r_acing[row] <- r_acing$V1[brain_index]
      behavior$r_caudate[row] <- r_caudate$V1[brain_index]
      behavior$r_csf[row] <- r_csf$V1[brain_index]
      behavior$r_dlpfc[row] <- r_dlpfc$V1[brain_index]
      behavior$r_wm[row] <- r_wm$V1[brain_index]
      behavior$r_vtapbp[row] <- r_vtapbp$V1[brain_index]
      behavior$r_ains8mmmni[row] <- r_ains8mmmni$V1[brain_index]
      behavior$r_ains8mmkgmni[row] <- r_ains8mmkgmni$V1[brain_index]
      behavior$r_mpfc8mmmni[row] <- r_mpfc8mmmni$V1[brain_index]
      behavior$r_nacc8mmmni[row] <- r_nacc8mmmni$V1[brain_index]
        
        
  }
  
  behavior$brainstep <- NA
  behavior <- behavior %>% relocate(brainstep, .after=TR)
  #THIS IS WHERE WE SHIFT THE BRAIN DATA TO ACCOUNT FOR HRF -> 4 artifical "beg" TRs.
  for(row in 1:nrow(behavior)){
    if(behavior$TR[row] == 1){
      behavior$brainstep[row] = "beg1"
    }else if(behavior$TR[row] == 2){
      behavior$brainstep[row] = "beg2"
    }else if(behavior$TR[row] == 3){
      behavior$brainstep[row] = "beg3"
    }else if(behavior$TR[row] == 4){
      behavior$brainstep[row] = "beg4"
    }else if(behavior$TR[row] == 5){
      behavior$brainstep[row] = "cue1"
    }else if(behavior$TR[row] == 6){
      behavior$brainstep[row] = "cue2"
    }else if(behavior$TR[row] == 7){
      behavior$brainstep[row] = "ant1"
    }else if(behavior$TR[row] == 8){
      behavior$brainstep[row] = "ant2"
    }else if(behavior$TR[row] == 9){
      behavior$brainstep[row] = "ant3"
    }else if(behavior$TR[row] == 10){
      behavior$brainstep[row] = "ant4"
    }else if(behavior$TR[row] == 11){
      behavior$brainstep[row] = "ant5"
    }else if(behavior$TR[row] == 12){
      behavior$brainstep[row] = "ant6"
    }else if(behavior$TR[row] == 13){
      behavior$brainstep[row] = "rsp1"
    }else if(behavior$TR[row] == 14){
      behavior$brainstep[row] = "rsp2"
    }else if(behavior$TR[row] == 15){
      behavior$brainstep[row] = "rsp3"
    }else if(behavior$TR[row] == 16){
      behavior$brainstep[row] = "rsp4"
    }else if(behavior$TR[row] == 17){
      behavior$brainstep[row] = "rsp5"
    }
  }
  
  #shift brain data so that whole table is consistent with max number of ant TRs. 
  index = 1
  for(trial in 1:100){ #100 trials
    #maximum number of anticipatory TRs = 7
    #First, count how many TR's are anticipation. the difference between this number and 7 will determine the brain data shift
    antCounter = behavior$antTRnum[trial*17]
    maxAnt = max(behavior$antTRnum)
    shift = maxAnt-antCounter
    #We want to move the brain data maxAnt-antCounter forward, starting just after the last true ant TR
    #So, starting from the end of each trial (to avoid overwriting problems)...
    #we want to reach back "shift" rows, grab that data, and move it forward.
    #We want to do this from TR 17 all the way back to 6 + antCounter + 1 (6 TRs before ant, however many true ant TRs, then plus 1 to grab the very next one)
    #once that's done, we want to replace the false ant TRs with NAs.
    firstTRToMove = 7 + antCounter #7 b/c beg1-4, cue1-2, then the next TR.
    if(is.na(shift)){
      print(trial)
      break
    }
    if(shift != 0){
      for(TR in 0:(17-firstTRToMove)){
        
        row = (trial*17)-TR
        
        #both
        behavior$b_acing[row] <- behavior$b_acing[row-shift]
        behavior$b_acing[row-shift] = NA
        behavior$b_caudate[row] <- behavior$b_caudate[row-shift]
        behavior$b_caudate[row-shift] = NA
        behavior$b_csf[row] <- behavior$b_csf[row-shift]
        behavior$b_csf[row-shift] = NA
        behavior$b_dlpfc[row] <- behavior$b_dlpfc[row-shift]
        behavior$b_dlpfc[row-shift] = NA
        behavior$b_wm[row] <- behavior$b_wm[row-shift]
        behavior$b_wm[row-shift] = NA
        behavior$b_vtapbp[row] <- behavior$b_vtapbp[row-shift]
        behavior$b_vtapbp[row-shift] = NA
        behavior$b_ains8mmmni[row] <- behavior$b_ains8mmmni[row-shift]
        behavior$b_ains8mmmni[row-shift] = NA
        behavior$b_ains8mmkgmni[row] <- behavior$b_ains8mmkgmni[row-shift]
        behavior$b_ains8mmkgmni[row-shift] = NA
        behavior$b_mpfc8mmmni[row] <- behavior$b_mpfc8mmmni[row-shift]
        behavior$b_mpfc8mmmni[row-shift] = NA
        behavior$b_nacc8mmmni[row] <- behavior$b_nacc8mmmni[row-shift]
        behavior$b_nacc8mmmni[row-shift] = NA
        
        #left
        behavior$l_acing[row] <- behavior$l_acing[row-shift]
        behavior$l_acing[row-shift] = NA
        behavior$l_caudate[row] <- behavior$l_caudate[row-shift]
        behavior$l_caudate[row-shift] = NA
        behavior$l_csf[row] <- behavior$l_csf[row-shift]
        behavior$l_csf[row-shift] = NA
        behavior$l_dlpfc[row] <- behavior$l_dlpfc[row-shift]
        behavior$l_dlpfc[row-shift] = NA
        behavior$l_wm[row] <- behavior$l_wm[row-shift]
        behavior$l_wm[row-shift] = NA
        behavior$l_vtapbp[row] <- behavior$l_vtapbp[row-shift]
        behavior$l_vtapbp[row-shift] = NA
        behavior$l_ains8mmmni[row] <- behavior$l_ains8mmmni[row-shift]
        behavior$l_ains8mmmni[row-shift] = NA
        behavior$l_ains8mmkgmni[row] <- behavior$l_ains8mmkgmni[row-shift]
        behavior$l_ains8mmkgmni[row-shift] = NA
        behavior$l_mpfc8mmmni[row] <- behavior$l_mpfc8mmmni[row-shift]
        behavior$l_mpfc8mmmni[row-shift] = NA
        behavior$l_nacc8mmmni[row] <- behavior$l_nacc8mmmni[row-shift]
        behavior$l_nacc8mmmni[row-shift] = NA
        
        #right
        behavior$r_acing[row] <- behavior$r_acing[row-shift]
        behavior$r_acing[row-shift] = NA
        behavior$r_caudate[row] <- behavior$r_caudate[row-shift]
        behavior$r_caudate[row-shift] = NA
        behavior$r_csf[row] <- behavior$r_csf[row-shift]
        behavior$r_csf[row-shift] = NA
        behavior$r_dlpfc[row] <- behavior$r_dlpfc[row-shift]
        behavior$r_dlpfc[row-shift] = NA
        behavior$r_wm[row] <- behavior$r_wm[row-shift]
        behavior$r_wm[row-shift] = NA
        behavior$r_vtapbp[row] <- behavior$r_vtapbp[row-shift]
        behavior$r_vtapbp[row-shift] = NA
        behavior$r_ains8mmmni[row] <- behavior$r_ains8mmmni[row-shift]
        behavior$r_ains8mmmni[row-shift] = NA
        behavior$r_ains8mmkgmni[row] <- behavior$r_ains8mmkgmni[row-shift]
        behavior$r_ains8mmkgmni[row-shift] = NA
        behavior$r_mpfc8mmmni[row] <- behavior$r_mpfc8mmmni[row-shift]
        behavior$r_mpfc8mmmni[row-shift] = NA
        behavior$r_nacc8mmmni[row] <- behavior$r_nacc8mmmni[row-shift]
        behavior$r_nacc8mmmni[row-shift] = NA
        
      }
    }
  }
  
  fileName <- paste(subID,"_mid_behavior_tc.csv",sep="")
  writePath <- paste(csvPath,fileName,sep="/")
  
  write.csv(behavior, writePath)

}

