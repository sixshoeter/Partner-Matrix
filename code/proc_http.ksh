#!/bin/ksh

cat /opt/IBM/OpenAdmin/OAT/Apache_2.2.16/logs/access*log* | awk -f http_proc.awk | \
tr '[' ' ' | \
sed -e 's/Jan/01/' \
    -e 's/Feb/02/' \
    -e 's/Mar/03/' \
    -e 's/Apr/04/' \
    -e 's/May/05/' \
    -e 's/Jun/06/' \
    -e 's/Jul/07/' \
    -e 's/Aug/08/' \
    -e 's/Sep/09/' \
    -e 's/Oct/10/' \
    -e 's/Nov/11/' \
    -e 's/Dec/12/' \
> ../in_files/access.inp

