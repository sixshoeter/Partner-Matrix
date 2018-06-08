#!/bin/ksh

. /home/informix/.profile
. /opt/pm/.profile

var1="$QUERY_STRING"
CEID=""
VALUE=""
echo "Content-type: text/html"
echo
var2=`echo $var1 | tr "&" "\t"`

OO=`echo $var1 | tr = " "`
CEID=`echo $OO | awk '{print $2}' | awk -F '&' '{print $1}'`
YNAME=`echo $OO | awk '{print $3}' | awk -F '&' '{print $1}'`
YNAME=`echo $YNAME | tr -s "%40" "@"`
YPIN=`echo $OO | awk '{print $4}' `
#echo YNAME: $YNAME "<br>"
#echo YPIN: $YPIN "<br>"

RES=`echo "select count(*) cnt from authorization a where a.brand='NC' and a.id='$YNAME' and a.pin='$YPIN';" | isql partners_eu`
#echo $RES

if [[ "$RES" = *1 ]]
then

DATEFMT="+%Y%m%d%H%M%S"

#write record to file
echo NC:$CEID:`date $DATEFMT`:$YNAME >> /data/logs/eu_upd_history.log

# generate update page
$INFORMIXDIR/bin/fglgo /opt/pm/code-eu/nBUILDPAGESS partners_eu EU NC $CEID 5 

else
   echo "The email/pin combination that you entered is not valid for this Partner Matrix.  Please contact <a href='http://w3.ibm.com/newbp/profile.html?uid=5A8702897' target='_blank'>John Shoemaker</a> to create/reset your pin." 

fi

echo "</body>"
echo "</html>"

