#!/bin/ksh

##***********************************************************************
### Copyright (c) 2013 IBM
###
### snap.ksh
###  by: John M. Shoemaker, jshoe@us.ibm.com, jshoemaker1@cox.net
###  07/23/2014 John M. Shoemaker, change export dir
###      
###
###
##***********************************************************************

. /home/informix/.profile
. /opt/pm/.profile

DATEFMT='+%Y%m%d%H%M%S'

## NA EXPORT
EXPNM=partners_na-`date $DATEFMT`

cd /data/exports/dbexports
#cd /opt/pm/export

$INFORMIXDIR/bin/dbexport -ss partners_na 

if [[ -d partners_na.exp ]]
then
   mv partners_na.exp $EXPNM
fi



## EU EXPORT
EXPNM=partners_eu-`date $DATEFMT`

cd /data/exports/dbexports
#cd /opt/pm/export

$INFORMIXDIR/bin/dbexport -ss partners_eu 

if [[ -d partners_eu.exp ]]
then
   mv partners_eu.exp $EXPNM
fi

