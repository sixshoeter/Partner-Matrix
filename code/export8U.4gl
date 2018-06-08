##
## September 04, 2014 John M. Shoemaker jshoe@us.ibm.com, filter out VADs
## September 08, 2014 John M. Shoemaker jshoe@us.ibm.com, change from '1' to '*'
## March     20, 2015 John M. Shoemaker, convert to Units
## June      08, 2015 John M. Shoemaker, add additional CTPs (4-5)
## June      15, 2015 John M. Shoemaker, add BU
## February  17, 2016 John M. Shoemaker, filter out reseller X

globals "globals.4gl"

define
   ORec record like skills_s1.*

MAIN
define
   SQLStr char(256),
   dSQLStr char(256),
   Idx smallint,
   ErrArr array[1000] of record
      e1 char(1),
      e2 char(1),
      e3a char(1),
      e3b char(1),
      e3c char(1),
      e3d char(1),
      e3e char(1),
      e4 char(1),
      e5 char(1),
      e6 char(1),
      e7 char(1)
   end record,
   i smallint,
   ossr like coverage_au.ssr,
   DELIMIT char(1),
   DispLine char(512)

call ReadCmdLn("check", 4)
call ProcCmdLn("check")

let DELIMIT = ","

## start cursor for looping through all partners

let SQLStr = "select * from ", cov_tab clipped, " where part_type != 'D' and reseller != 'N' and reseller != 'V' and reseller != 'X' order by part_name, ssr "
#let SQLStr = "select * from ", cov_tab clipped, " where part_type != 'D' and reseller != 'N' order by ctp, part_name"

prepare SQLID from SQLStr
declare ACurs cursor for SQLID 
#display "Partner Data that is missing from Partner Matrix:"

let i = 0
initialize ossr to NULL
let Idx = 0

let DispLine = "Partner", DELIMIT,
        "Brand Rep", DELIMIT,
        "TSS Rep", DELIMIT,
        "TSS Rep", DELIMIT,
        "TSS Rep", DELIMIT,
        "TSS Rep", DELIMIT,
        "Description", DELIMIT,
        "Contact", DELIMIT

case BRec.b_id 
   when 'AU'
      let DispLine = DispLine clipped, 
        "IM Skills", DELIMIT,
        "ECM Skills", DELIMIT,
        "BA Skills", DELIMIT,
        "IoT Skills", DELIMIT
   when 'SU'
      let DispLine = DispLine clipped, 
        "S1 Skills", DELIMIT,
        "S2 Skills", DELIMIT,
        "S3 Skills", DELIMIT,
        "S4 Skills", DELIMIT,
        "S5 Skills", DELIMIT
   when 'BU'
      let DispLine = DispLine clipped, 
        "Commerce Skills", DELIMIT
end case
let DispLine = DispLine clipped, 
        "Enterprise Units", DELIMIT,
        "VAD", DELIMIT,
        "Industry", DELIMIT,
        "URLs", DELIMIT

display DispLine
{
display "Partner", DELIMIT,
        "Brand Rep", DELIMIT,
        "TSS Rep", DELIMIT,
        "TSS Rep", DELIMIT,
        "TSS Rep", DELIMIT,
        "Description", DELIMIT,
        "Contact", DELIMIT,
        "Skills", DELIMIT,
        "Enterprise Units", DELIMIT,
        "VAD", DELIMIT,
        "Industry", DELIMIT,
        "URLs"
}

foreach ACurs into URec.*
   let Idx = Idx + 1
for i = 1 to 200
   initialize ErrArr[Idx].* to NULL
end for

## e1 = description
   if( URec.desc is null or URec.desc = ' ')then
      let ErrArr[Idx].e1 = '*'
   end if

## e2 = contact
   if( URec.p_name is null and (URec.p_phone is null or URec.p_email is null ))then
      let ErrArr[Idx].e2 = '*'
   end if

## e3a = partner skills
  case BRec.b_id
     when 'AU'
        let skill_tab = "skills_im"
     when 'SU'
        let skill_tab = "skills_s1"
     when 'BU'
        let skill_tab = "skills_co"
  end case
  let dSQLStr = "select k.* from ", cov_tab clipped, " a, ", skill_tab clipped, " k where k.ceid = '", URec.ceid clipped, "' and a.ceid = k.ceid and a.ctp1 is not null "
  prepare SQLID2 from dSQLStr
  execute SQLID2 into KRec.*
   
  if ( NoSkills1() )then 
      let ErrArr[Idx].e3a= '*'
  end if

  if( UnitModeYN() )then

