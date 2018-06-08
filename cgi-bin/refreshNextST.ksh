#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

CEID=""
VALUE=""
#echo "Content-type: text/html"
#echo
#echo "<html>"
CEID=$1
#CEID=`echo $OO | awk '{print $3}' | awk -F '&' '{print $1}'`
#VALUE=`echo $OO | awk '{print $4}'`
#env > /tmp/procNextST.env
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
#	echo "CEID: " $CEID "<p>"
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

#echo 2
# generate secret page
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/nBUILDPAGESU partners_na NA ST $CEID 2 > $HOME/NA/ST/P/${CEID}-sec.html
## change permissions
chmod 666 $HOME/NA/ST/P/${CEID}-sec.html

# generate std page
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/nBUILDPAGESU partners_na NA ST $CEID 1 #> $HOME/NA/ST/P/${CEID}.html
## change permissions
chmod 666 $HOME/NA/ST/P/${CEID}.html

# touch edit flag
touch $TRIGGER_ST

#echo $str
#echo "</html>"
#env>/tmp/env.txt


