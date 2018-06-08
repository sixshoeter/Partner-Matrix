#!/bin/ksh

. /home/informix/shoe/.profile

export TERMCAP=$INFORMIXDIR/etc/termcap
export TERM=xterm
export INFORMIXTERM=termcap
export HOST=informixva
export LD_LIBRARY_PATH=/opt/IBM/informixMore/lib/tools:/opt/IBM/informixMore/lib:/opt/IBM/informixMore/lib/esql:/opt/IBM/informix/clidriver/lib:/opt/IBM/informix/lib/esql:/opt/IBM/informix/lib/dmi:/opt/IBM/informix/lib/cli:/opt/IBM/informix/lib/c++:/opt/IBM/informix/lib
# touch the correct trigger file
#env | sort >e

$INFORMIXDIR/bin/sperform /home/informix/shoe/forms/tasks

env > /tmp/e.txt
$INFORMIXDIR/bin/fglgo /home/informix/shoe/code/TASKLIST partners_na NA > /home/informix/shoe/NA/all/H/tasklist.html

