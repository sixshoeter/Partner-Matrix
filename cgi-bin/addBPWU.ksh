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
YNAME=`echo $OO | awk '{print $2}' | awk -F '&' '{print $1}'`
YNAME=`echo $YNAME | tr -s "%40" "@"`
CEID=`echo $OO | awk '{print $3}' | awk -F '&' '{print $1}'`
nvar1=`echo $var1 | awk -F '&' '{print $2"&"$3}'`
VALUE=`echo $OO | awk '{print $4}'`

DATEFMT="+%Y%m%d%H%M%S"

#write record to file
echo WU:$CEID:`date $DATEFMT`:$YNAME >> /data/logs/add_history.log

# generate update page
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/ADDBP partners_na NA WU "$nvar1"

echo "</body>"
echo "</html>"



