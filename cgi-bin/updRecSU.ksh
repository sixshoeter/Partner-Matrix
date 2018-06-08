#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

read input_line
var1="$input_line"
echo $var1 >> /data/logs/var1.log
CEID=""
VALUE=""
echo "Content-type: text/html"
echo
var2=`echo $var1 | tr "&" "\t"`

OO=`echo $var1 | tr = " "`
CEID=`echo $OO | awk '{print $3}' | awk -F '&' '{print $1}'`
DATEFMT="+%Y%m%d%H%M%S"

$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/UPDREC partners_na NA SU 0 "$var1"

echo "</html>"


