globals "globals.4gl"

MAIN
define
   SQLStr char(256),
   i smallint,
   octp like coverage_ws_eus.ctp

call ReadCmdLn("check", 4)
call ProcCmdLn("check")

let SQLStr = "select * from ", cov_tab clipped, " where part_type != 'D' and reseller != 'N' order by ctp, part_name"

prepare SQLID from SQLStr
declare ACurs cursor for SQLID 

display "Partner Data that is missing from Partner Matrix:"
display " "

let i = 0
display "Missing Partner DESCRIPTION: "
initialize octp to NULL

foreach ACurs into ARec.*
   if( ARec.desc is null )then
      let i = i + 1
      if( octp is not NULL and octp != ARec.ctp )then
         display ""
      end if
      display i using "##", ") ", ARec.part_name clipped, " (", ARec.ctp clipped, ")"
      let octp = ARec.ctp
   end if
end foreach

let i = 0
display " "
initialize octp to NULL
display "Missing Partner CONTACT: "

foreach ACurs into ARec.*
   if( ARec.p_name is null and (ARec.p_phone is null or ARec.p_email is null ))then
      let i = i + 1
      if( octp is not NULL and octp != ARec.ctp )then
         display ""
      end if
      display i using "##", ") ", ARec.part_name clipped, " (", ARec.ctp clipped, ")"
      let octp = ARec.ctp
   end if
end foreach

let i = 0
display " "
initialize octp to NULL
display "Missing Partner SKILLS: "

foreach ACurs into ARec.*
   let SQLStr = "select k.* from skills_ws k, ", cov_tab clipped, " a where a.ceid = k.ceid and a.part_type != 'D' and a.reseller != 'N' and k.ceid='", ARec.ceid clipped, "'"
   prepare SQLID2 from SQLStr
   declare KCurs cursor for SQLID2

   foreach KCurs into KRec.*
      if ( NoSkills() )then 
         let i = i + 1
         if( octp is not NULL and octp != ARec.ctp )then
            display ""
         end if
         display i using "##", ") ", ARec.part_name clipped, " (", ARec.ctp clipped, ")"
         let octp = ARec.ctp
      end if
   end foreach
end foreach


######
let SQLStr = "select * from ", cov_tab clipped, " where part_type != 'D' and reseller != 'N' order by ctp, part_name"

prepare SQLID3 from SQLStr
declare BCurs cursor for SQLID3
let i = 0
display " "
initialize octp to NULL
display "Missing Partner ENTERPRISE UNITS: "

foreach BCurs into ARec.*
      if ( NoEU() )then 
         let i = i + 1
         if( octp is not NULL and octp != ARec.ctp )then
            display ""
         end if
         display i using "##", ") ", ARec.part_name clipped, " (", ARec.ctp clipped, ")"
         let octp = ARec.ctp
      end if
end foreach

######
let SQLStr = "select * from ", cov_tab clipped, " where vad is null or vad = ' ' order by ctp, part_name"

prepare SQLID4 from SQLStr
declare CCurs cursor for SQLID4
let i = 0
display " "
initialize octp to NULL
display "Missing Partner VADs: "

foreach CCurs into ARec.*
   let i = i + 1
   display i using "##", ") ", ARec.part_name clipped, " (", ARec.ctp clipped, ")"
end foreach


END MAIN

function NoSkills()
   define
      ret smallint

   let ret = FALSE

   if( KRec.skill_01 is null AND
       KRec.skill_02 is null AND
       KRec.skill_03 is null AND
       KRec.skill_04 is null AND
       KRec.skill_05 is null AND
       KRec.skill_06 is null AND
       KRec.skill_07 is null AND
       KRec.skill_08 is null AND
       KRec.skill_09 is null AND
       KRec.skill_10 is null AND
       KRec.skill_11 is null AND
       KRec.skill_12 is null AND
       KRec.skill_13 is null AND
       KRec.skill_14 is null AND
       KRec.skill_15 is null AND
       KRec.skill_16 is null AND
       KRec.skill_17 is null AND
       KRec.skill_18 is null AND
       KRec.skill_19 is null AND
       KRec.skill_20 is null )then
      let ret = TRUE
   end if

  return ret
end function

function NoEU()
   define
      ret smallint

   let ret = FALSE

   if( 
       ARec.eu_pacificnw is null AND
       ARec.eu_northca is null AND
       ARec.eu_southwest is null AND
       ARec.eu_rockies is null AND
       ARec.eu_chicago is null AND
       ARec.eu_minn is null AND
       ARec.eu_plains is null AND
       ARec.eu_heartland is null AND
       ARec.eu_texas is null AND
       ARec.eu_gulf is null AND
       ARec.eu_ny is null AND
       ARec.eu_garden is null AND
       ARec.eu_northeast is null AND
       ARec.eu_delaware is null AND
       ARec.eu_potomac is null AND
       ARec.eu_carolinas is null AND
       ARec.eu_midamerica is null AND
       ARec.eu_ohio is null AND
       ARec.eu_southeast is null AND
       ARec.eu_sunshine is null AND
       ARec.eu_ca_industry is null AND
       ARec.eu_ca_enterprise is null AND
       ARec.eu_ca_midmarket is null AND
       ARec.eu_fed_civ is null AND
       ARec.eu_fed_dod is null )then

      let ret = TRUE
   end if

  return ret
end function  #NoBU
