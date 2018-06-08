#!/bin/ksh

##***********************************************************************
### Copyright (c) 2014 IBM
###
### regen.ksh
###  by: John M. Shoemaker, jshoe@us.ibm.com, jshoemaker1@cox.net
###      
###      
###
###
##***********************************************************************

#. /home/informix/.profile
. /home/informix/shoe/.profile

echo "Content-type: text/html"
echo
echo "<html>"

#DATEFMT='+%Y%m%d'
#DATEFMT2="+%Y-%m-%d %H:%M:%S"
#LOGNM=regen_EM-`date $DATEFMT`.log
#LOGFILE=$LOGDIR/$LOGNM

touch $TRIGGER_BU

#echo "Starting..." >> $LOGFILE
#ksh /home/informix/shoe/bin/regenFiles.ksh -g NA -b BU
#echo "Complete..." >> $LOGFILE
#env > /tmp/env.txt

echo "<h2>Regeneration Requested </h2>"
#echo
echo "<p>"
#
echo "</html>"
#