## e3b = partner skills
  case BRec.b_id
     when 'AU'
        let skill_tab = "skills_em"
     when 'SU'
        let skill_tab = "skills_s2"
     when 'BU'
        let skill_tab = ""
  end case

  if( skill_tab != "" )then
  let dSQLStr = "select l.* from ", cov_tab clipped, " a, ", skill_tab clipped, " l where l.ceid = '", URec.ceid clipped, "' and a.ceid = l.ceid and a.ctp2 is not null "
  prepare SQLID2b from dSQLStr
  execute SQLID2b into LRec.*
   
  if ( NoSkills2() )then 
      let ErrArr[Idx].e3b = '*'
  end if
   end if

## e3c = partner skills
  case BRec.b_id
     when 'AU'
        let skill_tab = "skills_ba"
     when 'SU'
        let skill_tab = "skills_s3"
     when 'BU'
        let skill_tab = ""
  end case
if( skill_tab != "" )then
  let dSQLStr = "select m.* from ", cov_tab clipped, " a, ", skill_tab clipped, " m where m.ceid = '", URec.ceid clipped, "' and a.ceid = m.ceid and a.ctp3 is not null "
  prepare SQLID2c from dSQLStr
  execute SQLID2c into MRec.*
   
  if ( NoSkills3() )then 
      let ErrArr[Idx].e3c = '*'
  end if
end if

## e3d = partner skills
  case BRec.b_id
     when 'AU'
        let skill_tab = "skills_io"
     when 'SU'
        let skill_tab = "skills_s4"
     when 'BU'
        let skill_tab = ""
  end case
if( skill_tab != "" )then
        let dSQLStr = "select n.* from ", cov_tab clipped, " a, ", skill_tab clipped, " n where n.ceid = '", URec.ceid clipped, "' and a.ceid = n.ceid and a.ctp4 is not null "
#        let dSQLStr = "select n.* from ", skill_tab clipped, " n where n.ceid = '", URec.ceid clipped, "' "
        prepare SQLID2d from dSQLStr
        execute SQLID2d into NRec.*
   
        if ( NoSkills4() )then 
            let ErrArr[Idx].e3d = '*'
        end if
end if

## e3e = partner skills
  case BRec.b_id
     when 'AU'
        let skill_tab = ""
     when 'SU'
        let skill_tab = "skills_s5"
        let dSQLStr = "select o.* from ", skill_tab clipped, " o where o.ceid = '", URec.ceid clipped, "' "
        prepare SQLID2e from dSQLStr
        execute SQLID2e into ORec.*
   
        if ( NoSkills5() )then 
            let ErrArr[Idx].e3e = '*'
        end if
     when 'BU'
        let skill_tab = ""
  end case
end if  #UnitModeYN

## e4 = enterprise units
  if ( NoEU() )then 
      let ErrArr[Idx].e4 = '*'
  end if

## e5 = vads
  if ( URec.vad is NULL or URec.vad = ' ' )then 
      let ErrArr[Idx].e5 = '*'
  end if

## e6 = industry
  if ( NoIndustry() )then 
      let ErrArr[Idx].e6 = '*'
  end if

