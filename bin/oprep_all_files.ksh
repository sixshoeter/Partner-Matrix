#!/bin/ksh

##***********************************************************************
### Copyright (c) 2013 IBM
###
### prep_all_files.ksh
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

function Usage {
   echo "Usage: prep_all_files.ksh -g GEO -b BRAND"
   echo "       where,"
   echo "          GEO is the two-character representation of the IBM Geography,"
   echo "          like NA, etc)"
   echo "          BRAND is the two-character representation of the IBM Brand,"
   echo "          like WS, IM, etc)"
   echo "  Example:"
   echo "   prep_all_files.ksh -g NA -b WS"
   echo " "
}

while getopts hb:g: c
do
   case $c in
      g) GEO=$OPTARG;;
      b) BRAND=$OPTARG;;
      h) Usage
         exit 2;;
      ?) Usage
          exit 2;;
   esac
done

DATEFMT='+%Y%m%d'
LOGNM=prep_all_files.`date $DATEFMT`.log
LOGFILE=$LOGDIR/$LOGNM
HISNM=prep_history.`date $DATEFMT`.csv
HISTFILE=$LOGDIR/$HISNM

DATEFMT2="+%Y-%m-%d %H:%M:%S"

if [[ -z "$BRAND" ]] ; then
   Usage
   exit 2
fi


if [ -f $TRIGGER ]
then
   echo "Trigger File ("$TRIGGER") does exist, proceeding" >> $LOGFILE
   echo "GEO: "$GEO "BRAND: "$BRAND >> $LOGFILE
else
   exit
fi

echo `date` >> $LOGFILE

typeset -l lower
upper=$BRAND
lower=$upper


for fn in reps.csv vads.csv bus.csv brands.csv skill.csv industry.csv BPTV.csv
do
   if [ -f $SDIR/$fn ]
   then
      echo "Processing ... "$fn >> $LOGFILE
      echo $GEO"~"$BRAND"~"`date '+%Y-%m-%d %H:%M:%S'`"~"$fn"~"`cat $SDIR/$fn|wc -l` >> $HISTFILE
      cat $SDIR/$fn | tail +2 > $TMPDIR/$fn
      $BINDIR/prep_file.ksh $TMPDIR/$fn
      rm $TMPDIR/$fn
   fi
done

#combined and process multiple files
FILE=coverage_${lower}.csv
FILE1=$SDIR/$FILE
echo "Processing ... "$FILE >> $LOGFILE
echo $GEO"~"$BRAND"~`date '+%Y-%m-%d %H:%M:%S'`~"$FILE"~"`cat $FILE1|wc -l` >> $HISTFILE
if [ -f $FILE1 ] 
then
   rm $FILE1
   touch $FILE1
fi

for i in $SDIR/coverage_${lower}-*.csv
do
   cat $i | tail +2 >> $FILE1
done

$BINDIR/prep_file.ksh $FILE1

FILE=success_${lower}.csv
FILE3=$SDIR/$FILE
echo "Processing ... "$FILE >> $LOGFILE
echo $GEO"~"$BRAND"~`date '+%Y-%m-%d %H:%M:%S'`~"$FILE"~"`cat $FILE3|wc -l` >> $HISTFILE
if [ -f $FILE3 ] 
then
   rm $FILE3
   touch $FILE3
fi

for i in $SDIR/success_${lower}-*.csv
do
   cat $i | tail +2 >> $FILE3
done

$BINDIR/prep_file.ksh $FILE3

FILE=skills_${lower}.csv
FILE4=$SDIR/$FILE
echo "Processing ... "$FILE >> $LOGFILE
echo $GEO"~"$BRAND"~`date '+%Y-%m-%d %H:%M:%S'`~"$FILE"~"`cat $FILE4|wc -l` >> $HISTFILE
if [ -f $FILE4 ] 
then
   rm $FILE4
   touch $FILE4
fi

for i in $SDIR/skills_${lower}-*.csv
do
   cat $i | tail +2 >> $FILE4
done

$BINDIR/prep_file.ksh $FILE4

## load files
echo "Launch load_file program .. " >> $LOGFILE
$BINDIR/load_files.ksh -g $GEO -b $BRAND

## remove the trigger file
if [ -f $TRIGGER ]
then
   echo "Removing trigger file "$TRIGGER >> $LOGFILE
   rm $TRIGGER
fi


echo `date` >> $LOGFILE
echo "Processing Finished." >> $LOGFILE

echo >> $LOGFILE

