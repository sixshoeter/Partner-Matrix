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

#OO=`echo $var1 | tr = " "`
QRY=`echo $var1 | awk -F '=' '{print $2}' | tr "+" " " | sed 's/%21/!/g;s/%27/"/g;s/%2A/*/g;s/%2C/,/g;s/%3C/</g;s/%3D/=/g;s/%3E/>/g;s/%3F/?/g;s/%28/(/g;s/%29/)/g'`
#QRY=`echo $YNAME | tr -s "%40" "@"`

DATEFMT="+%Y%m%d%H%M%S"
#echo "VAR1: "$var1
#echo "QRY: "$QRY
#echo "CEID: "$CEID
#write record to file
echo IO:`date $DATEFMT`:$QRY >> /data/logs/export_fap.log

# generate progress page
#$echo $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT11C partners_na NA IO 1 "$QRY"
FILENM=export11C-`date $DATEFMT`.csv
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT11C partners_na NA IO 1 "$QRY" > $EXPORTDIR/$FILENM

echo "<h2>Download Export File</h2>"
echo
echo "This file is a <em>comma</em> delimited file. "
echo "<p>"

echo "<a href='http://"$HOST"/exports/"$FILENM"' target='_blank'>Download Export File</a>"
echo "<p>"
echo "This file will remain on the server for the next 2 hours. Please download immediatly."


echo "</body>"
echo "</html>"



