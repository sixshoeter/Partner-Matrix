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
###      February 02, 2015 - John Shoemaker, continue with Units
###      May      08, 2015 - John Shoemaker, add loop for Industry pages
###      May      22, 2015 - John Shoemaker, add Update pages
###      August   20, 2015 - John Shoemaker, add tasklist report
###      April    19, 2016 - John Shoemaker, add write_addBPXX.ksh
###      May      20, 2016 - John Shoemaker, add coverage_eus_otherU
###      September20, 2016 - John Shoemaker, check for current rebuild #189
###      November 30, 2017 - John Shoemaker, correct filter by brand for certain program
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
EXEC5=GOindusty.ksh
EXEC6=GOindustyskill.ksh
EXEC7=GOupdate.ksh
EXEC8=GOregion.ksh
EXEC9=GOregionskill.ksh
EXEC10=GOsolutions.ksh
export CEID="0"

case $BRAND in
   AU ) TRIGGER=$TRIGGER_AU;;
   SU ) TRIGGER=$TRIGGER_SU;;
   CU ) TRIGGER=$TRIGGER_CU;;
   BU ) TRIGGER=$TRIGGER_BU;;

   ES ) TRIGGER=$TRIGGER_ES;;
   ST ) TRIGGER=$TRIGGER_ST;;
   IO ) TRIGGER=$TRIGGER_IO;;
   WU ) TRIGGER=$TRIGGER_WU;;

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
      rm -f $TRIGGER
   fi
fi

## check for an active rebuild of current brand - only allow one active for current brand
REB_TRIG=${TMPDIR}/.rebuildActive-${BRAND}

if [ -f $REB_TRIG ]
then
  echo "An Active Rebuild is already in process for: "$BRAND
  exit 1
else
  echo -n "Create Active Rebuild Flag file ... "
  touch $REB_TRIG
  echo "done"
fi

## 



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

echo -n "Building the $BRAND HOMEU page ... "
$TOOLBIN/fglgo $CODEDIR/HOMEU $DB $GEO $BRAND $CEID > $PROD_T_DIR/homeU.html
echo "done"

echo -n "Building the $BRAND MENU_COVERAGEU page ... "
$TOOLBIN/fglgo $CODEDIR/MENU_COVERAGEU $DB $GEO $BRAND 0 > $PROD_T_DIR/menu_coverageU.html
echo "done"

echo -n "Building the $BRAND AUTHORIZATIONU page ... "
$TOOLBIN/fglgo $CODEDIR/AUTHORIZATIONU $DB $GEO $BRAND $CEID N > $PROD_T_DIR/authorizationU.html
echo "done"

#echo -n "Building the $BRAND AUTHORIZATION HPV page ... "
#$TOOLBIN/fglgo $CODEDIR/AUTHORIZATION $DB $GEO $BRAND $CEID H > $PROD_T_DIR/hvp.html
#echo "done"

#echo -n "Building the $BRAND AUTHORIZATION EMERGING page ... "
#$TOOLBIN/fglgo $CODEDIR/AUTHORIZATION $DB $GEO $BRAND $CEID E > $PROD_T_DIR/emerging.html
#echo "done"

echo -n "Building the $BRAND SKILLSU page ... "
$TOOLBIN/fglgo $CODEDIR/SKILLSU $DB $GEO $BRAND $CEID > $PROD_T_DIR/skillsU.html
echo "done"

echo -n "Building the $BRAND INDUSTRYU page ... "
$TOOLBIN/fglgo $CODEDIR/INDUSTRIESU $DB $GEO $BRAND $CEID > $PROD_T_DIR/industriesU.html
echo "done"

#echo -n "Building the $BRAND BUSINESS UNITS page ... "
#$TOOLBIN/fglgo $CODEDIR/BUSINESSUNITS $DB $GEO $BRAND $CEID > $PROD_T_DIR/businessunits.html
#echo "done"

#echo -n "Building the $BRAND ENTERPRISE UNITS page ... "
#$TOOLBIN/fglgo $CODEDIR/EUS $DB $GEO $BRAND $CEID > $PROD_T_DIR/eus.html
#echo "done"

echo -n "Building the $BRAND BRAND COVERAGE page ... "
$TOOLBIN/fglgo $CODEDIR/COVERAGE $DB $GEO $BRAND $CEID > $PROD_T_DIR/coverage.html
echo "done"

