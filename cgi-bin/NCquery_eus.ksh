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
echo "VAR2:"$var2 "<p>" >> /tmp/var2.txt
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
# echo "SLevel: " $SLevel "<p>"

if [[ $NAME == SLevel ]]
then
#   echo 'Skill Level:'$VALUE > /tmp/jj.txt
   VAL=$VALUE
fi

if [[ $VALUE == eu_* || $VALUE == reseller || $NAME == hunt || $NAME == comm || $NAME == dfm || $NAME == partwell || $NAME == ind_* ]]
then
   TAB="a"
   VAL="Y"
   INC="1"
   FCHAR=`echo $VALUE | cut -c1-1`
   NCHAR=$(($FCHAR - $INC))
else
   if [[ $NAME != SLevel ]]
    then
#   VAL="3"
   if [[ $NAME == N1-* ]]
   then
      TAB="k"
   else
      if [[ $NAME == N2-* ]]
      then
         TAB="l"
      else
         if [[ $NAME == N3-* ]]
         then
            TAB="m"
         else
            if [[ $NAME == N4-* ]]
            then
               TAB="c"
            else
               if [[ $NAME == N5-* ]]
               then
                  TAB="d"
               else
                  if [[ $NAME == AG-* ]]
                  then
                     TAB="b"
                  else
                     if [[ $NAME == N6-* ]]
                     then
                        TAB="t"
                     else
                        if [[ $NAME == N7-* ]]
                        then
                           TAB="u"
                        else
                           TAB="k"
                        fi
                     fi
                  fi
               fi
            fi
         fi
      fi
   fi
   fi
fi

# echo "NAME: " $NAME "<p>"
# echo "VALUE: " $VALUE "<p>"

if [[ $NAME == vad ]]
then
   if [[ $VALUE == na ]]
   then
      ;
   else
     if [[ -z "$str" ]]
     then
        str=" and (a."$NAME"='"$VALUE"')"
     else
        str=$str" and (a."$NAME"='"$VALUE"')"
     fi
   fi
else

if [[ $NAME == desc ]]
then
   if [[ $VALUE == "" ]]
   then
      ;
   else
     if [[ -z "$str" ]]
     then
        str=" and (a."$NAME" matches '*"$VALUE"*')"
     else
        str=$str" and (a."$NAME" matches '*"$VALUE"*')"
     fi
   fi
else


   if [[ $NAME != SLevel ]]
      then
       if [[ -z "$str" ]]
       then
          if [[ $VALUE == eu_* ]]
          then
             str=" and ("$TAB"."$VALUE" = '"$VAL"'"
          else
             if [[ $NAME == ind_* ]]
             then
                if [[ $VALUE == "" ]]
                then
                   ;
                else
                   if [[ $FCHAR == 1 ]]
                   then
                      str=$str" and ("$TAB"."$NAME" = '"$FCHAR"' or "$TAB"."$NAME" = '"$VAL"'"
                   else
                      str=$str" and ("$TAB"."$NAME" > '"$NCHAR"' and "$TAB"."$NAME" != '"$VAL"'"
                   fi
                fi
             else
                if [[ $NAME == hunt || $NAME == comm || $NAME == dfm || $NAME == partwell || $NAME == ind ]]
                then
                   str=" and ("$TAB"."$VALUE" = '"$VAL"'"
                else
                   str=" and ("$TAB"."$VALUE" >= '"$VAL"'"
		   fi
		fi
             fi
       else
          if [[ $VALUE == eu_* ]]
          then
             str=$str" and ("$TAB"."$VALUE" = '"$VAL"'"
          else
             if [[ $NAME == ind_* ]]
             then
                if [[ $VALUE == "" ]]
                then
                   ;
                else
                   if [[ $FCHAR == 1 ]]
                   then
                      str=$str" and ("$TAB"."$NAME" = '"$FCHAR"' or "$TAB"."$NAME" = '"$VAL"'"
                   else
                      str=$str" and ("$TAB"."$NAME" > '"$NCHAR"' and "$TAB"."$NAME" != '"$VAL"'"
                   fi
                fi
             else
                if [[ $NAME == hunt || $NAME == comm || $NAME == dfm || $NAME == partwell ]]
                then
                   str=$str" and ("$TAB"."$VALUE" = '"$VAL"'"
                else
                   str=$str" and ("$TAB"."$VALUE" >= '"$VAL"'"
                fi
             fi
          fi
       fi

    if [[ $VALUE == eu_* ]]
    then
      str=$str" or "$TAB"."$VALUE" = 'H'"
    fi

   if [[ $VALUE == "" ]]
   then
     ;
    else
    str=$str" )"
    fi

   fi
fi
fi
done

echo $str >> /data/logs/str.log

echo "</html>"
env>/tmp/env.txt

$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/ADHOC1_EUSU partners_na NA NC 0 "$str"

