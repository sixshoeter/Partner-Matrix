#!/bin/ksh

cat ../in_files/B.inp | awk -f BPTV_Proc1.awk > ../in_files/bptv.inp
cat ../in_files/B.inp | awk -f BPTV_Proc2.awk > ../in_files/bptv_parts.inp

