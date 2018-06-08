#!/bin/ksh

. /home/informix/.profile
. /home/informix/shoe/.profile

## This script will write the addBPXX.ksh file for the specified Unit, where XX is the unit code 
## UPPER CASE, like: addBPST.ksh
## 
## April   18, 2016 John M. Shoemaker, jshoemaker1@cox.net, create

INU=$1

## make sure there is an input
if [[ ! -z "$INU" ]] ; then

DIR="/home/informix/shoe/cgi-bin"
SOURCEF="/home/informix/shoe/bin/.updRecXX"

cat $SOURCEF | sed "s/XXXY/$INU/g"

fi
