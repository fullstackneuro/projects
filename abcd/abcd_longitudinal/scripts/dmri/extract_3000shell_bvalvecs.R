
oldw <- getOption("warn")
options(warn = -1) #when reading in the bval and bvec files, it throws warnings because there's a final delimiter
#                   without a next character. Suppress so it doesn't fill your console with useless warning messages

args = commandArgs(trailingOnly=T) # read in arguments from bash script

projpath=args[1] #first argument is the filepath for the raw bval and bvec files
sublist=read.delim(args[2], head=F, sep='\n')$V1 #second argument is the textfile containing subjects to run


#uncomment for testing:
projpath='/mnt/acorn/ethan/bids'
sublist='/mnt/acorn/ethan/scripts/dmri/subs.txt'
sublist=read.delim(sublist, head=F, sep='\n')$V1


#loop across subjects in textfile
for(sub in 1:length(sublist)){
  
  #separate long subject filename into parts
  subparts=strsplit(sublist[sub], split='_')[[1]] #ignore this weird little index thingy. Basically lets you access the array component.
  #extract subject ID, add 'sub-' to beginning to match folder name
  subname=paste('sub-', subparts[1], sep='')
  #extract relevant timepoint, add 'ses-' to beginning to match folder name
  tval=paste('ses-', subparts[2], sep='')
  #construct path to subject dwi data from components
  subdir=paste(projpath, subname, tval, 'dwi', sep='/')
  #list all files under subject dwi directory. Will include bval and bvec files
  subfiles=list.files(subdir, full.names = T)
  #if there are any files at all...
  if(length(subfiles > 0)){
    print(subname) #print out the subject ID so you know who you're running
    r1 = subfiles[grepl('run-01', subfiles)] #create subset of run 1 files
    r2 = subfiles[grepl('run-02', subfiles)] #create subset of run 2 files (note: not all subjects have r2. Depends on scanner)
    
    if(length(r1) != 0){ #if subject has run 1 files (this should be everyone, theoretically)...
      print('run1') #print out the run you're working on
      bval1_filename = r1[grepl('bval', r1)] #pick out the run 1 bval file
      bvec1_filename = r1[grepl('bvec', r1)] #pick out the run 1 bvec file
      
      bval1 = data.frame(V1=t(read.delim(bval1_filename, sep = ' ', head=F))) #read in the run 1 bval file
      bval1=na.omit(bval1) #omit NA lines
      
      bvec1 = data.frame(V1=t(read.delim(bvec1_filename, sep = ' ', head=F))) #read in the run 1 bvec file
      bvec1=na.omit(bvec1) #omit NA lines
      
      rows_to_keep1 = c() #create vector containing indices for the rows we want (i.e., b0 and b3000 volumes)
      for(row in 1:nrow(bval1)){ #loop through all rows in run 1 bval file
        if(bval1$V1[row] == 0 || bval1$V1[row] == 3000){ #if the value of that row is either 0 or 3000...
          rows_to_keep1 = append(rows_to_keep1, row-1) #...then append it to rows to keep for run 1. Subtract 1 b/c brain data is zero indexed
        }
      }
      
      rows2keep1 = t(rows_to_keep1) #transpose rows to keep for run 1 so it's vertical
      write.table(rows2keep1, file=paste(subdir, 'shell3000_run1.txt', sep='/'), append=F, quote=F, sep=",",
                  col.names=F, row.names=F) #write out these indices for use when extracting relevant volumes from nifti file
      
      new_bval1 = t(bval1[rows_to_keep1+1,]) #create new bval file, only including 0 and 3000 shell data
      new_bvec1 = t(bvec1[rows_to_keep1+1,]) #create new bvec file, only including vectors associated with 0 and 3000 shell data
      
      write.table(new_bval1, file=paste(subdir, 'bval3000_run1.bval', sep='/'), append=F, quote=F, sep=" ",
                  eol = '\n', col.names=F, row.names=F) #write out the new bval file
      
      write.table(new_bvec1, file=paste(subdir, 'bvec3000_run1.bvec', sep='/'), append=F, quote=F, sep=" ",
                  eol = '\n', col.names=F, row.names=F) #write out hte new bvec file
      
    }
    
    if(length(r2) != 0){ #literally the same thing as above, just for run 2. Not all subjects will have run 2.
      print('run2')
      bval2_filename = r2[grepl('bval', r2)]
      bvec2_filename = r2[grepl('bvec', r2)]
      
      bval2 = data.frame(V1=t(read.delim(bval2_filename, sep = ' ', head=F)))
      bval2=na.omit(bval2)
      
      bvec2 = data.frame(V1=t(read.delim(bvec2_filename, sep = ' ', head=F)))
      bvec2=na.omit(bvec2)
      
      rows_to_keep2 = c()
      for(row in 1:nrow(bval2)){
        if(bval2$V1[row] == 0 || bval2$V1[row] == 3000){
          rows_to_keep2 = append(rows_to_keep2, row-1)
        }
      }
      
      rows2keep2 = t(rows_to_keep2)
      write.table(rows2keep2, file=paste(subdir, 'shell3000_run2.txt', sep='/'), append=F, quote=F, sep=",",
                  col.names=F, row.names=F)
      
      new_bval2 = t(bval2[rows_to_keep2+1,])
      new_bvec2 = t(bvec2[rows_to_keep2+1,])
      
      write.table(new_bval2, file=paste(subdir, 'bval3000_run2.bval', sep='/'), append=F, quote=F, sep=" ",
                  eol = '\n', col.names=F, row.names=F)
      
      write.table(new_bvec2, file=paste(subdir, 'bvec3000_run2.bvec', sep='/'), append=F, quote=F, sep=" ",
                  eol = '\n', col.names=F, row.names=F)
      
      
      #earlier saving was just for data providence in case we need to reconstruct things later. Here is where we save out final products.
      #in the case of run 2, concatenate runs 1 and 2 together. When we process the brain data, we join the runs. Save out.
      new_bval=t(c(bval1[rows_to_keep1+1,], bval2[rows_to_keep2+1,]))
      new_bvec=t(rbind(bvec1[rows_to_keep1+1,], bvec2[rows_to_keep2+1,]))
      
      write.table(new_bval, file=paste(subdir, paste(subname, '3000shell.bval', sep='_'), sep='/'), append=F, quote=F, sep=" ",
                  eol = '\n', col.names=F, row.names=F)
      
      write.table(new_bvec, file=paste(subdir, paste(subname, '3000shell.bvec', sep='_'), sep='/'), append=F, quote=F, sep=" ",
                  eol = '\n', col.names=F, row.names=F)
      
      
    }else{ #run 1 was the only run.Just save out run 1 stuff as final.
      write.table(new_bval1, file=paste(subdir, paste(subname, '3000shell.bval', sep='_'), sep='/'), append=F, quote=F, sep=" ",
                  eol = '\n', col.names=F, row.names=F)
      
      write.table(new_bvec1, file=paste(subdir, paste(subname, '3000shell.bvec', sep='_'), sep='/'), append=F, quote=F, sep=" ",
                  eol = '\n', col.names=F, row.names=F)
    }
  }
}

options(warn = oldw) #re-enable warnings after
