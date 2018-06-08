##
## September 04, 2014 John M. Shoemaker jshoe@us.ibm.com, filter out VADs
## September 08, 2014 John M. Shoemaker jshoe@us.ibm.com, change from '1' to '*'

globals "globals.4gl"

MAIN
define
   SQLStr char(256),
   dSQLStr char(256),
   Idx smallint,
   ErrArr array[200] of record
      e1 char(1),
      e2 char(1),
      e3 char(1),
      e4 char(1),
      e5 char(1),
      e6 char(1),
      e7 char(1),
      e8 char(1)
   end record,
   i smallint,
   octp like coverage_ws.ctp,
   DELIMIT char(1)

call ReadCmdLn("check", 4)
call ProcCmdLn("check")

let DELIMIT = ","

## start cursor for looping through all partners

let SQLStr = "select * from ", cov_tab clipped, " where part_type != 'D' and reseller != 'N' and reseller != 'V' order by part_name, ctp "
#let SQLStr = "select * from ", cov_tab clipped, " where part_type != 'D' and reseller != 'N' order by ctp, part_name"

prepare SQLID from SQLStr
declare ACurs cursor for SQLID 

#display "Partner Data that is missing from Partner Matrix:"

let i = 0
initialize octp to NULL
let Idx = 0
for i = 1 to 200
   initialize ErrArr[i].* to NULL
end for

display "Partner", DELIMIT,
        "Brand Rep", DELIMIT,
        "TSS Rep", DELIMIT,
        "Description", DELIMIT,
        "Contact", DELIMIT,
        "Skills", DELIMIT,
        "Enterprise Units", DELIMIT,
        "VAD", DELIMIT,
        "Industry", DELIMIT,
        "URLs"

foreach ACurs into ARec.*
   let Idx = Idx + 1

## e1 = description
   if( ARec.desc is null )then
      let ErrArr[Idx].e1 = '*'
   end if

## e2 = contact
   if( ARec.p_name is null and (ARec.p_phone is null or ARec.p_email is null ))then
      let ErrArr[Idx].e2 = '*'
   end if

## e3 = partner skills
  let dSQLStr = "select k.* from ", skill_tab clipped, " k where k.ceid = '", ARec.ceid clipped, "' "
  prepare SQLID2 from dSQLStr
  execute SQLID2 into KRec.*
   
  if ( NoSkills() )then 
      let ErrArr[Idx].e3 = '*'
  end if

## e4 = enterprise units
  if ( NoEU() )then 
      let ErrArr[Idx].e4 = '*'
  end if

## e5 = vads
  if ( ARec.vad is NULL or ARec.vad = ' ' )then 
      let ErrArr[Idx].e5 = '*'
  end if

## e6 = industry
  if ( NoIndustry() )then 
      let ErrArr[Idx].e6 = '*'
  end if

## e7 = urls
   if( ARec.url is null or ARec.pwp is null )then
      let ErrArr[Idx].e7 = '*'
   end if

if ( ErrArr[Idx].e1 or ErrArr[Idx].e2 or ErrArr[Idx].e3 or ErrArr[Idx].e4 or ErrArr[Idx].e5 or ErrArr[Idx].e6 or ErrArr[Idx].e7 )then
   display 
        '"', ARec.part_name clipped, '"', DELIMIT,
        ARec.ssr clipped, DELIMIT,
        ARec.ctp clipped, DELIMIT,
        ErrArr[Idx].e1, DELIMIT,
        ErrArr[Idx].e2, DELIMIT,
        ErrArr[Idx].e3, DELIMIT,
        ErrArr[Idx].e4, DELIMIT,
        ErrArr[Idx].e5, DELIMIT,
        ErrArr[Idx].e6, DELIMIT,
        ErrArr[Idx].e7 
end if


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
       KRec.skill_20 is null AND
       KRec.skill_21 is null AND
       KRec.skill_22 is null AND
       KRec.skill_23 is null AND
       KRec.skill_24 is null AND
       KRec.skill_25 is null AND
       KRec.skill_26 is null AND
       KRec.skill_27 is null AND
       KRec.skill_28 is null AND
       KRec.skill_29 is null AND
       KRec.skill_30 is null )then
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
end function  #NoEU

function NoIndustry()
   define
      ret smallint

   let ret = FALSE

   if( 
       ARec.ind_eu is null AND
       ARec.ind_tel is null AND
       ARec.ind_me is null AND
       ARec.ind_ret is null AND
       ARec.ind_wd is null AND
       ARec.ind_trans is null AND
       ARec.ind_bank is null AND
       ARec.ind_ins is null AND
       ARec.ind_mfg is null AND
       ARec.ind_hl is null AND
       ARec.ind_gov is null AND
       ARec.ind_cross is null )then

      let ret = TRUE
   end if

  return ret
end function  #NoIndustry

