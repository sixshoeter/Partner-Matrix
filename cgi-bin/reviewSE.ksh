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

#CEID=`echo $OO | awk '{print $2}' | awk -F '&' '{print $1}'`
#nvar1=`echo $var1 | awk -F '&' '{print $2"&"$3}'`
#VALUE=`echo $OO | awk '{print $3}'`

DATEFMT="+%Y%m%d%H%M%S"

#write record to file
echo SE:`date $DATEFMT`:$var1 >> /data/logs/review_history.log

# generate update page
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/REVIEW partners_na NA SE "$var1"

echo "</body>"
echo "</html>"



