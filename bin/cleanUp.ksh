#!/bin/ksh

## CleanUp.ksh       #314
## February   12, 2018  John M Shoemaker, jshoe@us.ibm.com

. /opt/pm/.profile

for i in $HOME/NA/*/tmp
do

cd $i
if [ -d OLD_* ]
then
   find $i/OLD_* -maxdepth 0 -mtime 1 -exec rm -r $i/OLD_* \;
fi

done


