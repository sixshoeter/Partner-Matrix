
##
## February 02, 2014 - John M. Shoemaker, made general to all brands
## March    05, 2014 - John M. Shoemaker, filter out not used skills
## February  17, 2016 John M. Shoemaker, filter out reseller X
##

globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   SQLStr char(512),
   AdhocStr char(128),
   wStr char(256),
   str char(20),
   DELIMIT char(1),
   i smallint,
   resStr char(1024)

call ReadCmdLn( "export2", 4)
call ProcCmdLn( "export2" )
#let AdhocStr = arg_val(5)
#call Header(0, IRec.i_id, BRec.b_id, 1)

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id)

let SQLStr = BuildBaseStr( BRec.b_id, FALSE )

let wStr = "where a.ceid = k.ceid and a.part_type != 'D' and a.reseller != 'N' and a.reseller != 'X' order by a.part_name"
let SQLStr = SQLStr clipped, " ", wStr clipped
#display SQLStr clipped
prepare SQID from SQLStr
declare SQCurs cursor for SQID
initialize resStr to NULL

let resStr = "CEID", DELIMIT, "PARTNER NAME", DELIMIT, "VAD", DELIMIT
for i = 1 to 20
   if( SkillArr[i].s_name != 'NA' )then
      let resStr = resStr clipped, '"', SkillArr[i].s_desc clipped, '"', DELIMIT
   end if
end for
display resStr clipped
{
   display "CEID", DELIMIT,
           "PARTNER NAME", DELIMIT,
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
}

foreach SQCurs into ARec.*, KRec.*

## Detailed Skill Section - current brand
   call LoadSkills()

   let resStr = ARec.ceid clipped, DELIMIT,
           '"', ARec.part_name clipped, '"', DELIMIT,
	   '"', ARec.vad clipped, '"', DELIMIT

      for i = 1 to 20
         if( SkillArr[i].s_name != 'NA' )then
            let resStr = resStr clipped, BPSkillsArr[i] using '##', DELIMIT
         end if
      end for

    display resStr clipped
end foreach

##display skill legend
display "-----------------------------------------------------------"
display "3-TOP Skilled Partner, with multiple successful engagements"
display "2-Skilled Partner, with successful engagements"
display "1-Learning partner"

#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

