
##
## February 02, 2014 - John M. Shoemaker, made general to all brands
## March    05, 2014 - John M. Shoemaker, filter out not used skills
## February  17, 2016 John M. Shoemaker, filter out reseller X
## March     21, 2016 John M. Shoemaker, expand to ALL for all units

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
   lStr char(512),
   resStr char(1024)

call ReadCmdLn( "export2", 4)
call ProcCmdLn( "export2" )
#let AdhocStr = arg_val(5)
#call Header(0, IRec.i_id, BRec.b_id, 1)

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id)

let lStr = "select a.brand from control where production=1 order by brand"
let SQLStr = BuildBaseStr( BRec.b_id, FALSE )

let wStr = "where a.ceid=k.ceid and a.ceid=l.ceid and a.ceid=m.ceid and a.ceid=n.ceid and a.part_type != 'D' and a.reseller != 'N' and a.reseller != 'X' order by a.part_name"
let SQLStr = SQLStr clipped, " ", wStr clipped
display SQLStr clipped
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

foreach SQCurs into URec.*, KRec.*, LRec.*, MRec.*, NRec.*

{
      let SQLStr="select unique a.* from brands a, unit_brand b where a.b_id=b.b_id and b.u_id='", BRec.b_id clipped, "' order by a.b_ord"
      prepare GCID3 from SQLStr
      declare GCID3Curs cursor for GCID3
      foreach GCID3Curs into BrandRec.*
         call LoadSkillsU( "", BrandRec.b_ord )
         let ti = BrandRec.b_ord
         initialize tabStr to NULL
         let skillStr = " ("
         for i = 1 to 30
            if( SkillCatRec.c_brand = BrandRec.b_id and SkillArrU[ti,i].c_id = SkillCatRec.c_id )then
               if( tabStr = "" or tabStr is NULL )then
                  let tabStr = "skills_", BrandRec.b_id clipped, " b "
               end if
#               display "Brand: ", BrandRec.b_name clipped, " - I:",i, "-", SkillArrU[ti,i].*
               if( skillStr != " (" )then
                  let skillStr = skillStr clipped, " or "
               end if
               let skillStr = skillStr clipped, " ", "b.skill_", SkillArrU[ti,i].db_num using "&&", "=3"
            end if
         end for
         let skillStr = skillStr clipped, ")
}
## Detailed Skill Section - current brand
#   call LoadSkillsU()

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

