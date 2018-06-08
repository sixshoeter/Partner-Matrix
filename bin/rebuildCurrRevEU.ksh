#!/bin/ksh

. /home/informix/.profile
. /opt/pm/.profile

BRAND=""
BRAND=$1

# update the curr_rev table if needed

if [ -f $UPDDONE_EUNC ]
then
   $INFORMIXDIR/bin/isql partners_eu $QUERYDIR/q_nc.sql
   rm $UPDDONE_EUNC
fi

