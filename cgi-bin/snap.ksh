#!/bin/ksh

##***********************************************************************
### Copyright (c) 2013 IBM
###
### snap.ksh
###  by: John M. Shoemaker, jshoe@us.ibm.com, jshoemaker1@cox.net
### August  31, 2015 John Shoemaker, added denaproject
### June    13, 2016 John Shoemaker, exclude /data/IBM
###      
###
###
##***********************************************************************

. /home/informix/.profile
. /home/informix/shoe/.profile

echo "Content-type: text/html"
echo
echo "<html>"

cd /home/informix
# dbexport -ss -d partners_na 

DATEFMT='+%Y%m%d'
DATEFMT2="+%Y-%m-%d %H:%M:%S"
LOGNM=shoe-`date $DATEFMT`.tar
LOGFILE=$ALTEXPORT/backup/$LOGNM
LINKFILE=$EXPORTDIR/$LOGNM

## unload database if possible
#/home/informix/shoe/bin/root_dbexport.ksh


tar cf $LOGFILE --exclude=*.tar --exclude='data/IBM' shoe /data denaproject
ln -s $LOGFILE $LINKFILE

#!/bin/ksh

echo "<h2>Download Export File</h2>"
echo
echo "This file is a <em>tar</em> file. "
echo "<p>"

echo "<a href='http://"$HOST"/exports/"$LOGNM"' target='_blank'>Download Export File</a>"
echo "<p>"
echo "This file will remain on the server for the next 2 hours. Please download immediatly."

echo "</html>"


