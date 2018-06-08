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

FNAME=$1
SFX=inp


if [ -d $SDIR ]
then
   FPATH=$FNAME
   if [ -f $FPATH ] 
   then 
      echo -n "Processing $FPATH"
      FN=`basename $1 .csv`
      TMPFILE=$TMPDIR/${FN}.tmp
      cat $FPATH > $TMPFILE
      sed -f $CODEDIR/sed.input $TMPFILE | tr -d '\r' > $RDIR/$FN.$SFX
      rm $TMPFILE
      echo
   fi
fi
