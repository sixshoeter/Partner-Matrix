##
## September 23, 2014 John M. Shoemaker jshoe@us.ibm.com, create export12
## February  17, 2016 John M. Shoemaker, filter out reseller X
##

globals "globals.4gl"

MAIN
define
   SQLStr char(256),
   dSQLStr char(256),
   Idx smallint,
   i smallint,
   octp like coverage_ws.ctp,
   DELIMIT char(1)

call ReadCmdLn("check", 4)
call ProcCmdLn("check")

let DELIMIT = ","

## start cursor for looping through all partners

let SQLStr = "select * from ", cov_tab clipped, " where part_type != 'D' and reseller != 'N' and reseller != 'V' and reseller != 'X' order by part_name, ctp "
#let SQLStr = "select * from ", cov_tab clipped, " where part_type != 'D' and reseller != 'N' order by ctp, part_name"

prepare SQLID from SQLStr
declare ACurs cursor for SQLID 

#display "Partner Data that is missing from Partner Matrix:"

let i = 0
initialize octp to NULL
let Idx = 0

display "CEID", DELIMIT,
        "Partner", DELIMIT,
        "Brand Rep", DELIMIT,
        "TSS Rep", DELIMIT

foreach ACurs into ARec.*
   let Idx = Idx + 1

   display 
        '"', ARec.ceid clipped, '"', DELIMIT,
        '"', ARec.part_name clipped, '"', DELIMIT,
        ARec.ssr clipped, DELIMIT,
        ARec.ctp clipped, DELIMIT


end foreach


END MAIN

