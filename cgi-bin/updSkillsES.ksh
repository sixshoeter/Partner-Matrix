#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

read input_line
var1="$input_line"

NAME=""
VALUE=""
echo "Content-type: text/html"
echo
echo "<html>"
var2=`echo $var1 | tr "&" "\t"`

for VAR in `echo $var1 | tr "&" "\t"`
do
   OO=`echo $VAR | tr = " "`
   NAME=`echo $OO | awk '{print $1}'`
   VALUE=`echo $OO | awk '{print $2}'`
 echo "<p>"

DATEFMT="+%Y%m%d%H%M%S"

done

#write record to file
echo ES:$CEID:`date $DATEFMT`:$YNAME >> /data/logs/updskill_history.log

$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/UPDSKILLS partners_na NA ES 0 "$var1"

echo "</html>"


