#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

var1="$QUERY_STRING"
NAME=""
VALUE=""
echo "Content-type: text/html"
echo
echo "<html>"
#echo "VAR1:"$var1 "<p>"
var2=`echo $var1 | tr "&" "\t"`
#echo "VAR2:"$var2 "<p>"
#str="0"

for VAR in `echo $var1 | tr "&" "\t"`
do
#echo "<p>" $VAR | tr = " " | awk '{print "<p>1:"$1 "2:"$2 "3:"$3 "4:"$4}'
#   echo "VAR:" $VAR "<p>"
   OO=`echo $VAR | tr = " "`
#   echo "OO:"$OO "<p>"
#   echo "1:"
   NAME=`echo $OO | awk '{print $1}'`
#   echo "2:"
   VALUE=`echo $OO | awk '{print $2}'`
#   echo $OO | awk '{print $3}'
#   echo $OO | awk '{print $4}'
#   echo $VAR | tr = " " | awk '(print $2}'
#   echo $VAR | tr = " " | awk '(print $3}'
#   echo $VAR | tr = " " | awk '(print $4}'
#   declare $NAME="$VALUE"
 echo "<p>"
# echo "NAME: " $NAME "<p>"
# echo "VALUE: " $VALUE "<p>"

DATEFMT="+%Y%m%d%H%M%S"

case $VALUE in
   ex_01)
      FILENM=export1-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT1U partners_na NA CU 0 > $EXPORTDIR/$FILENM
 	;;
   ex_02)
      FILENM=export2-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT2 partners_na NA CU 0 > $EXPORTDIR/$FILENM

 	;;
   ex_03)
      FILENM=export3-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT3 partners_na NA CU 0 > $EXPORTDIR/$FILENM

 	;;
   ex_05)
      FILENM=export5-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT5 partners_na NA CU 0 > $EXPORTDIR/$FILENM

 	;;
   ex_06)
      FILENM=export6-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT6 partners_na NA CU 0 > $EXPORTDIR/$FILENM

 	;;
   ex_07)
      FILENM=export7-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT7U partners_na NA CU 0 > $EXPORTDIR/$FILENM

 	;;
   ex_08)
      FILENM=export8-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT8U partners_na NA CU 0 > $EXPORTDIR/$FILENM

 	;;

   ex_09)
      FILENM=export9-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT9 partners_na NA CU 0 > $EXPORTDIR/$FILENM

 	;;

   ex_10)
      FILENM=export10-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT10 partners_na NA CU 0 > $EXPORTDIR/$FILENM

 	;;

   ex_11)
      FILENM=export11-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT11U partners_na NA CU 0 > $EXPORTDIR/$FILENM

 	;;
   ex_15)
      FILENM=export15-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT15 partners_na NA CU 0 > $EXPORTDIR/$FILENM
 	;;

   ex_16)
      FILENM=export16-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT16 partners_na NA CU 0 > $EXPORTDIR/$FILENM
 	;;

   ex_17)
      FILENM=export17-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT17 partners_na NA CU 0 > $EXPORTDIR/$FILENM
 	;;

   ex_18)
      FILENM=export18-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT18 partners_na NA CU 0 > $EXPORTDIR/$FILENM
 	;;

   ex_19)
      FILENM=export19-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT19 partners_na NA CU 0 > $EXPORTDIR/$FILENM
 	;;

   ex_20)
      FILENM=export20-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT20 partners_na NA CU  > $EXPORTDIR/$FILENM
        ;;

   ex_21)
      FILENM=export21-`date $DATEFMT`.csv
      $INFORMIXDIR/bin/fglgo /home/informix/shoe/code/EXPORT21 partners_na NA CU  > $EXPORTDIR/$FILENM
        ;;

esac

echo "<h2>Download Export File</h2>"
echo
echo "This file is a <em>comma</em> delimited file. "
echo "<p>"

echo "<a href='http://"$HOST"/exports/"$FILENM"' target='_blank'>Download Export File</a>"
echo "<p>"
echo "This file will remain on the server for the next 2 hours. Please download immediatly."

done

#echo $str
echo "</html>"
#env>/tmp/env.txt


