#!/bin/ksh
. /home/informix/shoe/.profile

/home/informix/shoe/code/proc_http.ksh

grep homeU /home/informix/shoe/in_files/access.inp>/tmp/home.csv
grep -e 'query_[A-Z][A-Z]_eus' /home/informix/shoe/in_files/access.inp>/tmp/fap.csv
grep menu_coverageU /home/informix/shoe/in_files/access.inp>/tmp/cover.csv
grep authorizationU /home/informix/shoe/in_files/access.inp>/tmp/authorization.csv
grep skillsU /home/informix/shoe/in_files/access.inp>/tmp/skills.csv
grep industriesU /home/informix/shoe/in_files/access.inp>/tmp/industries.csv

$TOOLBIN/fglgo $CODEDIR/ACCESS_CNT


$TOOLBIN/fglgo $CODEDIR/HOMEU partners_na NA AU 1 > $HOME/NA/AU/H/homeU.html
$TOOLBIN/fglgo $CODEDIR/HOMEU partners_na NA SU 1 > $HOME/NA/SU/H/homeU.html
$TOOLBIN/fglgo $CODEDIR/HOMEU partners_na NA CU 1 > $HOME/NA/CU/H/homeU.html
$TOOLBIN/fglgo $CODEDIR/HOMEU partners_na NA BU 1 > $HOME/NA/BU/H/homeU.html
$TOOLBIN/fglgo $CODEDIR/HOMEU partners_na NA ST 1 > $HOME/NA/ST/H/homeU.html
$TOOLBIN/fglgo $CODEDIR/HOMEU partners_na NA ES 1 > $HOME/NA/ES/H/homeU.html
$TOOLBIN/fglgo $CODEDIR/HOMEU partners_na NA IO 1 > $HOME/NA/IO/H/homeU.html

