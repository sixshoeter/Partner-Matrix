#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

var1="$QUERY_STRING"
CEID=""
VALUE=""
echo "Content-type: text/html"
echo
var2=`echo $var1 | tr "&" "\t"`

OO=`echo $var1 | tr = " "`
CEID=`echo $OO | awk '{print $2}' | awk -F '&' '{print $1}'`
YNAME=`echo $OO | awk '{print $3}'`
YNAME=`echo $YNAME | tr -s "%40" "@"`

DATEFMT="+%Y%m%d%H%M%S"

#write record to file
echo SU:$CEID:`date $DATEFMT`:$YNAME >> /data/logs/upd_history.log

# generate update page
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/nBUILDPAGESU partners_na NA SU $CEID 5 

echo "</body>"
echo "</html>"

