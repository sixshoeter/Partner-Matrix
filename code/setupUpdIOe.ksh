#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

var1="$QUERY_STRING"
CEID=""
VALUE=""
echo "Content-type: text/html"
echo
#echo "<html>"
#echo "VAR1:"$var1 "<p>"
var2=`echo $var1 | tr "&" "\t"`
#echo "VAR2:"$var2 "<p>"
#str="0"

OO=`echo $var1 | tr = " "`
CEID=`echo $OO | awk '{print $2}' | awk -F '&' '{print $1}'`
#echo "OO  : " $OO "<p>"
#echo "CEID: " $CEID "<p>"
#VALUE=`echo $OO | awk '{print $4}'`

#for VAR in `echo $var1 | tr "&" "\t"`
#do
#echo "<p>" $VAR | tr = " " | awk '{print "<p>1:"$1 "2:"$2 "3:"$3 "4:"$4}'
#   echo "VAR:" $VAR "<p>"
#   OO=`echo $VAR | tr = " "`
#   echo "OO:"$OO "<p>"
#   echo "1:"
#   NAME=`echo $OO | awk '{print $1}'`
#   echo "2:"
#   VALUE=`echo $OO | awk '{print $2}'`
#   echo $OO | awk '{print $3}'
#   echo $OO | awk '{print $4}'
#   echo $VAR | tr = " " | awk '(print $2}'
#   echo $VAR | tr = " " | awk '(print $3}'
#   echo $VAR | tr = " " | awk '(print $4}'
#   declare $NAME="$VALUE"
#	echo "<p>"
# echo "VALUE: " $VALUE "<p>"

	DATEFMT="+%Y%m%d%H%M%S"


#echo "<h2>Download Export File</h2>"
#echo
#echo "This file is a <em>comma</em> delimited file. "
#echo "<p>"
#
#echo "<a href='http://"$HOST"/exports/"$FILENM"' target='_blank'>Download Export File</a>"
#echo "<p>"
#echo "This file will remain on the server for the next 2 hours. Please download immediatly."
#
#done

#$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/UPDREC partners_na NA IO 0 "$var1"
# generate update page
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/nBUILDPAGESU partners_na NA IO $CEID 5 #> $HOME/NA/IO/P/${CEID}-upd.html
#cat $HOME/NA/IO/P/${CEID}-upd.html

#echo $str
echo "</body>"
echo "</html>"
#env>/tmp/env.txt