echo -n "Building the $BRAND BRAND COVERAGE EUSU (BDR) page ... "
$TOOLBIN/fglgo $CODEDIR/COVERAGE_EUSU $DB $GEO $BRAND $CEID > $PROD_T_DIR/coverage_eusU.html
echo "done"

echo -n "Building the $BRAND BRAND COVERAGE EUSU (TSS) page ... "
$TOOLBIN/fglgo $CODEDIR/COVERAGE_EUS_TSSU $DB $GEO $BRAND $CEID > $PROD_T_DIR/coverage_eus_tssU.html
echo "done"

if [ "X$BRAND" == "XST"  ]
then
   echo -n "Building the $BRAND BRAND COVERAGE EUSU (Other) page ... "
   $TOOLBIN/fglgo $CODEDIR/COVERAGE_EUS_OTHERU $DB $GEO $BRAND $CEID > $PROD_T_DIR/coverage_eus_otherU.html
   echo "done"
fi

echo -n "Building the $BRAND POD COVERAGE page ... "
$TOOLBIN/fglgo $CODEDIR/COVERAGE_PODU $DB $GEO $BRAND > $PROD_T_DIR/coverage_pod.html
echo "done"

echo -n "Building the $BRAND BRAND MASTER COVERAGE page ... "
$TOOLBIN/fglgo $CODEDIR/MASTER_COVERAGE $DB $GEO $BRAND $CEID > $PROD_ALL_DIR/master_coverage.html
echo "done"

echo -n "Building the $BRAND BRAND SEGMENT LEADERSU page ... "
$TOOLBIN/fglgo $CODEDIR/SEGMENT_LEADERSU $DB $GEO $BRAND $CEID > $PROD_T_DIR/segment_leadersU.html
echo "done"

#echo -n "Building the $BRAND BROWSEPARTNERU page ... "
#$TOOLBIN/fglgo $CODEDIR/BROWSEPARTNERU $DB $GEO $BRAND $CEID > $PROD_T_DIR/browsePartnerU.html
#echo "done"

#echo -n "Building the $BRAND BRAND EUS_DRIVE page ... "
#$TOOLBIN/fglgo $CODEDIR/EUS_DRIVE $DB $GEO $BRAND $CEID > $HTDOCS/${BRAND}_eus_drive.html
#echo "done"

#echo -n "Building the $BRAND BRAND EUS_EACH pages ... "
#for i in {1..25}
#do
#   $TOOLBIN/fglgo $CODEDIR/EUS_EACH $DB $GEO $BRAND 0 ${i} > $PROD_T_DIR/eus_${i}.html
#done
#echo "done"

echo -n "Building the $BRAND BRAND COVERAGE PLANU page ... "
$TOOLBIN/fglgo $CODEDIR/COVERAGE_PLANU $DB $GEO $BRAND $CEID > $PROD_T_DIR/coverage_planU.html
echo "done"

echo -n "Building the $BRAND BRAND PARTNER TYPE (byStatus) page ... "
$TOOLBIN/fglgo $CODEDIR/BYSTATUS $DB $GEO $BRAND $CEID > $PROD_T_DIR/byStatus.html
echo "done"

echo -n "Building the $BRAND BRAND FIND a PARTNER_EUSU page ... "
$TOOLBIN/fglgo $CODEDIR/FINDPARTNER_EUSU $DB $GEO $BRAND $CEID > $HTDOCS/query_${BRAND}_eus.html
echo "done"

echo -n "Building the $BRAND BRAND REVISED FIND a PARTNER_EUSU page ... "
$TOOLBIN/fglgo $CODEDIR/FINDPARTNER_EUSS $DB $GEO $BRAND $CEID > $PROD_T_DIR/find_partner.html
echo "done"

echo -n "Building the $BRAND BRAND INDUSTRY HEATMAP page ... "
$TOOLBIN/fglgo $CODEDIR/HEATMAP $DB $GEO $BRAND $CEID > $PROD_T_DIR/heatmap.html
echo "done"

echo -n "Building the $BRAND BRAND REGION HEATMAP page ... "
$TOOLBIN/fglgo $CODEDIR/REGION_HEATMAP $DB $GEO $BRAND $CEID > $PROD_T_DIR/region_heatmap.html
echo "done"

