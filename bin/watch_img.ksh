#!/bin/ksh

##***********************************************************************
### Copyright (c) 2013 IBM
###
### watch_jpg.ksh
###  by: John M. Shoemaker, jshoe@us.ibm.com, jshoemaker1@cox.net
###      October  12, 2017 - John M. Shoemaker, create, #272
###      
###      
###      
###
###
##***********************************************************************

. /home/informix/shoe/.profile

LOGFILE=$LOGDIR/ftp.log

for i in $FTPDIR/*.jpg
do
## write header to file
   if [ -f $i ]
   then
##    move file
      echo `date` " Moving ..."$i >> $LOGFILE
      mv $i $IMGDIR

   fi

done


