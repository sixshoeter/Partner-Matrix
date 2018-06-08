#!/bin/ksh

##***********************************************************************
### Copyright (c) 2013 IBM
###
### load_files.ksh
###  by: John M. Shoemaker, jshoe@us.ibm.com, jshoemaker1@cox.net
###      May      23, 2013 - John M. Shoemaker
###      June	  19, 2013 - John M. Shoemaker, correct table for update
###      February 04, 2014 - John M. Shoemaker, check for trigger
###      
###      
###      
###      
###
###
##***********************************************************************

. /home/informix/shoe/.profile

INCL=0

function Usage {
   echo "Usage: load_files.ksh -g GEO -b BRAND -i"
   echo "       where,"
   echo "          GEO is the two-character representation of the IBM Geography,"
   echo "          like NA, etc"
   echo "          BRAND is the two-character representation of the IBM Brand,"
   echo "          like WS, IM, etc"
   echo "  Example:"
   echo "   load_files.ksh -g NA -b WS"
   echo " "
}

while getopts hib:g: c
do
   case $c in
      b) BRAND=$OPTARG;;
      g) GEO=$OPTARG;;
      h) Usage
         exit 2;;
      i) INCL=1;;
      ?) Usage
          exit 2;;
   esac
done

DATEFMT='+%Y%m%d'
LOGNM=load_files.`date $DATEFMT`.log
LOGFILE=$LOGDIR/$LOGNM

typeset -l lower
upper=$BRAND
lower=$upper

SFX=inp
DB=partners_$GEO

SUPPORTFILES="$RDIR/brands.$SFX $RDIR/bus.$SFX $RDIR/reps.$SFX $RDIR/skill.$SFX $RDIR/vads.$SFX"
#if [ $BRAND != "0" ]
#then

if [ -d $RDIR ]
then

## PROCESS REQUESTED BRAND FILES IF REQUESTED
   if [[ ! -z "$BRAND" ]] ; then

      for procfile in $RDIR/*$lower*.${SFX}
      do
         echo "Processing $procfile..." >> $LOGFILE
         TN=`basename $procfile .inp`
         $TOOLBIN/fglgo $CODEDIR/load_table $TN $procfile
#         echo "
#begin work; \
#delete from "$TN"; \
#load from "$procfile" delimiter '~' insert into "$TN"; \
#commit work; \
#" |isql $DB

      done

## update focus3 column to remove 0's if necessary
   case $BRAND in
      IM)
         echo "
begin work; \
update coverage_im set focus3='' where focus3='0'; \
commit work; \
" |isql $DB
         echo "
begin work; \
update coverage_im set reseller='R' where reseller is null; \
commit work; \
" |isql $DB
         ;;
      WS)
         echo "
begin work; \
update coverage_ws set focus3='' where focus3='0'; \
commit work; \
" |isql $DB
         echo "
begin work; \
update coverage_ws set reseller='R' where reseller is null; \
commit work; \
" |isql $DB
         ;;
      TI)
         echo "
begin work; \
update coverage_ti set focus3='' where focus3='0'; \
commit work; \
" |isql $DB
         echo "
begin work; \
update coverage_ti set reseller='R' where reseller is null; \
commit work; \
" |isql $DB
         ;;
      RA)
         echo "
begin work; \
update coverage_ra set focus3='' where focus3='0'; \
commit work; \
" |isql $DB
         echo "
begin work; \
update coverage_ra set reseller='R' where reseller is null; \
commit work; \
" |isql $DB
         ;;
      LO)
         echo "
begin work; \
update coverage_lo set focus3='' where focus3='0'; \
commit work; \
" |isql $DB
         echo "
begin work; \
update coverage_lo set reseller='R' where reseller is null; \
commit work; \
" |isql $DB
         ;;
   esac
   fi

fi

## PROCESS SUPPORTING FILES IF REQUESTED
if [ $INCL -eq "1" ]
then
   for procfile in $SUPPORTFILES
   do
      echo "Processing $procfile..." >> $LOGFILE
      TN=`basename $procfile .inp`
       $TOOLBIN/fglgo $CODEDIR/load_table $TN $procfile
#      echo "
#begin work; \
#delete from "$TN"; \
#load from "$procfile" delimiter '~' insert into "$TN"; \
#commit work; \
#" |isql $DB
   
   done
fi

# if no errors regen
if( true ) 
then
## regen the static files
   echo "Regenerate static HTML files ..." >> $LOGFILE
   $BINDIR/regenFiles.ksh -g $GEO -b $BRAND >> $LOGFILE
fi

echo `date` >> $LOGFILE
echo "Processing Finished." >> $LOGFILE

echo >> $LOGFILE

