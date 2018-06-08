#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

var1="$QUERY_STRING"
CEID=""
VALUE=""
echo "Content-type: text/html"
echo
var2=`echo $var1 | tr "&" "\t"`

CEID=`echo $var1 | awk -F ':' '{print $1}'`
YNAME=`echo $var1 | awk -F ':' '{print $2}' `
YNAME=`echo $YNAME | tr -s "%20" " "`

DATEFMT="+%Y%m%d%H%M%S"
#echo "VAR1: "$var1
#echo "YNAME: "$YNAME
#echo "CEID: "$CEID
#write record to file
#echo ES:$CEID:`date $DATEFMT`:$YNAME >> /data/logs/add_history.log

# generate progress page
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/SHOWCOMPLEVEL partners_na NA ST "$CEID" "$YNAME"

echo "</body>"
echo "</html>"



