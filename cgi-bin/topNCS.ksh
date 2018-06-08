#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

CEID=""
echo "Content-type: text/html"
echo

CEID=`echo $1 | awk '{print $1}' | awk -F ':' '{print $1}'`

DATEFMT="+%Y%m%d%H%M%S"

#write record to file
varstr="ceid="$CEID"&brand=NC"
echo NC:`date $DATEFMT`:$varstr >> /data/logs/top_history.log

# call dynamic page
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/SHOWTOP partners_na NA NC 

echo "</body>"
echo "</html>"



