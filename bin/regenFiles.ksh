#!/bin/ksh

##***********************************************************************
### Copyright (c) 2013 IBM
###
### regenFiles.ksh
###  by: John M. Shoemaker, jshoe@us.ibm.com, jshoemaker1@cox.net
###      May      23, 2013 - John M. Shoemaker
###      
###      May      28, 2013 - John Shoemaker, start putting in error checking
###      August   22, 2013 - John Shoemaker, add regen of Start program
###      February 04, 2014 - John Shoemaker, check for trigger
###      February 17, 2014 - John Shoemaker, add generation of reports
###      March    31, 2014 - John Shoemaker, add eus_each files
###      December 02, 2014 - John Shoemaker, do not genreate HV and Emer pages
###      January  14, 2014 - John Shoemaker, add option for master page
###      January  30, 2015 - John Shoemaker, add Units
###      
###      
###
###
##***********************************************************************

. /home/informix/shoe/.profile


function Usage {
   echo "Usage: regenFiles.ksh -g GEO -b BRAND -i -t -m"
   echo "       where,"
   echo "          GEO is the two-character representation of the IBM Geography,"
   echo "          like NA, etc"
   echo "          BRAND is the two-character representation of the IBM Brand,"
   echo "          like WS, IM, etc"
   echo "          -t will regen only if the brands TRIGGER file is present"
   echo "          -m will regen the master page "
   echo "  Example:"
   echo "   regenFiles.ksh -g NA -b WS"
   echo " "
}

START=0
REGEN=0
REGMASTER=0

while getopts hsitmb:g: c
do
   case $c in
      b) BRAND=$OPTARG;;
      g) GEO=$OPTARG;;
      m) REGMASTER=1;;
      s) START=1;;
      t) REGEN=1;;
      h) Usage
         exit 2;;
      i) INCL=1;;
      ?) Usage
          exit 2;;
   esac
done

#export IMT=NA
B=$BRAND
#B='IM WS'

for BRAND in $B
do
TMPDIR=${HOME}/${GEO}/${BRAND}/tmp
PROD_H_DIR=${HOME}/${GEO}/${BRAND}/H
PROD_T_DIR=$TMPDIR/H
PROD_ALL_DIR=${HOME}/${GEO}/all/H

EXEC=GO.ksh
EXEC3=GOnoheader.ksh
EXEC2=GOskills.ksh
EXEC4=GOreports.ksh
export CEID="0"

case $BRAND in
   WS ) TRIGGER=$TRIGGER_WS;;
   IM ) TRIGGER=$TRIGGER_IM;;
   TI ) TRIGGER=$TRIGGER_TI;;
   RA ) TRIGGER=$TRIGGER_RA;;
   LO ) TRIGGER=$TRIGGER_LO;;
   IS ) TRIGGER=$TRIGGER_IS;;
   EM ) TRIGGER=$TRIGGER_EM;;
   SC ) TRIGGER=$TRIGGER_SC;;
   BA ) TRIGGER=$TRIGGER_BA;;
   SE ) TRIGGER=$TRIGGER_SE;;
esac

if [ $REGEN -eq 1  ]
then
   if [ ! -f $TRIGGER ]
   then
      exit 1
   else
      rm $TRIGGER
   fi
fi

case $GEO in
   'NA')
      export DB=partners_na
;;
esac

if [ ! -d $PROD_T_DIR ]
then
   echo "Creating " $PROD_T_DIR
   mkdir $PROD_T_DIR

fi

if [ ! -d $PROD_ALL_DIR ]
then
   echo "Creating " $PROD_ALL_DIR
   mkdir $PROD_ALL_DIR

fi

if [ $START -ge 1 ]
then
   echo -n "Building the INDEX(START) page ... "
   $TOOLBIN/fglgo $CODEDIR/START $DB $GEO $BRAND 0 > $HTDOCS/index.html
   echo "done"
fi

if [ $REGMASTER -eq 1  ]
then
   echo -n "Building the MASTER HOME page ... "
   $TOOLBIN/fglgo $CODEDIR/MASTER $DB $GEO "-" 0 > $PROD_ALL_DIR/master.html
   echo "done"
fi

echo -n "Building the $BRAND HOME page ... "
$TOOLBIN/fglgo $CODEDIR/HOME $DB $GEO $BRAND $CEID > $PROD_T_DIR/home.html
echo "done"

echo -n "Building the $BRAND MENU_COVERAGE page ... "
$TOOLBIN/fglgo $CODEDIR/MENU_COVERAGE $DB $GEO $BRAND 0 > $PROD_T_DIR/menu_coverage.html
echo "done"

echo -n "Building the $BRAND AUTHORIZATION page ... "
$TOOLBIN/fglgo $CODEDIR/AUTHORIZATION $DB $GEO $BRAND $CEID N > $PROD_T_DIR/authorization.html
echo "done"