## e7 = urls
   if( URec.url is null or URec.pwp is null )then
      let ErrArr[Idx].e7 = '*'
   end if

 if ( ErrArr[Idx].e1 or ErrArr[Idx].e2 or ErrArr[Idx].e3a or ErrArr[Idx].e3b or ErrArr[Idx].e3c or ErrArr[Idx].e3d or ErrArr[Idx].e3e or ErrArr[Idx].e4 or ErrArr[Idx].e5 or ErrArr[Idx].e6 or ErrArr[Idx].e7 )then

   let DispLine = '"', URec.part_name clipped, '"', DELIMIT,
        URec.ssr clipped, DELIMIT,
        URec.ctp1 clipped, DELIMIT,
        URec.ctp2 clipped, DELIMIT,
        URec.ctp3 clipped, DELIMIT,
        URec.ctp4 clipped, DELIMIT,
        ErrArr[Idx].e1, DELIMIT,
        ErrArr[Idx].e2, DELIMIT
   case BRec.b_id
      when 'AU'
        let DispLine = DispLine clipped, 
           ErrArr[Idx].e3a, DELIMIT,
           ErrArr[Idx].e3b, DELIMIT,
           ErrArr[Idx].e3c, DELIMIT,
           ErrArr[Idx].e3d, DELIMIT
      when 'SU'
        let DispLine = DispLine clipped, 
           ErrArr[Idx].e3a, DELIMIT,
           ErrArr[Idx].e3b, DELIMIT,
           ErrArr[Idx].e3c, DELIMIT,
           ErrArr[Idx].e3d, DELIMIT,
           ErrArr[Idx].e3e, DELIMIT
      when 'BU'
        let DispLine = DispLine clipped, 
           ErrArr[Idx].e3a, DELIMIT
   end case
   let DispLine = DispLine clipped, 
        ErrArr[Idx].e4, DELIMIT,
        ErrArr[Idx].e5, DELIMIT,
        ErrArr[Idx].e6, DELIMIT,
        ErrArr[Idx].e7, DELIMIT

   display DispLine
{
   display 
        '"', URec.part_name clipped, '"', DELIMIT,
        URec.ssr clipped, DELIMIT,
        URec.ctp1 clipped, DELIMIT,
        URec.ctp2 clipped, DELIMIT,
        URec.ctp3 clipped, DELIMIT,
        ErrArr[Idx].e1, DELIMIT,
        ErrArr[Idx].e2, DELIMIT,
        ErrArr[Idx].e3, DELIMIT,
        ErrArr[Idx].e4, DELIMIT,
        ErrArr[Idx].e5, DELIMIT,
	ErrArr[Idx].e6, DELIMIT,
	ErrArr[Idx].e7 
}
end if


end foreach


END MAIN

function NoSkills1()
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
end function #NoSkills1

function NoSkills2()
   define
      ret smallint

   let ret = FALSE

   if( LRec.skill_01 is null AND
       LRec.skill_02 is null AND
       LRec.skill_03 is null AND
       LRec.skill_04 is null AND
       LRec.skill_05 is null AND
       LRec.skill_06 is null AND
       LRec.skill_07 is null AND
       LRec.skill_08 is null AND
       LRec.skill_09 is null AND
       LRec.skill_10 is null AND
       LRec.skill_11 is null AND
       LRec.skill_12 is null AND
       LRec.skill_13 is null AND
       LRec.skill_14 is null AND
       LRec.skill_15 is null AND
       LRec.skill_16 is null AND
       LRec.skill_17 is null AND
       LRec.skill_18 is null AND
       LRec.skill_19 is null AND
       LRec.skill_20 is null AND
       LRec.skill_21 is null AND
       LRec.skill_22 is null AND
       LRec.skill_23 is null AND
       LRec.skill_24 is null AND
       LRec.skill_25 is null AND
       LRec.skill_26 is null AND
       LRec.skill_27 is null AND
       LRec.skill_28 is null AND
       LRec.skill_29 is null AND
       LRec.skill_30 is null )then
      let ret = TRUE
   end if

  return ret
end function #NoSkills2

function NoSkills3()
   define
      ret smallint

   let ret = FALSE

   if( MRec.skill_01 is null AND
       MRec.skill_02 is null AND
       MRec.skill_03 is null AND
       MRec.skill_04 is null AND
       MRec.skill_05 is null AND
       MRec.skill_06 is null AND
       MRec.skill_07 is null AND
       MRec.skill_08 is null AND
       MRec.skill_09 is null AND
       MRec.skill_10 is null AND
       MRec.skill_11 is null AND
       MRec.skill_12 is null AND
       MRec.skill_13 is null AND
       MRec.skill_14 is null AND
       MRec.skill_15 is null AND
       MRec.skill_16 is null AND
       MRec.skill_17 is null AND
       MRec.skill_18 is null AND
       MRec.skill_19 is null AND
       MRec.skill_20 is null AND
       MRec.skill_21 is null AND
       MRec.skill_22 is null AND
       MRec.skill_23 is null AND
       MRec.skill_24 is null AND
       MRec.skill_25 is null AND
       MRec.skill_26 is null AND
       MRec.skill_27 is null AND
       MRec.skill_28 is null AND
       MRec.skill_29 is null AND
       MRec.skill_30 is null )then
      let ret = TRUE
   end if

  return ret
