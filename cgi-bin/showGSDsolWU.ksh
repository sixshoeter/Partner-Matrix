#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

CEID=""
VALUE=""
echo "Content-type: text/html"
echo
echo "<html>"
CEID=`echo $1 | awk '{print $1}' | awk -F ':' '{print $1}'`
CC=`echo $@ | awk '{print $0}' | awk -F ':' '{print $2 $3 $4 $5 $6 $7 $8 $9}'`

#VALUE=`echo $OO | awk '{print $4}'`

DATEFMT="+%Y%m%d%H%M%S"

#echo 2
# call dynamic page
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/SHOWGSD partners_na NA WU $CEID "$CC" 

#echo $str
#echo "</html>"
#env>/tmp/env.txt