#echo -n "Building the $BRAND AUTHORIZATION HPV page ... "
#$TOOLBIN/fglgo $CODEDIR/AUTHORIZATION $DB $GEO $BRAND $CEID H > $PROD_T_DIR/hvp.html
#echo "done"

#echo -n "Building the $BRAND AUTHORIZATION EMERGING page ... "
#$TOOLBIN/fglgo $CODEDIR/AUTHORIZATION $DB $GEO $BRAND $CEID E > $PROD_T_DIR/emerging.html
#echo "done"

echo -n "Building the $BRAND SKILLS page ... "
$TOOLBIN/fglgo $CODEDIR/SKILLS $DB $GEO $BRAND $CEID > $PROD_T_DIR/skills.html
echo "done"

echo -n "Building the $BRAND INDUSTRY page ... "
$TOOLBIN/fglgo $CODEDIR/INDUSTRIES $DB $GEO $BRAND $CEID > $PROD_T_DIR/industries.html
echo "done"

#echo -n "Building the $BRAND BUSINESS UNITS page ... "
#$TOOLBIN/fglgo $CODEDIR/BUSINESSUNITS $DB $GEO $BRAND $CEID > $PROD_T_DIR/businessunits.html
#echo "done"

echo -n "Building the $BRAND ENTERPRISE UNITS page ... "
$TOOLBIN/fglgo $CODEDIR/EUS $DB $GEO $BRAND $CEID > $PROD_T_DIR/eus.html
echo "done"

echo -n "Building the $BRAND BRAND COVERAGE page ... "
$TOOLBIN/fglgo $CODEDIR/COVERAGE $DB $GEO $BRAND $CEID > $PROD_T_DIR/coverage.html
echo "done"

echo -n "Building the $BRAND BRAND COVERAGE EUS (BDR) page ... "
$TOOLBIN/fglgo $CODEDIR/COVERAGE_EUS $DB $GEO $BRAND $CEID > $PROD_T_DIR/coverage_eus.html
echo "done"

echo -n "Building the $BRAND BRAND COVERAGE EUS (TSS) page ... "
$TOOLBIN/fglgo $CODEDIR/COVERAGE_EUS_TSS $DB $GEO $BRAND $CEID > $PROD_T_DIR/coverage_eus_tss.html
echo "done"

echo -n "Building the $BRAND BRAND EUS_DRIVE page ... "
$TOOLBIN/fglgo $CODEDIR/EUS_DRIVE $DB $GEO $BRAND $CEID > $HTDOCS/${BRAND}_eus_drive.html
echo "done"

echo -n "Building the $BRAND BRAND EUS_EACH pages ... "
for i in {1..25}
do
   $TOOLBIN/fglgo $CODEDIR/EUS_EACH $DB $GEO $BRAND 0 ${i} > $PROD_T_DIR/eus_${i}.html
done
echo "done"

echo -n "Building the $BRAND BRAND COVERAGE PLAN page ... "
$TOOLBIN/fglgo $CODEDIR/COVERAGE_PLAN $DB $GEO $BRAND $CEID > $PROD_T_DIR/coverage_plan.html
echo "done"

echo -n "Building the $BRAND BRAND PARTNER TYPE (byStatus) page ... "
$TOOLBIN/fglgo $CODEDIR/BYSTATUS $DB $GEO $BRAND $CEID > $PROD_T_DIR/byStatus.html
echo "done"

echo -n "Building the $BRAND BRAND FIND a PARTNER page ... "
$TOOLBIN/fglgo $CODEDIR/FINDPARTNER $DB $GEO $BRAND $CEID > $HTDOCS/query_$BRAND.html
echo "done"

echo -n "Building the $BRAND BRAND FIND a PARTNER_EUS page ... "
$TOOLBIN/fglgo $CODEDIR/FINDPARTNER_EUS $DB $GEO $BRAND $CEID > $HTDOCS/query_${BRAND}_eus.html
echo "done"


##error check the results thus far - either commit these files and continue 
##  or stop

