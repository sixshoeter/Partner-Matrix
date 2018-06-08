#!/bin/ksh

. /opt/pm/.profile

#############################
####     STORAGE
#############################

$INFORMIXDIR/bin/isql partners_na $QUERYDIR/q_st.sql

#############################
####     SOCIAL  -  ES
#############################

$INFORMIXDIR/bin/isql partners_na $QUERYDIR/q_es.sql

#############################
####     SECURITY  -  SE
#############################

$INFORMIXDIR/bin/isql partners_na $QUERYDIR/q_se.sql

#############################
####     IoT  -  IO
#############################

$INFORMIXDIR/bin/isql partners_na $QUERYDIR/q_io.sql

#############################
####     COMMERCE  -  BU
#############################

$INFORMIXDIR/bin/isql partners_na $QUERYDIR/q_bu.sql

#############################
####     NEW CLOUD (NC)
#############################

$INFORMIXDIR/bin/isql partners_na $QUERYDIR/q_nc.sql


#############################
