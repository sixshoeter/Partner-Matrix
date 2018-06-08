
## November 24, 2013 John M. Shoemaker, expand to 30 skills
## September 22, 2015 - John M. Shoemaker, jshoe@us.ibm.com - add in Social Unit OU
## February 15, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #131 & #132
## February 16, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #134
## April    05, 2016 - John Shoemaker jshoemaker1@cox.net - function for storage certs #160
## August   11, 2016 - John Shoemaker jshoemaker1@cox.net - add BuildCntStr
## December 09, 2016 - John Shoemaker jshoemaker1@cox.net - migrate to competency #192
## January  09, 2017 - John Shoemaker jshoemaker1@cox.net - add function to get latest update dt #193
## January  27, 2017 - John Shoemaker jshoemaker1@cox.net - add function to get PW level, #196
## February 15, 2017 - John Shoemaker jshoemaker1@cox.net - use menu_str rather than brand name in title
## April    19, 2017 - John Shoemaker jshoemaker1@cox.net - add authorization check, 217
## May      21, 2017 - John Shoemaker jshoemaker1@cox.net - sync up columns for competency, 231
## May      24, 2017 - John M. Shoemaker jshoemaker1@cox.net, option for having upd mode at top, #232
## June     27, 2017 - John M. Shoemaker jshoemaker1@cox.net, add gsd solutions to array, #183
## August   25, 2017 - John M. Shoemaker jshoemaker1@cox.net, add function for currQtr, #250
## September21, 2017 - John M. Shoemaker jshoemaker1@cox.net, convert to Focus 5, #249
## September28, 2017 - John M. Shoemaker jshoemaker1@cox.net, change to support new format, #263
## October  10, 2017 John M. Shoemaker jshoemaker1@cox.net, replace Normalized revenue, #270
## November 28, 2017 John M. Shoemaker jshoemaker1@cox.net, merge AU and SU, #289
## February 02, 2018 John M. Shoemaker jshoemaker1@cox.net, add software in front of distributor, #308
## March    29, 2018 John M. Shoemaker jshoemaker1@cox.net, add markets, #317
## May       14, 2018 John M. Shoemaker sixshoeter@gmail.com, add MasterRec columns for dirs, #324


globals "globals.4gl"

function LoadActiveBrands( inmode, inceid )
define
   inmode smallint,
   inceid like coverage_ws.ceid,
   cnt, i smallint,
   SQLStr char(128),
   CRec record like control.*

for i =1 to 70
   let ActiveBrand[i] = FALSE
   let ProductionBrand[i] = FALSE
end for

## check for NC coverage
initialize CRec.* to NULL
call GetControlRec( "NC" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_nc "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID17 from SQLStr
   execute LABID17 into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_nc ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_nc ] = TRUE
      end if

   end if
end if 

## check for AU coverage
initialize CRec.* to NULL
call GetControlRec( "AU" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_au "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID11 from SQLStr
   execute LABID11 into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_au ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_au ] = TRUE
      end if

   end if
end if 

## check for SU coverage
initialize CRec.* to NULL
call GetControlRec( "SU" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_su "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID12 from SQLStr
   execute LABID12 into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_su ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_su ] = TRUE
      end if

   end if
end if 

## check for CU coverage
initialize CRec.* to NULL
call GetControlRec( "CU" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_cu "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID13 from SQLStr
   execute LABID13 into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_cu ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_cu ] = TRUE
      end if

   end if
end if 

## check for BU coverage
initialize CRec.* to NULL
call GetControlRec( "BU" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_bu "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID14 from SQLStr
   execute LABID14 into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_bu ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_bu ] = TRUE
      end if

   end if
end if 


## check for SE coverage
initialize CRec.* to NULL
call GetControlRec( "SE" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_se "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID15 from SQLStr
   execute LABID15 into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_se ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_se ] = TRUE
      end if

   end if
end if 


## check for ST coverage
initialize CRec.* to NULL
call GetControlRec( "ST" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_st "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID20 from SQLStr
   execute LABID20 into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_st ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_st ] = TRUE
      end if

   end if
end if 

## check for ES coverage
initialize CRec.* to NULL
call GetControlRec( "ES" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_es "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID21 from SQLStr
   execute LABID21 into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_es ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_es ] = TRUE
      end if

   end if
end if 


## check for WU coverage
initialize CRec.* to NULL
call GetControlRec( "WU" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_wu "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID22 from SQLStr
   execute LABID22 into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_wu ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_wu ] = TRUE
      end if

   end if
end if 

## check for IO coverage
initialize CRec.* to NULL
call GetControlRec( "IO" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_io "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID23 from SQLStr
   execute LABID23 into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_io ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_io ] = TRUE
      end if

   end if
end if 

## check for MC coverage
initialize CRec.* to NULL
call GetControlRec( "MC" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_mc "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABIDmc from SQLStr
   execute LABIDmc into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_mc ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_mc ] = TRUE
      end if

   end if
end if 


## check for MD coverage
initialize CRec.* to NULL
call GetControlRec( "MD" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_md "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABIDmd from SQLStr
   execute LABIDmd into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_md ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_md ] = TRUE
      end if

   end if
end if 



## check for MF coverage
initialize CRec.* to NULL
call GetControlRec( "MF" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_mf "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABIDmf from SQLStr
   execute LABIDmf into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_mf ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_mf ] = TRUE
      end if

   end if
end if 


## check for MI coverage
initialize CRec.* to NULL
call GetControlRec( "MI" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_mi "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABIDmi from SQLStr
   execute LABIDmi into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_mi ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_mi ] = TRUE
      end if

   end if
end if 


## check for MP coverage
initialize CRec.* to NULL
call GetControlRec( "MP" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_mp "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABIDmp from SQLStr
   execute LABIDmp into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_mp ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_mp ] = TRUE
      end if

   end if
end if 








## check for HW coverage
initialize CRec.* to NULL
call GetControlRec( "HW" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_hw "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID23a from SQLStr
   execute LABID23a into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_hw ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_hw ] = TRUE
      end if

   end if
end if 

