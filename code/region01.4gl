
globals "globals.4gl"

define
   FieldArr array[10] of char(20)

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   SQLStr char(512),
   wStr char(128),
   str char(20),
   DELIMIT char(1),
   resell_str char(1),
   svp_str1 char(1),
   svp_str2 char(1),
   svp_str3 char(1),
   svp_str4 char(1),
   svp_str5 char(1),
   BPTV_Cnt smallint,
   fieldStr char(1024),
   i, cnt smallint

call ReadCmdLn("home", 4)
call ProcCmdLn("home")

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id, 1)

let SQLStr = BuildBaseStr( BRec.b_id, FALSE )

let wStr = "where a.ceid = k.ceid order by a.part_name"
let SQLStr = SQLStr clipped, " ", wStr clipped
prepare SQID from SQLStr
declare SQCurs cursor for SQID

      display 
           "CEID", DELIMIT,
           "HQ", DELIMIT,
           "PARTNER NAME", DELIMIT,
           BRec.b_id clipped, " Channel Rep", DELIMIT,
           BRec.b_id clipped, " Channel TSS", DELIMIT,
           BRec.b_id clipped, " Field TSS", DELIMIT

foreach SQCurs into ARec.*, KRec.*

#  load the array of BPTV info
   let BPTV_Cnt = GetBPTVParts( ARec.ceid )

   let cnt = 0
   initialize fieldStr to NULL
   let cnt = LoadFieldArr( BRec.b_id, ARec.ceid )

   for i = 1 to cnt
      if( i=1 )then
         let fieldStr = FieldArr[i]
      else
         let fieldStr = fieldStr clipped, ", ", FieldArr[i]
     end if
   end for
#display i, fieldStr clipped
      display 
           ARec.ceid clipped, DELIMIT,
           '"', ARec.hq clipped, '"', DELIMIT,
           '"', ARec.part_name clipped, '"', DELIMIT,
           '"', ARec.ssr clipped, '"', DELIMIT,
           '"', ARec.ctp clipped, '"', DELIMIT,
           '"', fieldStr clipped, '"', DELIMIT

end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

function LoadFieldArr( in_brand, in_ceid )
define
   in_brand like field.b_id,
   in_ceid like field.ceid,
   SQLStr char(256),
   ret_cnt smallint

   let SQLStr="select a.ctp from field a where a.b_id='", in_brand clipped,
              "' and a.ceid='", in_ceid clipped, "'"

   prepare LFAID from SQLStr
   declare LFACurs cursor for LFAID

   let ret_cnt = 0
   foreach LFACurs into FieldArr[ret_cnt+1]
#      display SQLStr clipped, FieldArr[ret_cnt+1] clipped
      let ret_cnt = ret_cnt + 1
   end foreach

   return ret_cnt
end function  #LoadFieldArr
