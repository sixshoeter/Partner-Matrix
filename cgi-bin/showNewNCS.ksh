#!/bin/ksh

. /home/informix/.profile
. /opt/pm/.profile

CEID=""
echo "Content-type: text/html"
echo

CEID=`echo $1 | awk '{print $1}' | awk -F ':' '{print $1}'`

DATEFMT="+%Y%m%d%H%M%S"

#write record to file
varstr="$CEID"
echo NC:`date $DATEFMT`:$varstr >> /data/logs/eu-showNewCEID.log

# call dynamic page
$INFORMIXDIR/bin/fglgo $HOME/code-eu/nBUILDPAGESS partners_eu EU NC "$CEID" 0

echo "</body>"
echo "</html>"



