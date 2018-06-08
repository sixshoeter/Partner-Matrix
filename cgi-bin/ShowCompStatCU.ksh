#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

read input_line
var1="$input_line"
#var1="$QUERY_STRING"
CEID=""
VALUE=""
echo "Content-type: text/html"
echo
var2=`echo $var1 | tr "&" "\t"`

OO=`echo $var1 | tr = " "`
YNAME=`echo $OO | awk '{print $2}' | awk -F '&' '{print $1}'`
YNAME=`echo $YNAME | tr -s "%40" "@"`
CEID=`echo $OO | awk '{print $3}' | awk -F '&' '{print $1}'`

DATEFMT="+%Y%m%d%H%M%S"
#echo "VAR1: "$var1
#echo "YNAME: "$YNAME
#echo "CEID: "$CEID
#write record to file
#echo ES:$CEID:`date $DATEFMT`:$YNAME >> /data/logs/add_history.log

# generate progress page
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/SHOWCOMPLEVEL partners_na NA CU "$CEID" "$YNAME"

echo "</body>"
echo "</html>"