echo -n "Building the $BRAND MASS UPDATE page ... "
$TOOLBIN/fglgo $CODEDIR/MASSUPDATE $DB $GEO $BRAND > $PROD_T_DIR/massupd.html
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
## Build the individual Industry pages, based on their short names
##
echo -n "Building the list of INDUSTRIES... "
IND_FILE=$HOME/${GEO}/${BRAND}/H/industry.lst

$TOOLBIN/fglgo $CODEDIR/LOOPPAGES_IND $DB $GEO $BRAND $CEID > $IND_FILE
echo "done"

echo -n "Building the individual $BRAND INDUSTRY Partner Pages ... "
echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC5
echo "export HOME="$HOME >> $TMPDIR/$EXEC5
echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC5
echo "export DB="$DB >> $TMPDIR/$EXEC5
echo "export GEO="$GEO >> $TMPDIR/$EXEC5
echo "export BRAND="$BRAND >> $TMPDIR/$EXEC5
echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC5
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC5
awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/HEATMAP_DETAIL $DB $GEO $BRAND " 1 " "$1" > $HOME/${GEO}/${BRAND}/H/"$1".html "}' $IND_FILE >> $TMPDIR/$EXEC5
ksh $TMPDIR/$EXEC5
echo "done"


##
## Build the individual Industry/SkillCat pages, based on their short names and skill categories
##
echo -n "Building the list of INDUSTRIES... "
INDSKILL_FILE=$HOME/${GEO}/${BRAND}/H/industryskill.lst

$TOOLBIN/fglgo $CODEDIR/LOOPPAGES_INDSKILL $DB $GEO $BRAND $CEID > $INDSKILL_FILE
echo "done"

echo -n "Building the individual $BRAND INDUSTRY-SKILL Partner Pages ... "
echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC6
echo "export HOME="$HOME >> $TMPDIR/$EXEC6
echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC6
echo "export DB="$DB >> $TMPDIR/$EXEC6
echo "export GEO="$GEO >> $TMPDIR/$EXEC6
echo "export BRAND="$BRAND >> $TMPDIR/$EXEC6
echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC6
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC6
awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/HEATMAP_LIST $DB $GEO $BRAND " 1 " "$1" "$2" "$3" > $HOME/${GEO}/${BRAND}/H/"$1"-"$2"-"$3".html "}' $INDSKILL_FILE >> $TMPDIR/$EXEC6
ksh $TMPDIR/$EXEC6
echo "done"


##
## Build the individual Regional pages, based on their names
##
echo -n "Building the list of REGIONS... "
REG_FILE=$HOME/${GEO}/${BRAND}/H/region.lst

$TOOLBIN/fglgo $CODEDIR/LOOPPAGES_REG $DB $GEO $BRAND $CEID > $REG_FILE
echo "done"

echo -n "Building the individual $BRAND REGION Partner Pages ... "
echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC8
echo "export HOME="$HOME >> $TMPDIR/$EXEC8
echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC8
echo "export DB="$DB >> $TMPDIR/$EXEC8
echo "export GEO="$GEO >> $TMPDIR/$EXEC8
echo "export BRAND="$BRAND >> $TMPDIR/$EXEC8
echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC8
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC8
awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/REGION_HEATMAP_DETAIL $DB $GEO $BRAND " 1 " "$1" > $HOME/${GEO}/${BRAND}/H/"$1".html "}' $REG_FILE >> $TMPDIR/$EXEC8
ksh $TMPDIR/$EXEC8
echo "done"


##
## Build the individual Region/SkillCat pages, based on their short names and skill categories
##
echo -n "Building the list of EUS... "
REGSKILL_FILE=$HOME/${GEO}/${BRAND}/H/regionalskill.lst

$TOOLBIN/fglgo $CODEDIR/LOOPPAGES_REGSKILL $DB $GEO $BRAND $CEID > $REGSKILL_FILE
echo "done"