## check for WS coverage
initialize CRec.* to NULL
call GetControlRec( "WS" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_ws "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID1 from SQLStr
   execute LABID1 into cnt
   
   if( cnt > 0 )then
      let ActiveBrand[ brand_ws ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_ws ] = TRUE
      end if

   end if
end if 

## check for IM coverage
initialize CRec.* to NULL
call GetControlRec( "IM" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_im "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID2 from SQLStr
   execute LABID2 into cnt
   if( cnt > 0 )then
      let ActiveBrand[ brand_im ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_im ] = TRUE
      end if

   end if
end if

## check for TI coverage
initialize CRec.* to NULL
call GetControlRec( "TI" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_ti "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID3 from SQLStr
   execute LABID3 into cnt
   if( cnt > 0 )then
      let ActiveBrand[ brand_ti ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_ti ] = TRUE
      end if

   end if
end if

## check for RA coverage
initialize CRec.* to NULL
call GetControlRec( "RA" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_ra "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID4 from SQLStr
      execute LABID4 into cnt
   if( cnt > 0 )then
      let ActiveBrand[ brand_ra ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_ra ] = TRUE
      end if

   end if
end if

## check for LO coverage
initialize CRec.* to NULL
call GetControlRec( "LO" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_lo "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID5 from SQLStr
   execute LABID5 into cnt
   if( cnt > 0 )then
      let ActiveBrand[ brand_lo ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_lo ] = TRUE
      end if

   end if
end if

## check for BA coverage
initialize CRec.* to NULL
call GetControlRec( "BA" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_ba "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID6 from SQLStr
   execute LABID6 into cnt
   if( cnt > 0 )then
      let ActiveBrand[ brand_ba ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_ba ] = TRUE
      end if

   end if
end if

## check for SE coverage
initialize CRec.* to NULL
call GetControlRec( "SE" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_se "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID7 from SQLStr
   execute LABID7 into cnt
   if( cnt > 0 )then
      let ActiveBrand[ brand_se ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_se ] = TRUE
      end if

   end if
end if

## check for IS coverage
initialize CRec.* to NULL
call GetControlRec( "IS" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_is "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID8 from SQLStr
   execute LABID8 into cnt
   if( cnt > 0 )then
      let ActiveBrand[ brand_is ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_is ] = TRUE
      end if

   end if
end if

## check for EM coverage
initialize CRec.* to NULL
call GetControlRec( "EM" ) returning CRec.*

if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_em "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID9 from SQLStr
   execute LABID9 into cnt
   if( cnt > 0 )then
      let ActiveBrand[ brand_em ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_em ] = TRUE
      end if

   end if
end if

## check for SC coverage
initialize CRec.* to NULL
call GetControlRec( "SC" ) returning CRec.*
if( CRec.active_brand )then
   let cnt = 0
   let SQLStr="select count(*) from coverage_sc "
   if( inmode = 1 ) then
      let SQLStr = SQLStr clipped, "  where ceid = '", inceid clipped, "'"
   end if
   
   prepare LABID10 from SQLStr
   execute LABID10 into cnt
   if( cnt > 0 )then
      let ActiveBrand[ brand_sc ] = TRUE
      if( CRec.production )then
            let ProductionBrand[ brand_sc ] = TRUE
      end if

   end if
end if

{
#debug
for cnt = 1 to 10
   display ActiveBrand[cnt]
end for
display "<p>"
for cnt = 1 to 10
   display ProductionBrand[cnt]
end for
}

end function #LoadActiveBrands

function BuildCntStr( inBrand, outFlg )
define
   inBrand char(2),
   outFlg smallint,
   outStr char(6),
   qtrStr char(256)

if( outFlg )then
   let outStr = "outer"
else
   let outStr = " "
end if

case inBrand
   when 'AU'
       let qtrStr = "select count(*) from ", cov_tab clipped, " a, ", outStr clipped, " skills_a1 k, ", outStr clipped, " skills_a2 l, ", outStr clipped, " skills_a3 m, ", outStr clipped, " skills_a4 c, ", outStr clipped, " skills_a5 d "
   when 'SU'
       let qtrStr = "select count(*) from ", cov_tab clipped, " a, ", outStr clipped, " skills_s1 k, ", outStr clipped, " skills_s2 l, ", outStr clipped, " skills_s3 m, ", outStr clipped, " skills_s4 n, ", outStr clipped, " skills_s5 o "
#   when 'BU'
#       let qtrStr = "select a.*, k.* from ", cov_tab clipped, " a, ", outStr clipped, " skills_co k "

   when 'BU'
       let qtrStr = "select count(*) from ", cov_tab clipped, " a, ", outStr clipped, " skills_b1 k, ", outStr clipped, " skills_b2 l, ", outStr clipped, " skills_b3 m, ", outStr clipped, " skills_b4 n " 

   when 'ST'
       let qtrStr = "select count(*) from ", cov_tab clipped, " a, ", outStr clipped, " skills_sw k, ", outStr clipped, " skills_sh l, ", outStr clipped, " skills_sv m " 

   otherwise
       let qtrStr = "select count(*) from ", cov_tab clipped, " a, ", outStr clipped, " ", skill_tab clipped, " k "
end case

return qtrStr

end function  #BuildCntStr


function BuildBaseStr( inBrand, outFlg )
define
   inBrand char(2),
   outFlg smallint,
   outStr char(6),
   qtrStr char(256)

if( outFlg )then
   let outStr = "outer"
else
   let outStr = " "
end if

case inBrand
   when 'AU'
       let qtrStr = "select a.*, k.*, l.*, m.* from ", cov_tab clipped, " a, ", outStr clipped, " skills_a1 k, ", outStr clipped, " skills_a2 l, ", outStr clipped, " skills_a3 m, ", outStr clipped, " skills_a4 c, ", outStr clipped, " skills_a5 d "
   when 'SU'
       let qtrStr = "select a.*, k.*, l.*, m.*, n.*, o.* from ", cov_tab clipped, " a, ", outStr clipped, " skills_s1 k, ", outStr clipped, " skills_s2 l, ", outStr clipped, " skills_s3 m, ", outStr clipped, " skills_s4 n, ", outStr clipped, " skills_s5 o "
#   when 'BU'
#       let qtrStr = "select a.*, k.* from ", cov_tab clipped, " a, ", outStr clipped, " skills_co k "

   when 'BU'
       let qtrStr = "select a.*, k.*, l.*, m.*, n.* from ", cov_tab clipped, " a, ", outStr clipped, " skills_b1 k, ", outStr clipped, " skills_b2 l, ", outStr clipped, " skills_b3 m, ", outStr clipped, " skills_b4 n " 

   when 'ST'
       let qtrStr = "select a.*, k.*, l.*, m.* from ", cov_tab clipped, " a, ", outStr clipped, " skills_sw k, ", outStr clipped, " skills_sh l, ", outStr clipped, " skills_sv m " 

   otherwise
       let qtrStr = "select a.*, k.* from ", cov_tab clipped, " a, ", outStr clipped, " ", skill_tab clipped, " k "
end case

return qtrStr

end function  #BuildBaseStr

function BuildBaseStr2( useRev, outFlg )
define
   useRev smallint,
   outFlg smallint,
   outStr char(6),
   qtrStr char(128)

if( outFlg )then
   let outStr = "outer"
else
   let outStr = " "
end if

let qtrStr = "select a.*, k.*, r.* from ", cov_tab clipped, " a, ", outStr clipped, " ", skill_tab clipped, " k ", "outer tbptv r"

return qtrStr

end function  #BuildBaseStr2

function BuildBaseExtendStr( inBrand, outFlg )
define
   inBrand char(2),
   outFlg smallint,
   outStr char(6),
   qtrStr char(256)

if( outFlg )then
   let outStr = "outer"
else
   let outStr = " "
end if

let qtrStr = "select a.* from ", cov_tab clipped, " a, ", outStr clipped, " CtlRec.coverextend_tab b " 

return qtrStr

end function  #BuildBaseExtendStr

function LoadSkills( )
define
   i, idx,dbidx smallint

for i = 1 to SkillsMax

   let dbidx =  SkillArr[i].db_num

   case dbidx
      when 1
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_01

      when 2
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_02

      when 3
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_03

      when 4
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_04

      when 5
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_05

      when 6
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_06

      when 7
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_07

      when 8
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_08

      when 9
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_09

      when 10
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_10

      when 11
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_11

      when 12
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_12

      when 13
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_13

      when 14
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_14

      when 15
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_15

      when 16
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_16

      when 17
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_17

      when 18
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_18

      when 19
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_19

      when 20
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_20

      when 21
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_21

      when 22
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_22

      when 23
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_23

      when 24
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_24

      when 25
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_25

      when 26
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_26

      when 27
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_27

      when 28
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_28

      when 29
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_29

      when 30
         let idx =  SkillArr[i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_30

   end case
end for

let GSkillDt = KRec.updtime

end function ##LoadSkills


function LoadSkillsU( inBrand, inbIdx )
define
   inBrand like brands.b_id,
   inbIdx like brands.b_ord,
   i, idx,dbidx smallint,
   bIdx like brands.b_ord,
   SQLStr char(64)

#   let SQLStr = "select a.b_ord from brands a where a.b_id='", inBrand clipped, "'"
#   prepare LSU1 from SQLStr
#   execute LSU1 into bIdx

#display "SQLStr: ", SQLStr clipped, " SkillsMaxU: ", SkillsMaxU, " inbIdx: ", inbIdx
#display "KRec: ", KRec.*

for i = 1 to SkillsMaxU

   let dbidx =  SkillArrU[inbIdx, i].db_num

   case dbidx
      when 1
         let idx =  SkillArrU[inbIdx, i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_01

      when 2
         let idx =  SkillArrU[inbIdx, i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_02

      when 3
         let idx =  SkillArrU[inbIdx, i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_03

      when 4
         let idx =  SkillArrU[inbIdx, i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_04

      when 5
         let idx =  SkillArrU[inbIdx, i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_05

      when 6
         let idx =  SkillArrU[inbIdx, i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_06

      when 7
         let idx =  SkillArrU[inbIdx, i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_07

      when 8
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_08

      when 9
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_09

      when 10
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_10

      when 11
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_11

      when 12
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_12

      when 13
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_13

      when 14
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_14

      when 15
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_15

      when 16
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_16

      when 17
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_17

      when 18
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_18

      when 19
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_19

      when 20
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_20

      when 21
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_21

      when 22
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_22

      when 23
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_23

      when 24
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_24

      when 25
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_25

      when 26
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_26

      when 27
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_27

      when 28
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_28

      when 29
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_29

      when 30
         let idx =  SkillArrU[inbIdx,i].s_num
         let BPSkillsArr[ idx ] = KRec.skill_30

   end case

#display "IDX: ", idx, " inbIdx: ", inbIdx, " i: ", i
end for

let GSkillDt = KRec.updtime

end function ##LoadSkillsU

function LoadSolutions( in_ceid )
define
   in_ceid like vap.ceid,
   i smallint,
   SQLStr char(128)

let SQLStr = "select a.* from solutions a where a.ceid='", in_ceid clipped, "'"
prepare V0ID from SQLStr
declare V0Curs cursor for V0ID

let i = 0
foreach V0Curs into SolutionArr[i+1].*
   let i = i + 1
end foreach

return i

end function  #LoadSolutions

function LoadVAP( in_ceid )
define
   in_ceid like vap.ceid,
   i smallint,
   SQLStr char(128)

let SQLStr = "select a.* from vap a where a.ceid='", in_ceid clipped, "'"
prepare V1ID from SQLStr
declare VCurs cursor for V1ID

let i = 0
foreach VCurs into VAPArr[i+1].*
   let i = i + 1
end foreach

return i

end function  #LoadVAP


function GetVAPforBrand(inBrand, inIDX)
define
   inBrand like brands.b_id,
   inIDX smallint,
   retStr char(128)

initialize retStr to NULL

case inBrand

   when 'AU'
      if( VAPArr[inIDX].an_cloud_open is not NULL )then
          let retStr = retStr clipped, "Cloud Open<br />"
      end if
      if( VAPArr[inIDX].an_plat_open is not NULL )then
          let retStr = retStr clipped, "Platform Open<br />"
      end if
      if( VAPArr[inIDX].an_sol_open is not NULL )then
          let retStr = retStr clipped, "Solution Open<br />"
      end if
      if( VAPArr[inIDX].adv_an is not NULL )then
          let retStr = retStr clipped, "Advanced Analytics<br />"
      end if
      if( VAPArr[inIDX].pred_an is not NULL )then
          let retStr = retStr clipped, "Predictive Analytics<br />"
      end if
      if( VAPArr[inIDX].pres_an is not NULL )then
          let retStr = retStr clipped, "Prescriptive Analytics<br />"
      end if
      if( VAPArr[inIDX].iig is not NULL )then
          let retStr = retStr clipped, "IIG<br />"
      end if
      if( VAPArr[inIDX].risk_comp is not NULL )then
          let retStr = retStr clipped, "Risk & Compliance<br />"
      end if
       if( VAPArr[inIDX].ecm is not NULL )then
          let retStr = retStr clipped, "ECM<br />"
       end if

   when 'SU'
      
   when 'ST'
       if( VAPArr[inIDX].spec_stor is not NULL )then
          let retStr = retStr clipped, "Open<br />"
       end if

   when 'CU'
   when 'ES'
   when 'BU'
   when 'SE'
   when 'WU'
   when 'IO'
   when 'HW'

   when 'IM'

   when 'EM'


   when 'SC'

   when 'RA'

   when 'TI'

   when 'WS'

end case

   return retStr

end function  #GetVAPforBrand


function IsValidVAPforBrand(inBrand, inIDX)
define
   inBrand like brands.b_id,
   inIDX smallint,
   ret smallint

let ret = FALSE

case inBrand
   when 'AU'
      if( 
          VAPArr[inIDX].an_cloud_open is not NULL 
       OR VAPArr[inIDX].an_plat_open is not NULL
       OR VAPArr[inIDX].an_sol_open is not NULL
       OR VAPArr[inIDX].adv_an is not NULL
       OR VAPArr[inIDX].pred_an is not NULL 
       OR VAPArr[inIDX].pres_an is not NULL 
       OR VAPArr[inIDX].iig is not NULL 
       OR VAPArr[inIDX].risk_comp is not NULL 
       OR VAPArr[inIDX].ecm is not NULL )then
          let ret = TRUE
       end if
   when 'SU'

   when 'ST'
      if( 
          VAPArr[inIDX].spec_stor is not NULL )then
          let ret = TRUE
       end if

end case

   return ret

end function  #IsValidVAPforBrand

function LoadCrossRec( in_ceid )
define
   in_ceid like cross.ceid,
   SQLStr char(128)

if( CtlRec.coverextend_tab is not NULL and CtlRec.coverextend_tab != " " and in_ceid is not NULL) then
   let SQLStr = "select a.* from ", CtlRec.coverextend_tab clipped, " a where a.ceid = '", in_ceid clipped, "'"
   prepare LCRID from SQLStr
   execute LCRID into CRec.*
   let G_CrossAvail = TRUE
end if

end function  #LoadCrossRec

function getRepLink( inName )
define
   inName like reps.r_name,
   retStr like reps.r_link,
   SQLStr char(128)

initialize SQLStr to NULL
let retStr = " "

whenever error continue
if( inName is not null and inName != " " and inName != "NA" ) then
   let SQLStr = 'select r.r_link from reps r where r.r_name = "', inName clipped, '"'
#   display "inName: ", inName clipped, ":", SQLStr
   prepare GRLID1 from SQLStr
   if( sqlca.sqlcode = 0 )then 
      execute GRLID1 into retStr
   else
#      display "SQLCODE: ", sqlca.sqlcode 
      let retStr = " "
   end if
else
#   display "inName: ", inName clipped
   let retStr = " "
end if

return retStr

end function  #getRepLink


function GetState( inStateID )
define
   inStateID like states.s_id,
   retStr like states.s_name,
   SQLStr char(64)

initialize retStr to NULL

if( inStateID is not NULL and inStateID != " " )then

   let SQLStr = "select a.s_name from states a where a.s_id='", inStateID clipped, "'"
   prepare GSID from SQLStr
   execute GSID into retStr

end if

return retStr


end function  #GetState

function LoadSkillCat( inBrand )
define
   inBrand like brands.b_id,
   i smallint,
   sqlStr char(128)

let i = 0
let sqlStr = "select a.* from skill_cat a where a.c_brand='", inBrand clipped, "' order by a.c_id"
prepare LSCID from sqlStr
declare LSCcurs cursor for LSCID

foreach LSCcurs into SkillCatArr[i+1].*
   let i = i + 1
end foreach


return i

end function  #LoadSkillCat

function GetSkillCatDesc ( incat )
define
   incat smallint,
   retStr like skill_cat.c_long

   let retStr = SkillCatArr[ incat ].c_long

#display incat, retStr
   return retStr
 
end function  #GetSkillCatDesc


function BuildProdStr( IncludeFlg, currStr, newStr )
define
   IncludeFlg smallint,
   currStr, newStr, retStr char(128)

   if( IncludeFlg )then
      if( currStr is not NULL )then
         if( newStr is not NULL )then
            let retStr = currStr clipped, ", ", newStr
         else
            let retStr = currStr
         end if
      else
            let retStr = newStr 
      end if
   else
      let retStr = currStr
   end if

   return retStr

end function  #BuildProdStrinStr

function MatchProd(counter, flg )
define
   counter smallint,
   flg char(1),
   nflg smallint,
   ret smallint

   if( flg = "1" )then
      let nflg = 1
   else
      if( flg = "" or flg = " ") then 
         let nflg = 0
      end if
   end if

   if( counter = nflg )then
      let ret = TRUE
   else
      let ret = FALSE
   end if
   
#   display ">", "counter:", counter, "nflg:", nflg, "ret:", ret
   return ret

end function  #MatchProd

function LoadContactArr( in_ceid )
define
   in_ceid like contacts_ws.c_ceid,
   Cnt smallint,
   SQLStr char(128)

#load the ContactArr and set G_ContactCnt
   let SQLStr = "select a.* from ", cont_tab clipped, " a where a.c_ceid='", in_ceid clipped, "' order by c_name"
   prepare ContactID from SQLStr
   declare ContactCurs cursor for ContactID
   let Cnt=0

   foreach ContactCurs into ContactArr[Cnt+1].*
      let Cnt=Cnt + 1
   end foreach
   let G_ContactCnt = Cnt

end function  #LoadContactArr

function LoadContactArr2( in_ceid, in_region, in_eu )
define
   in_ceid like contacts_ws.c_ceid,
   in_region like contacts_ws.e_region,
   in_eu like contacts_ws.e_name,
   Cnt smallint,
   SQLStr char(256)

#load the ContactArr and set G_ContactCnt
   let SQLStr = "select a.* from ", cont_tab clipped, " a where a.c_ceid='", in_ceid clipped, "' "

   if( in_region is not null )then
      if( in_region != ' ' )then
         let SQLStr = SQLStr clipped, " and a.e_region = '", in_region clipped, "' "
      else
         let SQLStr = SQLStr clipped, " and (a.e_region is null or a.e_region = ' ' or a.e_region='<none>')"
      end if

      if( in_eu is not null and in_eu != ' ' )then
         let SQLStr = SQLStr clipped, " and a.e_name = '", in_eu clipped, "' "
      else
         if( in_eu = ' ' )then
            let SQLStr = SQLStr clipped, " and (a.e_name is null or a.e_name = ' ' or a.e_name='<none>') "
         end if
      end if
   end if
{
   if( in_region is not null and in_region != ' ' )then
      let SQLStr = SQLStr clipped, " and a.e_region = '", in_region clipped, "' "
   else
      if( in_region = ' ' )then
         let SQLStr = SQLStr clipped, " and a.e_region is null "
      end if

      if( in_eu is not null and in_eu != ' ' )then
         let SQLStr = SQLStr clipped, " and a.e_name = '", in_eu clipped, "' "
      else
         if( in_eu = ' ' )then
            let SQLStr = SQLStr clipped, " and a.e_name is null "
         end if
      end if
   end if
}
   let SQLStr = SQLStr clipped, " order by c_name"
#display SQLStr
   prepare Contact2ID from SQLStr
   declare Contact2Curs cursor for Contact2ID
   let Cnt=0

   foreach Contact2Curs into ContactArr[Cnt+1].*
      let Cnt=Cnt + 1
   end foreach
   let G_ContactCnt = Cnt

   return G_ContactCnt

end function  #LoadContactArr2

function GetCatCnt( inBrand, inCat )
define
   inBrand like brands.b_id,
   inCat smallint,
   cnt,
   sqlStr char(128)

let cnt = 0
let sqlStr = "select count(*) from skill a where a.b_id='", inBrand clipped, "' and a.c_id=", inCat
prepare GCCID from sqlStr
execute GCCID into cnt

return cnt

end function  #GetCatCnt

function LoadSkillRec( inBrand, inceid )
define
   inBrand like brands.b_id,
   inceid char(10),
   SQLStr char(128),
   skillStr char(128),
   skill_tab char(20),
   SkilledYN smallint

   let SkilledYN = FALSE

if( UnitModeYN() )then
   let skillStr = "select a.skill_tab1 from control a where a.brand = '", inBrand clipped, "'"
   prepare SSLK1ID from skillStr
   execute SSLK1ID into skill_tab
end if  #UnitModeYN

#   case inBrand
#      when "IM"
#         let skill_tab = "skills_im"
#      when "EM"
#         let skill_tab = "skills_em"
#      when "BA"
#         let skill_tab = "skills_ba"
#   end case
   
   let SQLStr = "select a.* from ", skill_tab clipped, " a where a.ceid='", inceid clipped, "'"
#display SQLStr
   prepare SR1ID from SQLStr
   declare SR1Curs cursor for SR1ID

   foreach SR1Curs into KRec.*
      if( KRec.skill_01 > 0 or KRec.skill_02 > 0 or KRec.skill_03 > 0 or KRec.skill_04 > 0 or
          KRec.skill_05 > 0 or KRec.skill_06 > 0 or KRec.skill_07 > 0 or KRec.skill_08 > 0 or
          KRec.skill_09 > 0 or KRec.skill_10 > 0 or KRec.skill_11 > 0 or KRec.skill_12 > 0 or
          KRec.skill_13 > 0 or KRec.skill_14 > 0 or KRec.skill_15 > 0 or KRec.skill_16 > 0 or
          KRec.skill_17 > 0 or KRec.skill_18 > 0 or KRec.skill_19 > 0 or KRec.skill_20 > 0 or
          KRec.skill_21 > 0 or KRec.skill_22 > 0 or KRec.skill_23 > 0 or KRec.skill_24 > 0 or
          KRec.skill_25 > 0 or KRec.skill_26 > 0 or KRec.skill_27 > 0 or KRec.skill_28 > 0 or
          KRec.skill_29 > 0 or KRec.skill_30 > 0 )then
         let SkilledYN = TRUE
      end if
   end foreach

   return SkilledYN

end function  #LoadSkillRec

function UnitModeYN()

#display "G_UnitMode: ", G_UnitMode

   if( G_UnitMode = "1" )then
      return TRUE
   else
      return FALSE
   end if

end function  #UnitModeYN

function GetBrandName( inbID )
define
   inbID like brands.b_id,
   tb_name like brands.b_name,
   SQLStr char(128)

   let SQLStr = "select a.b_name from brands a where a.b_id='", inbID clipped, "'"
   prepare GBN1ID from SQLStr
   execute GBN1ID into tb_name

   return tb_name

end function  #GetBrandName

{
function showSkillCell( inIdx, colorStr )
define
   inIdx smallint,
   colorStr char(7),
   ret char(256)

   if( inIdx > 0 )then
      if( UpdateAllow )then
         let ret = "<td class='centerText'; style='background-color: ", colorStr, "'><strong>", "<INPUT NAME='bd1' VALUE=", inIdx using '##', "></strong></td>"
      else
         let ret = "<td class='centerText'; style='background-color: ", colorStr, "'><strong>", inIdx using "##", "</strong></td>"
      end if
   else
      if( UpdateAllow )then
         let ret = "<td class='whiteText'; style='background-color: ", colorStr, "'><INPUT NAME='bd1' VALUE=></td>"
      else
         let ret = "<td class='whiteText'; style='background-color: ", colorStr, "'>.</td>"
      end if
   end if
#display "inIdx:", inIdx
#display "colorStr:", colorStr
#display "RET: ", ret
   return ret

end function  #showSkillCell
}

function noSpaces(inText)
define
   inText char(64),
   rtText char(64),
   i,l smallint

   let l = length(inText)

   for i = 1 to l
      if( inText[i] = ' ' )then
         let rtText[i]='_'
      else
         let rtText[i]=inText[i]
      end if
   end for

   return rtText

end function  #noSpaces

function GetSSRStr()

define
   SSRStr char(200)

   initialize SSRStr to NULL

   if( URec.ssr is not null and URec.ssr != ' ')then
#      let LinkStr = getRepLink( inName )
      let SSRStr = "<span style='font-size: 8px'>(", URec.ssr clipped
   end if

   if(SSRStr is not NULL )then
      let SSRStr = SSRStr clipped, ")</span>"
   end if
return SSRStr

end function  #GetSSRStr

function GetStorageCertStr ( in_brand, in_ceid )
define
   in_brand like brands.b_id,
   in_ceid like storage_cert.ceid,
   SCRec record like storage_cert.*,
   i smallint,
   retStr1 char(20),
   retStr2 char(20),
   SQLStr char(512)

   let i = 0
   let retStr1 = " "
   let retStr2 = " "
   let SQLStr = "select a.* from storage_cert a where a.ceid='", in_ceid clipped, "'"
   prepare GSCID from SQLStr
   declare GSCCurs cursor for GSCID

   foreach GSCCurs into SCRec.*
      if( SCRec.prod_cert is not null and SCRec.prod_cert != ' ' )then
         let i = i + 1
         case i
            when 1
               let retStr1 = SCRec.prod_cert
            when 2
               let retStr2 = SCRec.prod_cert
         end case
      end if
   end foreach

   return retStr1, retStr2

end function  #GetStorageCertStr

function GetGlobalMsg( )
define
   retStr like master.global_msg
#   MasterRec record like master.*,
#   SQLStr char(128)

   initialize retStr to NULL
#   let SQLStr = "select a.* from master a"
#   prepare MSID from SQLStr
#   execute MSID into MasterRec.*

   if( MasterRec.global_flg )then
      let retStr = MasterRec.global_msg
   end if

   return retStr clipped

end function  #GetGlobalMsg

function ListBoxVAD( inSel )
define
   inSel like coverage_au.vad,
   sqlStr char(64),
   VADRec record like vads.*

#  set search item to na if not provided
   if( inSel is NULL or inSel = " " )then
      let inSel = "na"
   end if

   let sqlStr = "select a.* from vads a "
   prepare LBVID from sqlStr
   declare LBVCurs cursor for LBVID

   display "Software Distributor: <SELECT NAME='vad'>"

   foreach LBVCurs into VADRec.*
   if( inSel = VADRec.v_id )then
      display "<OPTION SELECTED>", VADRec.v_id clipped
   else
      display "<OPTION>", VADRec.v_id clipped
   end if

   end foreach

   display "</SELECT><br>"
end function  #ListBoxVAD

function ListBoxPOD( inSel )
define
   inSel like coverage_au.pod,
   sqlStr char(64),
   PODRec record like pod_info.*

   let sqlStr = "select a.* from pod_info a "
   prepare LBPODID from sqlStr
   declare LBPODCurs cursor for LBPODID

   display "POD: <SELECT NAME='pod'>"

   foreach LBPODCurs into PODRec.*
   if( inSel = PODRec.pod )then
      display "<OPTION SELECTED>", PODRec.pod clipped
   else
      display "<OPTION>", PODRec.pod clipped
   end if

   end foreach

   display "</SELECT><br>"
end function  #ListBoxPOD

function LoadCompArr( inBrand, inCEID )
define
   inBrand like brand_bu.brand,
   inCEID like competency.ceid,
   Cnt smallint,
   SQLStr char(512)

## load the Competency Arrays
   let SQLStr = "select b.bu, b.comp_name, b.level, b.sols, b.rev_norm_curr_yr, b.rev_curr_resale_yr, b.rev_curr_influence_yr, b.rev_curr_xaas_yr, spec_prog_pct, ",
                "exp_prog_pct, sum(sol_id) gsd_sum from competency b, brand_bu a, outer gsd_solutions c where a.bu=b.bu and a.brand='", inBrand clipped, "' and b.ceid='", inCEID clipped, "' and b.ceid=c.ceid and b.comp_name=c.comp_name"
#   let SQLStr = "select unique b.bu, b.comp_name, b.achieved_level, b.sols, b.rev_norm_curr_yr, spec_prog_pct, exp_prog_pct from competency b, brand_bu a where a.bu=b.bu and a.brand='", inBrand clipped, "' and b.ceid='", inCEID clipped, "'"
   if( not CtlRec.showcompwithnorev )then
      let SQLStr = SQLStr clipped, " and b.level in ('Specialist','Expert') "
   end if  #if not CtlRec.showcompwithrev

   let SQLStr = SQLStr clipped, " group by 1,2,3,4,5,6,7,8,9,10 order by 1,2"

#display SQLStr
   prepare COMP1ID from SQLStr
   declare COMP1Curs cursor for COMP1ID
   let Cnt = 0
   foreach COMP1Curs into CompArr[Cnt+1].*
      let Cnt=Cnt+1
   end foreach
   let G_COMPcnt = Cnt

## load the Competency Arrays
   let SQLStr = "select unique b.bu, b.comp_name from competency b, brand_bu a where a.bu=b.bu and a.brand='", inBrand clipped, "' order by 1,2"

#display SQLStr
   prepare COMP2ID from SQLStr
   declare COMP2Curs cursor for COMP2ID
   let Cnt = 0
   foreach COMP2Curs into Comp2Arr[Cnt+1].*
      let Cnt=Cnt+1
   end foreach
   let G_COMP2cnt = Cnt


end function  #LoadCompArr

function GetPWLevel( inCEID )
define
   inCEID like competency.ceid,
   RetStr like competency.pw_level,
   SQLStr char(256)

   initialize RetStr to NULL
   let SQLStr = "select first 1 pw_level from competency where ceid='", inCEID clipped, "'"
   prepare GOPW1ID from SQLStr
   execute GOPW1ID into RetStr

   return RetStr
end function  #GetPWLevel

function LoadSVPInfoArr( inBrand, inCEID )
define
   inBrand like svp.s_brand,
   inCEID like svp_info.ceid,
   Cnt smallint,
   SQLStr char(256)

for Cnt = 1 to 20
   initialize SVPInfoArr[Cnt].* to NULL
end for
## load the SVP List Array
   let SQLStr = "select unique b.prod_grp_desc, a.svp_name, a.comp_name, b.prod_grp_stat, a.s_id from svp_info b, svp a where a.svp_name=b.prod_grp_desc and a.s_brand='", inBrand clipped, "' and b.ceid='", inCEID clipped, "' and b.prod_grp_stat='Approved' order by a.s_id"

#display SQLStr
   prepare SVP1ID from SQLStr
   declare SVP1Curs cursor for SVP1ID
   let Cnt = 0
   foreach SVP1Curs into SVPInfoArr[Cnt+1].*
#      display "Cnt: ", Cnt, " - ", SVPInfoArr[Cnt+1].prod_grp_desc clipped
      let Cnt=Cnt+1
   end foreach

   return Cnt

end function  #LoadSVPInfoArr

function isSVPauth( in_svp )
define
   in_svp like svp_info.prod_grp_desc,
   i smallint,
   retFlag smallint

   let retFlag = FALSE

   for i = 1 to 10
#display "i: ", i, BPTVArr[i].rag clipped, ":", in_svp clipped
      if( SVPInfoArr[i].prod_grp_desc = in_svp )then
         let retFlag = TRUE
         exit for
      end if
   end for

   return retFlag

end function  ##isSVPauth


function CleanUp( inStr )
define
   inStr char(8100),
   outStr char(8100),
   i,j,l smallint

   let l = length( inStr )
   let outStr = inStr
   for i = 1 to l
      if( outStr[i,i] = "+" )then
         let outStr[i,i] = " "
      end if
   end for

   for i = 1 to l-3
#      if( outStr[i,i+5] = "%0D%OA" )then
#         let outStr[i,i+2] = "<p>"
#         let outStr[i+1,l] = outStr[i+6,l]
#      end if
      if( outStr[i,i] = "+" )then
         let outStr[i,i] = " "
      end if
      if( outStr[i,i+2] = "%0A" )then
         let outStr[i,i] = " "
         let outStr[i+1,l] = outStr[i+3,l]
      end if

      if( outStr[i,i+2] = "%0D" )then
         let outStr[i,i] = " "
         let outStr[i+1,l] = outStr[i+3,l]
      end if

      if( outStr[i,i+2] = "%40" )then
         let outStr[i,i] = "@"
         let outStr[i+1,l] = outStr[i+3,l]
      end if

      if( outStr[i,i+2] = "%20" )then
         let outStr[i,i] = " "
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%21" )then
         let outStr[i,i] = "!"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%22" )then
         let outStr[i,i] = "'"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%23" )then
         let outStr[i,i] = "#"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%24" )then
         let outStr[i,i] = "$"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%25" )then
         let outStr[i,i] = "%"
         let outStr[i+1,l] = outStr[i+3,l]
	 end if
      if( outStr[i,i+2] = "%26" )then
         let outStr[i,i] = "&"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%27" )then
         let outStr[i,i] = "'"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%28" )then
         let outStr[i,i] = "("
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%29" )then
         let outStr[i,i] = ")"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%2A" )then
         let outStr[i,i] = "*"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%2B" )then
         let outStr[i,i] = "+"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%2C" )then
         let outStr[i,i] = ","
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%2D" )then
         let outStr[i,i] = "-"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%2E" )then
         let outStr[i,i] = "."
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%2F" )then
         let outStr[i,i] = "/"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3A" )then
         let outStr[i,i] = ":"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3B" )then
         let outStr[i,i] = ";"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3C" )then
         let outStr[i,i] = "<"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3D" )then
         let outStr[i,i] = "="
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3E" )then
         let outStr[i,i] = ">"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3F" )then
         let outStr[i,i] = "?"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%40" )then
         let outStr[i,i] = "@"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%92" )then
         let outStr[i,i] = "'"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%96" )then
         let outStr[i,i] = "'"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
   end for

   return outStr

end function  #CleanUp


function ShowTitle( showHeader )
define
   showHeader smallint,
   globStr like master.global_msg

   call GetGlobalMsg() returning globStr
   call Header(8, IRec.i_id, BRec.b_id, showHeader)     #8-partner details

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", CtlRec.menu_str clipped, "</span></em></div>"
if( globStr is not NULL )then
   display "<div dir='ltr' style='text-align: center'>"
   display "<em><span style='font-size: 20px'>", globStr clipped,"</span></em></div>"
end if  #globStr

display "<p>"

end function  #ShowTitle

function ShowTitleDetailS( showHeader, inCEID, UpdAllow )
define
   showHeader smallint,
   inCEID like coverage_au.ceid,
   UpdAllow smallint,
   globStr like master.global_msg

   call GetGlobalMsg() returning globStr
   call Header(8, IRec.i_id, BRec.b_id, showHeader)     #8-partner details
   display "<div dir='ltr' style='text-align: center; position: absolute; top: 5px; width: 100%;'>"
   display "<em><span style='font-size: 12px'>", IRec.i_name clipped, " * ", CtlRec.menu_str clipped, " &nbsp ", globStr clipped, "</span></em></div>"

   display "<p>"

end function  #ShowTitleDetailS

function ShowTitleDetail( showHeader, inCEID, UpdAllow )
define
   showHeader smallint,
   inCEID like coverage_au.ceid,
   UpdAllow smallint,
   globStr like master.global_msg

   call GetGlobalMsg() returning globStr
   call Header(8, IRec.i_id, BRec.b_id, showHeader)     #8-partner details

   if( globStr is not NULL )then
      if( CtlRec.showupdtop )then
         if( not UpdAllow )then
            display "<FORM ID='upd' ACTION='/", MasterRec.cgi_dir clipped, "/setupUpd", BRec.b_id clipped, ".ksh'>"
            display "<div style='float: right'>"
            display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", inCEID clipped, ">"
            display "EMAIL: <INPUT NAME='yname' TYPE=email size=20 required autocomplete='on'>"
	    display "</div>"
         end if
         display "<div dir='ltr' style='text-align: center'>"
         display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", CtlRec.menu_str clipped,"</span></em></div>"

         if( not UpdAllow )then
            display "<div style='float: right'>"
            display "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PIN: <INPUT NAME='yid' TYPE=password size=8 required></div>"
         end if
         display "<div dir='ltr' style='text-align: center'>"
         display "<em><span style='font-size: 20px'>", globStr clipped,"</span></em></div>"

         if( not UpdAllow )then
	    display "<div dir='ltr' style='text-align: right'>"
	    display "<INPUT TYPE=submit VALUE='UPDATE'></div>"
            display "<div dir='ltr' style='text-align: right'>"
            display "<em><span style='font-size: 10px'>Authorized Users Only</span></em></div>"
            display "</div>"
	    display "</FORM>"
         end if
      else
         display "<div dir='ltr' style='text-align: center'>"
         display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", CtlRec.menu_str clipped,"</span></em></div>"
         display "<div dir='ltr' style='text-align: center'>"
         display "<em><span style='font-size: 20px'>", globStr clipped,"</span></em></div>"
      end if  #CtlRec.showupdtop

   end if  #globStr

   display "<p>"

end function  #ShowTitleDetail

function LastUpdt( inBrand )
define
   inBrand like brands.b_id,
   retDt datetime year to minute,
   tmptName char(16),
   lastDtRec record
      mo smallint,
      dy smallint,
      yr smallint,
      hrmi char(5)
   end record,

   SQLStr char(512)

   let tmptName = "_t1time", inBrand clipped
   let SQLStr = "create table ", tmptName clipped, " (lupdt datetime year to minute);"
   prepare ludtID0 from SQLStr 
   execute ludtID0

   let SQLStr = "insert into ", tmptName clipped, " select max(updtime) lupdt from ", cov_tab clipped, ";"
   if( CtlRec.skill_tab1 is not null and CtlRec.skill_tab1 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab1 clipped, ";"
   end if
   if( CtlRec.skill_tab2 is not null and CtlRec.skill_tab2 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab2 clipped, ";"
   end if
   if( CtlRec.skill_tab3 is not null and CtlRec.skill_tab3 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab3 clipped, ";"
   end if
   if( CtlRec.skill_tab4 is not null and CtlRec.skill_tab4 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab4 clipped, ";"
   end if
   if( CtlRec.skill_tab5 is not null and CtlRec.skill_tab5 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab5 clipped, ";"
   end if
   if( CtlRec.skill_tab6 is not null and CtlRec.skill_tab6 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab6 clipped, ";"
   end if
   if( CtlRec.skill_tab7 is not null and CtlRec.skill_tab7 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab7 clipped, ";"
   end if
   if( CtlRec.skill_tab8 is not null and CtlRec.skill_tab8 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab8 clipped, ";"
   end if
   if( CtlRec.skill_tab9 is not null and CtlRec.skill_tab9 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab9 clipped, ";"
   end if
   if( CtlRec.skill_tab10 is not null and CtlRec.skill_tab10 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab10 clipped, ";"
   end if
   if( CtlRec.skill_tab11 is not null and CtlRec.skill_tab11 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab11 clipped, ";"
   end if
   if( CtlRec.skill_tab12 is not null and CtlRec.skill_tab12 != " " )then
      let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(updtime) lupdt from ", CtlRec.skill_tab12 clipped, ";"
   end if

#   let SQLStr = SQLStr clipped, "insert into ", tmptName clipped, " select max(datetm) lupdt from lastload;"

#display SQLStr, "<br>"
   prepare ludtID1 from SQLStr 
   execute ludtID1

   let SQLStr = "select max(lupdt) from ", tmptName clipped, ";"#delete from ", tmptName clipped, "; "

   prepare ludtID2 from SQLStr 
#display "SQLCode 2: ", SQLCA.sqlcode
   execute ludtID2 into retDt
#   display "retDt: ", retDt

   let SQLStr = "delete from ", tmptName clipped, "; insert into ", tmptName clipped, " values('", retDt, "'); "

   prepare ludtID3 from SQLStr 
#display SQLStr clipped
#display "SQLCode3: ", SQLCA.sqlcode
   execute ludtID3 

   let SQLStr = "select month(lupdt), day(lupdt), year(lupdt), to_char(extend(lupdt,hour to minute), '%H:%M') from ", tmptName clipped, ";"
#   let SQLStr = "select to_char(extend(lupdt, hour to minute), '%0) from ", tmptName clipped, ";"

   prepare ludtID4 from SQLStr 
#display "SQLCode4: ", SQLCA.sqlcode
   execute ludtID4 into lastDtRec.*
#   display "lastDtRec: ", lastDtRec.*

   let SQLStr = "drop table ", tmptName clipped, ";"
   prepare ludtID5 from SQLStr
#display "SQLCode: ", SQLCA.sqlcode
   execute ludtID5

   return lastDtRec.*
#   return retDt
   
end function  #LastUpdt

function LoadPODArray( inceid )
define
   inceid like pod.ceid,
   cnt smallint,
   retCnt smallint,
   SQLStr char(128)

## load the POD Array
   let SQLStr = "select a.* from pod a where a.ceid='", inceid clipped, "'"
   prepare POD2ID from SQLStr
   declare POD2Curs cursor for POD2ID
   let cnt=0
   foreach POD2Curs into PODArr[cnt+1].*
      let cnt = cnt + 1
   end foreach

   let retCnt = cnt

   return retCnt

end function  #LoadPODArray

function Authorized( inBRAND, inID, inPIN )
define
   inBRAND like authorization.brand,
   inID like authorization.id,
   inPIN like authorization.pin,
   cnt, ret smallint,
   SQLStr char(128)

   let ret=FALSE
   let inID=downshift(inID)
   let SQLStr="select count(*) from authorization a where a.brand='", inBRAND clipped, "' ",
              " and a.id='", inID clipped, "' ",
              " and a.pin='", inPIN clipped, "' "
   prepare ARZ1 from SQLStr
   execute ARZ1 into cnt

   if( cnt > 0 )then
      let ret=TRUE
   end if

   return ret

end function  #Authorized

function findIdx( inStr )
define
   inStr, outStr char(5120),
   keyStr char(100),
   valStr char(400),
   i,j,l smallint,
   vlen smallint

   let i = 1
   let j = 2
   let l = length(inStr)
   initialize keyStr to NULL
   initialize valStr to NULL

#  locate '='
   while inStr[j,j] != '=' and j < l
      let j = j + 1
   end while

   if( i < j )then
      let keyStr = inStr[i,j-1]
   end if

   let i = j + 1
   let j = j + 1

#  locate '&'
   while inStr[j,j] != '&' and j < l
      let j = j + 1
   end while

#display "i: ", i, " j: ", j, " l: ", l
   if( i < j OR j = l )then
      if( j < l )then
         let valStr = inStr[i,j-1]
      else
         let valStr = inStr[i,j]
      end if
   end if

   if( j < l )then
      let j = j + 1
   end if

#  set outStr
   if( j < l )then
      let outStr = inStr[ j, l ]
   else
      let outStr = ""
   end if

#  cleanup valStr looking for '+'s
   let vlen = length( valStr clipped )
   for i = 1 to vlen
      if( valStr[i] = "+" )then
         let valStr[i] = " "
      end if
   end for

   return keyStr, valStr, outStr

end function  #findIdx

function commentInfo( inCEID )
define
   inCEID like review.ceid,
   cnt smallint,
   rat smallfloat,
   SQLStr char(128)

   let cnt = 0
   let rat = 0.0
   let SQLStr="select count(*) from review where ceid='", inCEID clipped, "' and stat!='S' "
   prepare CCID from SQLStr
   execute CCID into cnt

   let SQLStr="select avg(rating) from review where ceid='", inCEID clipped, "' and stat='P'"
   prepare CCID2 from SQLStr
   execute CCID2 into rat

   return cnt, rat
   
end function  #commentInfo

function getRatingStr( inRating )
define
   inRating like review.rating,
   retStr char(5),
   i smallint

   if( inRating > 5 ) then
      let inRating = 5
   else
      if( inRating < 0 or inRating is NULL )then
         let inRating = 0
      end if
   end if
   let retStr="-----"

   for i=1 to inRating
      let retStr[i]="*"
   end for

   return retStr

end function  #getRatingStr

function getRatingStars( inRating )
define
   inRating like review.rating,
   retStr char(512),
   i smallint

   if( inRating > 5 ) then
      let inRating = 5
   else
      if( inRating < 0 or inRating is NULL )then
         let inRating = 0
      end if
   end if

   let retStr=""
   for i=1 to inRating
      let retStr=retStr clipped, "<img style='margin-bottom: 2px;' height='15' src='/", IRec.i_id clipped, "/I/stargold.jpg' width='20'>"
   end for
   for i=1 to (5-inRating)
      let retStr=retStr clipped, "<img style='margin-bottom: 2px;' height='15' src='/", IRec.i_id clipped, "/I/starplain.jpg' width='20'>"
   end for

   return retStr

end function  #getRatingStars

function currQtr()
define
   mo smallint,
   retVal char(1)

initialize retVal to NULL
let mo=month(current)
#display "month: ", mo
case mo
   when "1" 
      let retVal=1
   when "2" 
      let retVal=1
   when "3"
      let retVal=1
   when "4" 
      let retVal=2
   when "5" 
      let retVal=2
   when "6"
      let retVal=2
   when "7" 
      let retVal=3
   when "8" 
      let retVal=3
   when "9"
      let retVal=3
   when "10" 
      let retVal=4
   when "11" 
      let retVal=4
   when "12"
      let retVal=4
   otherwise 
      let retVal=1
end case  #month

return retVal
end function  #currQtr