## check sizes of files
## if any are empty, abort them all and stop processing
for nf in $PROD_T_DIR/*.html
do
## if any are too small, abort them all and stop processing
   LC=`cat $nf | wc -l`
#   if [ $LC -le 75 ]
   if [ $LC -le 1 ]
   then
      echo "File is too small: "$nf
      echo "Aborting - leaving files in "$PROD_T_DIR
#      exit 2
   fi
done

## copy existing files (just in case need them) and replace with new
echo "Shifting new pages into place"
DATEFMT='+%Y%m%d'
OLDDIR=$TMPDIR/OLD_H-`date $DATEFMT`

if [ ! -d $OLDDIR ]
then
   mkdir $OLDDIR
fi

cp $PROD_H_DIR/*.html $OLDDIR

## move new files into place
mv $PROD_T_DIR/*.html $PROD_H_DIR


##
## Build the individual Partner pages, based on their CEIDs
##

echo -n "Building the list of $BRAND CEIDs... "
CEID_FILE=$HOME/${GEO}/${BRAND}/P/ceid.lst

$TOOLBIN/fglgo $CODEDIR/LOOPPAGES $DB $GEO $BRAND $CEID > $CEID_FILE
echo "done"

## only continue if there is a list of CEIDs
LC=`cat $CEID_FILE | wc -l`
#if [ $LC -le 75 ]
if [ $LC -le 1 ]
then
  echo "File is too small: "$CEID_FILE
  exit 2
fi


echo -n "Building the individual $BRAND Partner Pages ... "
echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC
echo "export HOME="$HOME >> $TMPDIR/$EXEC
echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC
echo "export DB="$DB >> $TMPDIR/$EXEC
echo "export GEO="$GEO >> $TMPDIR/$EXEC
echo "export BRAND="$BRAND >> $TMPDIR/$EXEC
echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC
awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/nBUILDPAGES $DB $GEO $BRAND " $1 " "1" > $HOME/${GEO}/${BRAND}/P/"$1".html "}' $CEID_FILE >> $TMPDIR/$EXEC
ksh $TMPDIR/$EXEC
echo "done"

echo -n "Building the individual $BRAND Partner Pages (no header) ... "
echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC3
echo "export HOME="$HOME >> $TMPDIR/$EXEC3
echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC3
echo "export DB="$DB >> $TMPDIR/$EXEC3
echo "export GEO="$GEO >> $TMPDIR/$EXEC3
echo "export BRAND="$BRAND >> $TMPDIR/$EXEC3
echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC3
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC3
awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/nBUILDPAGES $DB $GEO $BRAND " $1 " "0" > $HOME/${GEO}/${BRAND}/P/"$1"-nh.html "}' $CEID_FILE >> $TMPDIR/$EXEC3
ksh $TMPDIR/$EXEC3
echo "done"

echo -n "Building the individual $BRAND Partner Pages (SECRET PAGES)... "
echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC
echo "export HOME="$HOME >> $TMPDIR/$EXEC
echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC
echo "export DB="$DB >> $TMPDIR/$EXEC
echo "export GEO="$GEO >> $TMPDIR/$EXEC
echo "export BRAND="$BRAND >> $TMPDIR/$EXEC
echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC
awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/nBUILDPAGES $DB $GEO $BRAND " $1 " "2" > $HOME/${GEO}/${BRAND}/P/"$1"-sec.html "}' $CEID_FILE >> $TMPDIR/$EXEC
ksh $TMPDIR/$EXEC
echo "done"

#echo -n "Building the individual $BRAND Partner SKILLS Pages ... "
#echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC2
#echo "export HOME="$HOME >> $TMPDIR/$EXEC2
#echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC2
#echo "export DB="$DB >> $TMPDIR/$EXEC2
#echo "export GEO="$GEO >> $TMPDIR/$EXEC2
#echo "export BRAND="$BRAND >> $TMPDIR/$EXEC2
#echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC2
#echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC2
#awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/SHOWSKILLS $DB $GEO $BRAND " $1 " > $HOME/${GEO}/${BRAND}/P/"$1"-skills.html "}' $CEID_FILE >> $TMPDIR/$EXEC2
#ksh $TMPDIR/$EXEC2
#echo "done"

echo -n "Building the individual $BRAND Partner VAP Pages ... "
echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC2
echo "export HOME="$HOME >> $TMPDIR/$EXEC2
echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC2
echo "export DB="$DB >> $TMPDIR/$EXEC2
echo "export GEO="$GEO >> $TMPDIR/$EXEC2
echo "export BRAND="$BRAND >> $TMPDIR/$EXEC2
echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC2
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC2
awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/SHOWVAP $DB $GEO $BRAND " $1 " > $HOME/${GEO}/${BRAND}/P/"$1"-vap.html "}' $CEID_FILE >> $TMPDIR/$EXEC2
ksh $TMPDIR/$EXEC2
echo "done"

echo -n "Building the individual $BRAND Partner REPORT Pages ... "
echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC4
echo "export HOME="$HOME >> $TMPDIR/$EXEC4
echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC4
echo "export DB="$DB >> $TMPDIR/$EXEC4
echo "export GEO="$GEO >> $TMPDIR/$EXEC4
echo "export BRAND="$BRAND >> $TMPDIR/$EXEC4
echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC4
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC4
echo "export REPORT_NAME=partner-"$BRAND >> $TMPDIR/$EXEC4
awk '{print "${TOOLBIN}/sacego -q ${REPORTDIR}/${REPORT_NAME} " $1 " > $HOME/${GEO}/${BRAND}/R/"$1"-report.rtf "}' $CEID_FILE >> $TMPDIR/$EXEC4
ksh $TMPDIR/$EXEC4
echo "done"

echo "done for "$BRAND

done
