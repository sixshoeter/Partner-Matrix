
globals "globals.4gl"

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
   BPTV_Cnt smallint

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


case BRec.b_id 
   when 'IM'
      display 
           "PARTNER NAME", DELIMIT,
           "CEID", DELIMIT,
           "Emerging", DELIMIT, 
           "Status", DELIMIT,
           "IM Brand Rep", DELIMIT,
           "IM TSS", DELIMIT

   when 'WS'
      display 
           "CEID", DELIMIT,
           "VAD", DELIMIT,
           "HQ", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "Emerging", DELIMIT, 
           "Status", DELIMIT,
           "SVP - BPM", DELIMIT,
	   "SVP - CORE", DELIMIT,
           "SVP - EIS", DELIMIT,
           "WS Brand Rep", DELIMIT,
           "WS TSS", DELIMIT,
           "CEID"
    otherwise
      display 
           "CEID", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "Brand Rep", DELIMIT,
           "TSS", DELIMIT

end case


foreach SQCurs into ARec.*, KRec.*

#  load the array of BPTV info
   let BPTV_Cnt = GetBPTVParts( ARec.ceid )


   if( ARec.reseller = "E" )then
      let resell_str = "Y"
   else
      let resell_str = " "
   end if

case BRec.b_id
   when 'IM'
      display 
           '"', ARec.part_name clipped, '"', DELIMIT,
           ARec.ceid clipped, DELIMIT,
           resell_str clipped, DELIMIT,
           '"', ARec.part_type clipped, '"', DELIMIT,
           '"', ARec.ssr clipped, '"', DELIMIT,
           '"', ARec.ctp clipped, '"'

   when 'WS'
      if ( SVPinBPTV(SVPArr[1].bptv_name ))then
         let svp_str1 = "Y"
      else
         let svp_str1 = " "
      end if
      if ( SVPinBPTV(SVPArr[2].bptv_name ))then
         let svp_str2 = "Y"
      else
         let svp_str2 = " "
      end if
      if ( SVPinBPTV(SVPArr[3].bptv_name ))then
         let svp_str3 = "Y"
      else
         let svp_str3 = " "
      end if
      if ( SVPinBPTV(SVPArr[4].bptv_name ))then
         let svp_str4 = "Y"
      else
         let svp_str4 = " "
      end if
      if ( SVPinBPTV(SVPArr[5].bptv_name ))then
         let svp_str5 = "Y"
      else
         let svp_str5 = " "
      end if
#
      display 
           ARec.ceid clipped, DELIMIT,
           '"', ARec.vad clipped, '"', DELIMIT,
           '"', ARec.hq clipped, '"', DELIMIT,
           '"', ARec.part_name clipped, '"', DELIMIT,
           resell_str clipped, DELIMIT,
           '"', ARec.part_type clipped, '"', DELIMIT,
           svp_str2 clipped, DELIMIT,
           svp_str1 clipped, DELIMIT,
           svp_str4 clipped, DELIMIT,
           '"', ARec.ssr clipped, '"', DELIMIT,
           '"', ARec.ctp clipped, '"', DELIMIT,
           ARec.ceid clipped
    otherwise
      display 
           ARec.ceid clipped, DELIMIT,
           '"', ARec.part_name clipped, '"', DELIMIT,
           '"', ARec.ssr clipped, '"', DELIMIT,
           '"', ARec.ctp clipped, '"', DELIMIT
end case


end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