end function #NoSkills3

function NoSkills4()
   define
      ret smallint

   let ret = FALSE

   if( NRec.skill_01 is null AND
       NRec.skill_02 is null AND
       NRec.skill_03 is null AND
       NRec.skill_04 is null AND
       NRec.skill_05 is null AND
       NRec.skill_06 is null AND
       NRec.skill_07 is null AND
       NRec.skill_08 is null AND
       NRec.skill_09 is null AND
       NRec.skill_10 is null AND
       NRec.skill_11 is null AND
       NRec.skill_12 is null AND
       NRec.skill_13 is null AND
       NRec.skill_14 is null AND
       NRec.skill_15 is null AND
       NRec.skill_16 is null AND
       NRec.skill_17 is null AND
       NRec.skill_18 is null AND
       NRec.skill_19 is null AND
       NRec.skill_20 is null AND
       NRec.skill_21 is null AND
       NRec.skill_22 is null AND
       NRec.skill_23 is null AND
       NRec.skill_24 is null AND
       NRec.skill_25 is null AND
       NRec.skill_26 is null AND
       NRec.skill_27 is null AND
       NRec.skill_28 is null AND
       NRec.skill_29 is null AND
       NRec.skill_30 is null )then
      let ret = TRUE
   end if

  return ret
end function #NoSkills4

function NoSkills5()
   define
      ret smallint

   let ret = FALSE

   if( ORec.skill_01 is null AND
       ORec.skill_02 is null AND
       ORec.skill_03 is null AND
       ORec.skill_04 is null AND
       ORec.skill_05 is null AND
       ORec.skill_06 is null AND
       ORec.skill_07 is null AND
       ORec.skill_08 is null AND
       ORec.skill_09 is null AND
       ORec.skill_10 is null AND
       ORec.skill_11 is null AND
       ORec.skill_12 is null AND
       ORec.skill_13 is null AND
       ORec.skill_14 is null AND
       ORec.skill_15 is null AND
       ORec.skill_16 is null AND
       ORec.skill_17 is null AND
       ORec.skill_18 is null AND
       ORec.skill_19 is null AND
       ORec.skill_20 is null AND
       ORec.skill_21 is null AND
       ORec.skill_22 is null AND
       ORec.skill_23 is null AND
       ORec.skill_24 is null AND
       ORec.skill_25 is null AND
       ORec.skill_26 is null AND
       ORec.skill_27 is null AND
       ORec.skill_28 is null AND
       ORec.skill_29 is null AND
       ORec.skill_30 is null )then
      let ret = TRUE
   end if

  return ret
end function #NoSkills5

function NoEU()
   define
      ret smallint

   let ret = FALSE

   if( 
       URec.eu_pacificnw is null AND
       URec.eu_northca is null AND
       URec.eu_southwest is null AND
       URec.eu_northern is null AND
       URec.eu_plains is null AND
       URec.eu_heartland is null AND
       URec.eu_texas is null AND
       URec.eu_garden is null AND
       URec.eu_northeast is null AND
       URec.eu_delaware is null AND
       URec.eu_potomac is null AND
       URec.eu_carolinas is null AND
       URec.eu_midamerica is null AND
       URec.eu_ohio is null AND
       URec.eu_southeast is null AND
       URec.eu_sunshine is null AND
       URec.eu_ca is null AND
       URec.eu_fed is null )then

      let ret = TRUE
   end if

  return ret
end function  #NoEU

function NoIndustry()
   define
      ret smallint

   let ret = FALSE

   if( 
       URec.ind_eu is null AND
       URec.ind_tel is null AND
       URec.ind_me is null AND
       URec.ind_ret is null AND
       URec.ind_wd is null AND
       URec.ind_trans is null AND
       URec.ind_bank is null AND
       URec.ind_ins is null AND
       URec.ind_mfg is null AND
       URec.ind_hl is null AND
       URec.ind_gov is null AND
       URec.ind_cross is null )then

      let ret = TRUE
   end if

  return ret
end function  #NoIndustry

