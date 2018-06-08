#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

var1="$QUERY_STRING"
NAME=""
VALUE=""
echo "Content-type: text/html"
echo
echo "<html>"
#var1="SLevel=3&A1=skill_01&A2=&A3=&A4=&A5="
echo "VAR1:"$var1 >>/tmp/var3.txt
#var2=`echo $var1 | tr "&" "\t"`
#echo "VAR2:"$var2 "<p>" >> /tmp/var3.txt
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
# echo "NAME : " $NAME "<br>"
# echo "VALUE: " $VALUE "<br>"
# echo "str  : " $str "<br>"
# echo "SLevel: " $SLevel "<p>"

# if [[ $NAME == SLevel ]]
# then
#   echo 'Skill Level:'$VALUE > /tmp/jj.txt
# VAL=$VALUE
# fi

 done

# echo $str >> /data/logs/str.log

echo "</html>"
env>/tmp/env.txt

$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/ADHOC1_EUSS partners_na NA SU 0 "$var1"

