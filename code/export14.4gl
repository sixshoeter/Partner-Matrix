# export14.4gl - export success stories

## April    10, 2015 - John M. Shoemaker 
## February  17, 2016 John M. Shoemaker, filter out reseller X


globals "globals.4gl"

main
define
   SuccessRec record like success_au.*,
   tmpName like coverage_au.part_name,
   tmpssr like coverage_au.ssr,
   SQLStr char(256),
   DELIMIT char(1)

call ReadCmdLn("home", 4)
call ProcCmdLn("home")

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id, 1)

let SQLStr = "select a.part_name, a.ssr, b.* from ", cov_tab clipped, " a, ", success_tab clipped, " b ",
             " where a.ceid = b.ceid and a.reseller != 'N' and a.reseller != 'X' order by a.part_name "

prepare SQID from SQLStr
declare SQCurs cursor for SQID

    display 
           "CEID", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "BPR", DELIMIT,
           "SUCCESS TITLE", DELIMIT,
           "URL", DELIMIT

foreach SQCurs into tmpName, tmpssr, SuccessRec.*

    display 
           SuccessRec.ceid clipped, DELIMIT,
           '"', tmpName clipped, '"', DELIMIT,
           tmpssr clipped, DELIMIT,
           SuccessRec.s_title clipped, DELIMIT,
           SuccessRec.s_link clipped, DELIMIT


end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

