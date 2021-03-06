#!/bin/ksh

. /home/informix/.profile
. /opt/pm/.profile

CEID=""
echo "Content-type: text/html"
echo

CEID=`echo $1 | awk '{print $1}' | awk -F ':' '{print $1}'`

DATEFMT="+%Y%m%d%H%M%S"

#write record to file
varstr="ceid="$CEID"&brand=ST"
echo ST:`date $DATEFMT`:$varstr >> /data/logs/top_history.log

# call dynamic page
$INFORMIXDIR/bin/fglgo /opt/pm/code/SHOWTOP partners_na NA ST 

echo "</body>"
echo "</html>"



