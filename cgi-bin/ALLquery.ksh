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

if [[ $VALUE == bu_* || $VALUE == reseller ]]
then
   TAB="a"
   VAL="Y"
else
#   TAB="k"
   VAL="3"
case $VALUE in
   WS.*) TAB="k"
         VALUE=`echo $VALUE | awk -F "." '{print $2}'`
     ;;
   IM.*) TAB="l"
         VALUE=`echo $VALUE | awk -F "." '{print $2}'`
     ;;
   TI.*) TAB="m"
         VALUE=`echo $VALUE | awk -F "." '{print $2}'`
   ;;
   RA.*) TAB="n"
         VALUE=`echo $VALUE | awk -F "." '{print $2}'`
     ;;
   LO.*) TAB="o"
         VALUE=`echo $VALUE | awk -F "." '{print $2}'`
     ;;
esac
fi


 if [[ -z "$str" ]]
 then
   str=" and ("$TAB"."$VALUE" = '"$VAL"'"
 else
   str=$str" and ("$TAB"."$VALUE" = '"$VAL"'"
 fi

 if [[ $NAME == bu_* ]]
 then
   str=$str" or "$TAB"."$VALUE" = 'H'"
 fi

 str=$str" )"
done

#echo $str
echo "</html>"
env>/tmp/env.txt

$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/ADHOC2 partners_na NA IM 0 "$str"