echo -n "Building the individual $BRAND REGION-SKILL Partner Pages ... "
echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC9
echo "export HOME="$HOME >> $TMPDIR/$EXEC9
echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC9
echo "export DB="$DB >> $TMPDIR/$EXEC9
echo "export GEO="$GEO >> $TMPDIR/$EXEC9
echo "export BRAND="$BRAND >> $TMPDIR/$EXEC9
echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC9
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC9
awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/REGION_HEATMAP_LIST $DB $GEO $BRAND " 1 " "$1" "$2" "$3" > $HOME/${GEO}/${BRAND}/H/"$1"-"$2"-"$3".html "}' $REGSKILL_FILE >> $TMPDIR/$EXEC9
ksh $TMPDIR/$EXEC9
echo "done"

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
awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/nBUILDPAGESU $DB $GEO $BRAND " $1 " "1" > $HOME/${GEO}/${BRAND}/P/"$1".html "}' $CEID_FILE >> $TMPDIR/$EXEC
ksh $TMPDIR/$EXEC
echo "done"

echo -n "Building the individual REVISED $BRAND Partner Pages ... "
echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC
echo "export HOME="$HOME >> $TMPDIR/$EXEC
echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC
echo "export DB="$DB >> $TMPDIR/$EXEC
echo "export GEO="$GEO >> $TMPDIR/$EXEC
echo "export BRAND="$BRAND >> $TMPDIR/$EXEC
echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC
awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/nBUILDPAGESS $DB $GEO $BRAND " $1 " "0" > $HOME/${GEO}/${BRAND}/S/"$1".html "}' $CEID_FILE >> $TMPDIR/$EXEC
ksh $TMPDIR/$EXEC
echo "done"

####### REMOVE STATIC BUILD OF SECRET PAGES
#echo -n "Building the individual $BRAND Partner Pages (no header) ... "
#echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC3
#echo "export HOME="$HOME >> $TMPDIR/$EXEC3
#echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC3
#echo "export DB="$DB >> $TMPDIR/$EXEC3
#echo "export GEO="$GEO >> $TMPDIR/$EXEC3
#echo "export BRAND="$BRAND >> $TMPDIR/$EXEC3
#echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC3
#echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC3
#awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/nBUILDPAGESU $DB $GEO $BRAND " $1 " "0" > $HOME/${GEO}/${BRAND}/P/"$1"-nh.html "}' $CEID_FILE >> $TMPDIR/$EXEC3
#ksh $TMPDIR/$EXEC3
#echo "done"

####### REMOVE STATIC BUILD OF SECRET PAGES
#echo -n "Building the individual $BRAND Partner Pages (SECRET PAGES)... "
#echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC
#echo "export HOME="$HOME >> $TMPDIR/$EXEC
#echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC
#echo "export DB="$DB >> $TMPDIR/$EXEC
#echo "export GEO="$GEO >> $TMPDIR/$EXEC
#echo "export BRAND="$BRAND >> $TMPDIR/$EXEC
#echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC
#echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC
#awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/nBUILDPAGESU $DB $GEO $BRAND " $1 " "2" > $HOME/${GEO}/${BRAND}/P/"$1"-sec.html "}' $CEID_FILE >> $TMPDIR/$EXEC
#ksh $TMPDIR/$EXEC
#echo "done"

#echo -n "Building the individual $BRAND Partner Pages (UPDATE PAGES)... "
#echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC7
#echo "export HOME="$HOME >> $TMPDIR/$EXEC7
#echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC7
#echo "export DB="$DB >> $TMPDIR/$EXEC7
#echo "export GEO="$GEO >> $TMPDIR/$EXEC7
#echo "export BRAND="$BRAND >> $TMPDIR/$EXEC7
#echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC7
#echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC7
#awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/nBUILDPAGESU $DB $GEO $BRAND " $1 " "5" > $HOME/${GEO}/${BRAND}/P/"$1"-upd.html "}' $CEID_FILE >> $TMPDIR/$EXEC7
#ksh $TMPDIR/$EXEC7
#echo "done"

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

#echo -n "Building the individual $BRAND Partner Solutions Pages ... "
#echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC10
#echo "export HOME="$HOME >> $TMPDIR/$EXEC10
#echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC10
#echo "export DB="$DB >> $TMPDIR/$EXEC10
#echo "export GEO="$GEO >> $TMPDIR/$EXEC10
#echo "export BRAND="$BRAND >> $TMPDIR/$EXEC10
#echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC10
#echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC10
#awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/SHOWSOLUTIONS $DB $GEO $BRAND " $1 " > $HOME/${GEO}/${BRAND}/P/"$1"-solutions.html "}' $CEID_FILE >> $TMPDIR/$EXEC10
#ksh $TMPDIR/$EXEC10
#echo "done"

