
globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   tRec record like tbptv.*,
   SQLStr char(2048),
   AdhocStr char(128),
   wStr char(128),
   str char(20),
   DELIMIT char(1),
   brand char(2),
   tss char(20)

call ReadCmdLn( "export6", 4)
call ProcCmdLn( "export6" )
#let AdhocStr = arg_val(5)
#call Header(0, IRec.i_id, BRec.b_id, 1)

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id)

let SQLStr = "select b.ctp, a.* from tbptv a, ", cov_tab clipped, " b, svp c where a.ceid = b.ceid and a.rag = c.bptv_name and c.s_brand='", BRec.b_id clipped, "' and (a.nlrev_01>0 or a.vrrev_01>0) order by b.ctp, a.part_name, a.rag, a.revdt"

let SQLStr = SQLStr clipped
prepare SQID from SQLStr
declare SQCurs cursor for SQID

## header
   display 
           '"TSS"', DELIMIT,
           '"IMT"', DELIMIT,
           '"CEID"', DELIMIT,
           '"Partner Name"', DELIMIT,
           '"Brand"', DELIMIT,
	   '"RAG"', DELIMIT,
	   '"Date"', DELIMIT,
	   '"NL Revenue"', DELIMIT,
	   '"Val Revnue"', DELIMIT

foreach SQCurs into tss, tRec.*
   display 
           '"', tss clipped, '"', DELIMIT,
           '"', tRec.imt clipped, '"', DELIMIT,
           '"', tRec.ceid clipped, '"', DELIMIT,
           '"', tRec.part_name clipped, '"', DELIMIT,
           BRec.b_id clipped, DELIMIT,
	   '"', tRec.rag clipped, '"', DELIMIT,
	   tRec.revdt, DELIMIT,
	   tRec.nlrev_01 clipped, DELIMIT,
	   tRec.vrrev_01 clipped, DELIMIT

end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

