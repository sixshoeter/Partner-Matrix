#!/bin/ksh

. /home/informix/.profile
. /opt/pm/.profile

var1="$QUERY_STRING"
NAME=""
VALUE=""
echo "Content-type: text/html"
echo
echo "<html>"
#var1="SLevel=3&A1=skill_01&A2=&A3=&A4=&A5="
echo "VAR1:"$var1 >>/tmp/eu_var1.txt
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

 echo $var1 >> /data/logs/eu_str.log

echo "</html>"
env>/tmp/eu_env.txt

$INFORMIXDIR/bin/fglgo $HOME/code-eu/ADHOC1_EUSS partners_eu EU NC 0 "$var1"

