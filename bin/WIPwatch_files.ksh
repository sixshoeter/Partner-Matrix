#!/bin/ksh

##***********************************************************************
### Copyright (c) 2013 IBM
###
### watch_files.ksh
###  by: John M. Shoemaker, jshoe@us.ibm.com, jshoemaker1@cox.net
###      May      23, 2013 - John M. Shoemaker
###      June     18, 2013 - John M. Shoemaker, determine brand in files
###                             and touch a brand-specific trigger file
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

##    determine brand
      FILECNT=`echo $i | grep "_ws-" | wc -l`
      if [ $FILECNT -gt 0 ]
      then

##       write to trigger file
         echo "Write to trigger file ... "$TRIGGER_WS >> $LOGFILE
         echo $i >> $TRIGGER_WS
      else
         FILECNT=`echo $i | grep "_im-" | wc -l`
         if [ $FILECNT -gt 0 ]
         then
##          write to trigger file
            echo "Write to trigger file ... "$TRIGGER_IM >> $LOGFILE
            echo $i >> $TRIGGER_IM
         fi
      fi
   fi
echo >> $LOGFILE

done


