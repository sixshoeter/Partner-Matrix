#!/bin/ksh

. /home/informix/.profile
. /opt/pm/.profile

CEID=""
VALUE=""
CEID=$1
DATEFMT="+%Y%m%d%H%M%S"

# update the curr_rev table
#$INFORMIXDIR/bin/isql partners_eu $QUERYDIR/q_nc.sql

#echo 2
# generate std page
#$INFORMIXDIR/bin/fglgo $HOME/code-eu/nBUILDPAGESU partners_eu EU NC $CEID 1 > $HOME/EU/NC/P/${CEID}.html
## change permissions
#chmod 666 $HOME/EU/NC/P/${CEID}.html

# generate new page
#$INFORMIXDIR/bin/fglgo $HOME/code-eu/nBUILDPAGESS partners_eu EU NC $CEID 0 > $HOME/EU/NC/S/${CEID}.html
## change permissions
#chmod 666 $HOME/EU/NC/S/${CEID}.html

# generate update page
$INFORMIXDIR/bin/fglgo $HOME/code-eu/nBUILDPAGESS partners_eu EU NC $CEID 5 #> $HOME/EU/NC/P/${CEID}-upd.html

# touch edit flag
touch $TRIGGER_EUNC
touch $UPDDONE_EUNC

