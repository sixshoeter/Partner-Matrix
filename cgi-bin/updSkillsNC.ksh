#!/bin/ksh

. /home/informix/.profile
. /opt/pm/.profile

read input_line
var1="$input_line"

NAME=""
VALUE=""
echo "Content-type: text/html"
echo
echo "<html>"
var2=`echo $var1 | tr "&" "\t"`

OO=`echo $var2 | tr = " "`
CEID=`echo $OO | awk '{print $2}'`


for VAR in `echo $var1 | tr "&" "\t"`
do
   OO=`echo $VAR | tr = " "`
   NAME=`echo $OO | awk '{print $1}'`
   VALUE=`echo $OO | awk '{print $2}'`
 echo "<p>"

DATEFMT="+%Y%m%d%H%M%S"

done

#write record to file
echo NC:$CEID:`date $DATEFMT`:$YNAME >> /data/logs/eu-updskill_history.log

$INFORMIXDIR/bin/fglgo /opt/pm/code-eu/UPDSKILLS partners_eu EU NC 0 "$var1"

echo "</html>"


