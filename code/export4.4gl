
globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   SQLStr char(2048),
   AdhocStr char(128),
   wStr char(128),
   str char(20),
   DELIMIT char(1),
   brand char(2)

call ReadCmdLn( "export2", 4)
call ProcCmdLn( "export2" )
#let AdhocStr = arg_val(5)
#call Header(0, IRec.i_id, BRec.b_id, 1)

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id)

      let SQLStr = 
            "select 'WS' brand, a.*, k.* from coverage_ws a, skills_ws k where a.ceid = k.ceid ",
      "union select 'IM' brand, a.*, k.* from coverage_im a, skills_im k where a.ceid = k.ceid  "

#      "union select 'TI' brand, a.*, k.* from coverage_ti a, skills_ti k where a.ceid = k.ceid ", 
#      "union select 'RA' brand, a.*, k.* from coverage_ra a, skills_ra k where a.ceid = k.ceid "
#      "union select 'LO' brand, a.*, k.* from coverage_lo a, skills_lo k where a.ceid = k.ceid "

let SQLStr = SQLStr clipped
prepare SQID from SQLStr
declare SQCurs cursor for SQID

   display "CEID", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "BRAND", DELIMIT,
           "VAD", DELIMIT,
           "MQ suite", DELIMIT,
           "Msg Broker", DELIMIT,
           "WESB", DELIMIT,
           "BPM", DELIMIT,
           "ODM", DELIMIT,
           "DataPower", DELIMIT,
           "Cast Iron", DELIMIT,
           "WAS", DELIMIT,
           "eXtreme Scale", DELIMIT,
           "WorkLight", DELIMIT,
           "Pure Application", DELIMIT,
           "MessageSight", DELIMIT,
           "API Mgmt", DELIMIT

foreach SQCurs into brand, ARec.*, KRec.*
   display ARec.ceid clipped, DELIMIT,
           '"', ARec.part_name clipped, '"', DELIMIT,
           brand clipped, DELIMIT,
	   '"', ARec.vad clipped, '"', DELIMIT,
           KRec.skill_01 using "##", DELIMIT,
           KRec.skill_02 using "##", DELIMIT,
           KRec.skill_03 using "##", DELIMIT,
           KRec.skill_04 using "##", DELIMIT,
           KRec.skill_05 using "##", DELIMIT,
           KRec.skill_06 using "##", DELIMIT,
           KRec.skill_07 using "##", DELIMIT,
           KRec.skill_08 using "##", DELIMIT,
           KRec.skill_10 using "##", DELIMIT,
           KRec.skill_11 using "##", DELIMIT,
           KRec.skill_12 using "##", DELIMIT,
           KRec.skill_13 using "##", DELIMIT,
           KRec.skill_14 using "##", DELIMIT

end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