#echo -n "Building the individual $BRAND Partner VAP Pages ... "
#echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC2
#echo "export HOME="$HOME >> $TMPDIR/$EXEC2
#echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC2
#echo "export DB="$DB >> $TMPDIR/$EXEC2
#echo "export GEO="$GEO >> $TMPDIR/$EXEC2
#echo "export BRAND="$BRAND >> $TMPDIR/$EXEC2
#echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC2
#echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC2
#awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/SHOWVAP $DB $GEO $BRAND " $1 " > $HOME/${GEO}/${BRAND}/P/"$1"-vap.html "}' $CEID_FILE >> $TMPDIR/$EXEC2
#ksh $TMPDIR/$EXEC2
#echo "done"

#if [ "X$BRAND" -eq "XAU"  ]
#then
#echo -n "Building the individual $BRAND Partner REPORTU Pages ... "
#echo ". /home/informix/shoe/.profile" > $TMPDIR/$EXEC4
#echo "export HOME="$HOME >> $TMPDIR/$EXEC4
#echo "export CODEDIR="$CODEDIR >> $TMPDIR/$EXEC4
#echo "export DB="$DB >> $TMPDIR/$EXEC4
#echo "export GEO="$GEO >> $TMPDIR/$EXEC4
#echo "export BRAND="$BRAND >> $TMPDIR/$EXEC4
#echo "export TOOLBIN="$TOOLBIN >> $TMPDIR/$EXEC4
#echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH >> $TMPDIR/$EXEC4
##echo "export REPORT_NAME=REPORTU" >> $TMPDIR/$EXEC4
#echo "export REPORT_NAME=REPORTU-"$BRAND >> $TMPDIR/$EXEC4
##echo "export REPORT_NAME=partner-"$BRAND >> $TMPDIR/$EXEC4
#awk '{print "${TOOLBIN}/fglgo ${CODEDIR}/${REPORT_NAME} $DB $GEO $BRAND " $1 " > $HOME/${GEO}/${BRAND}/R/"$1"-report.rtf "}' $CEID_FILE >> $TMPDIR/$EXEC4
##awk '{print "${TOOLBIN}/sacego -q ${CODEDIR}/${REPORT_NAME} $DB $GEO $BRAND " $1 " > $HOME/${GEO}/${BRAND}/R/"$1"-report.rtf "}' $CEID_FILE >> $TMPDIR/$EXEC4
#ksh $TMPDIR/$EXEC4
#echo "done"
#fi

echo -n "Building the Partner Matrix Tasklist page ... "
$TOOLBIN/fglgo $CODEDIR/TASKLIST $DB $GEO > $PROD_ALL_DIR/tasklist.html
echo "done"

echo -n "Building the addBPXX script ... "
FN=$CGIBIN/addBP${BRAND}.ksh
$BINDIR/write_addBPXX.ksh $BRAND > $FN
chmod 755 $FN
echo "done"

echo -n "Building the UpdRecXX script ... "
FN=$CGIBIN/updRec${BRAND}.ksh
$BINDIR/write_updRecXX.ksh $BRAND > $FN
chmod 755 $FN
echo "done"
echo "THIS IS THE BRAND: "$BRAND
#if [ "X$BRAND" == "XNC" ]
#then
   echo -n "Building the setupUpdSXX script ... "
   FN=$CGIBIN/setupUpdS${BRAND}.ksh
   $BINDIR/write_setupUpdSXX.ksh $BRAND > $FN
   chmod 755 $FN
   echo "done"
#else
   echo -n "Building the setupUpdXX script ... "
   FN=$CGIBIN/setupUpd${BRAND}.ksh
   $BINDIR/write_setupUpdXX.ksh $BRAND > $FN
   chmod 755 $FN
   echo "done"
#fi

echo -n "Building the updSkillsXX script ... "
FN=$CGIBIN/updSkills${BRAND}.ksh
$BINDIR/write_updSkillsXX.ksh $BRAND > $FN
chmod 755 $FN
echo "done"

echo -n "Remove Active Rebuild Flag file ... "
rm $REB_TRIG
echo "done"

echo "done for "$BRAND

done
