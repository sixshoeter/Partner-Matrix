#!/bin/ksh

##***********************************************************************
### Copyright (c) 2013 IBM
###
### watch_files.ksh
###  by: John M. Shoemaker, jshoe@us.ibm.com, jshoemaker1@cox.net
###      May      23, 2013 - John M. Shoemaker
###      
###      
###      
###      
###
###
##***********************************************************************

. /home/informix/shoe/.profile

LOGFILE=$LOGDIR/ftp.log

for i in $FTPDIR/*.csv
do
## write header to file
   echo `date` >> $LOGFILE

   if [ -f $i ]
   then
##    move file
      echo "Moving ..."$i >> $LOGFILE
      mv $i $RAWDIR

##    write to trigger file
      echo "Write to trigger file ... "$TRIGGER >> $LOGFILE
      echo $i >> $TRIGGER
   fi
echo >> $LOGFILE

done


