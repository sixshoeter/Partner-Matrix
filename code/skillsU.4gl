
## November  24, 2014 John M. Shoemaker, expand to 30 skills
## March     05, 2015 John M. Shoemaker, add Units
## April     07, 2015 John M. Shoemaker, reword title (per Dot)
## September 08, 2015 John M. Shoemaker, change wording for TOP #36
## February  17, 2016 John M. Shoemaker, filter out reseller X
## February  15, 2017  John M. Shoemaker, change title menu variable, #207
## October   06, 2017 John M. Shoemaker, ignore case in part_name sort, #269
## October   23, 2017 John M. Shoemaker, support skill=4, #281
## October   23, 2017 John M. Shoemaker, support skills 1-4, #280

globals "globals.4gl"

define
   skill_cat smallint
main

define
   i,idx,tbIdx smallint,
   si, skill_cat smallint,
   SQLStr char(128),
   tBrandRec record like brands.*
#   SkilledYN smallint

call ReadCmdLn("skills", 4)
call ProcCmdLn("skills")
call Header(3, IRec.i_id, BRec.b_id, 1)

display " "

display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed below reflect our <strong>", MasterRec.top_msg clipped, "</strong> Partners in each Product set.</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>In addition there are other skilled partners that are building their practices,</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>and will be added to this list as they become certified as a Recommended Partner.</span></em></div><p>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", CtlRec.menu_str clipped,"</span></em></div>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 650px' width='650'>"
display "<tbody>"
display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
display "<h3>"
display "<span style='font-size: 18px'>Product Set</span></h3>"
display "</td>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 367px; vertical-align: middle'>"
display "<h3 style='text-align: center'>"
if( not CtlRec.showaltskills )then
   display "<span style='font-size: 18px'>", MasterRec.top_msg clipped, " Partners</span></h3>"
else
   display "<span style='font-size: 18px'>", MasterRec.top_msg clipped, ", ", MasterRec.middle_msg clipped, " and ", MasterRec.low_msg clipped, " Partners</span></h3>"
end if  #not CtlRec.showaltskills
display "</td>"

let SQLStr="select a.* from brands a, unit_brand b where a.b_id=b.b_id and b.u_id='", BRec.b_id clipped, "' order by a.b_ord"
prepare LSU2 from SQLStr
declare LSU2Curs cursor for LSU2

foreach LSU2Curs into tBrandRec.*
#   let SkilledYN = LoadSkillRec( tBrandRec.b_id, ARec.ceid )
#   call ShowSkillsCurrentBrand2( 1, tBrandRec.b_id, tBrandRec.b_ord )

if( CtlRec.skill_cat )then
   let skill_cat = LoadSkillCat( tBrandRec.b_id )
end if
for si = 1 to skill_cat
   for i = 1 to SkillsMaxU
      let tbIdx = tBrandRec.b_ord
#display tBrandRec.*
#display tbIdx, i, SkillArrU[tbIdx, i].db_num
      let idx = SkillArrU[tbIdx, i].db_num
#display "tbIdx,i,idx: ", tbIdx, i, idx
      if( SkillArrU[tbIdx, idx].s_name != "NA" and SkillArrU[tbIdx, idx].c_id = si ) then
         call ShowSkilledPartners( tBrandRec.b_id, idx, i, tbIdx )
      end if
   end for  #i
end for  #si
end foreach

display "</tbody>"
display "</table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function ShowSkilledPartners( inBrand, in_db, in_sort, inb_ord )
define
   inBrand like brands.b_id,
   in_db, in_sort, inb_ord smallint,
   cnt smallint,
   wStr char(512),
   qtrStr char(1028),
   cntStr char(1028),
   skillStr char(512),
   slStr char(256),
   slLevel char(1),
   slLevelStr like master.top_msg,
   catStr like skill_cat.c_long,
   skillmax char(3)


if( CtlRec.skill_cat )then
   let skill_cat = LoadSkillCat( inBrand )
end if

## determine the skill level to show
if( not CtlRec.showaltskills )then
   let skillmax="3"
else
   let skillmax="1"
end if  #CtlRec.showaltskills brand

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"

if( CtlRec.skill_cat and skill_cat > 0 )then
   let catStr = GetSkillCatDesc( SkillArrU[inb_ord, in_sort].c_id ) 
   display "<h2><span style='font-size: 16px'>", catStr clipped, "</span></h2>"
end if
#display "skill_cat: ", skill_cat, " catStr: ", catStr
display "<h3><span style='font-size: 18px'>", SkillArrU[inb_ord, in_sort].s_desc clipped, "</span></h3>"

case in_db
   when 1
      let wStr = "where a.ceid = k.ceid and k.skill_01 >= ", skillmax
   when 2
      let wStr = "where a.ceid = k.ceid and k.skill_02 >= ", skillmax
   when 3
      let wStr = "where a.ceid = k.ceid and k.skill_03 >= ", skillmax
   when 4
      let wStr = "where a.ceid = k.ceid and k.skill_04 >= ", skillmax
   when 5
      let wStr = "where a.ceid = k.ceid and k.skill_05 >= ", skillmax
   when 6
      let wStr = "where a.ceid = k.ceid and k.skill_06 >= ", skillmax
   when 7
      let wStr = "where a.ceid = k.ceid and k.skill_07 >= ", skillmax
   when 8
      let wStr = "where a.ceid = k.ceid and k.skill_08 >= ", skillmax
   when 9
      let wStr = "where a.ceid = k.ceid and k.skill_09 >= ", skillmax
   when 10
      let wStr = "where a.ceid = k.ceid and k.skill_10 >= ", skillmax
   when 11
      let wStr = "where a.ceid = k.ceid and k.skill_11 >= ", skillmax
   when 12
      let wStr = "where a.ceid = k.ceid and k.skill_12 >= ", skillmax
   when 13
      let wStr = "where a.ceid = k.ceid and k.skill_13 >= ", skillmax
   when 14
      let wStr = "where a.ceid = k.ceid and k.skill_14 >= ", skillmax
   when 15
      let wStr = "where a.ceid = k.ceid and k.skill_15 >= ", skillmax
   when 16
      let wStr = "where a.ceid = k.ceid and k.skill_16 >= ", skillmax
   when 17
      let wStr = "where a.ceid = k.ceid and k.skill_17 >= ", skillmax
   when 18
      let wStr = "where a.ceid = k.ceid and k.skill_18 >= ", skillmax
   when 19
      let wStr = "where a.ceid = k.ceid and k.skill_19 >= ", skillmax
   when 20
      let wStr = "where a.ceid = k.ceid and k.skill_20 >= ", skillmax
   when 21
      let wStr = "where a.ceid = k.ceid and k.skill_21 >= ", skillmax
   when 22
      let wStr = "where a.ceid = k.ceid and k.skill_22 >= ", skillmax
   when 23
      let wStr = "where a.ceid = k.ceid and k.skill_23 >= ", skillmax
   when 24
      let wStr = "where a.ceid = k.ceid and k.skill_24 >= ", skillmax
   when 25
      let wStr = "where a.ceid = k.ceid and k.skill_25 >= ", skillmax
   when 26
      let wStr = "where a.ceid = k.ceid and k.skill_26 >= ", skillmax
   when 27
      let wStr = "where a.ceid = k.ceid and k.skill_27 >= ", skillmax
   when 28
      let wStr = "where a.ceid = k.ceid and k.skill_28 >= ", skillmax
   when 29
      let wStr = "where a.ceid = k.ceid and k.skill_29 >= ", skillmax
   when 30
      let wStr = "where a.ceid = k.ceid and k.skill_30 >= ", skillmax
end case

if( UnitModeYN() )then
   let skillStr = "select a.skill_tab1 from control a where a.brand = '", inBrand clipped, "'"
   prepare SSLK1ID from skillStr
   execute SSLK1ID into skill_tab
end if  #UnitModeYN

let qtrStr = BuildBaseStr( inBrand, FALSE )

   let wStr = wStr clipped, " and (a.reseller != 'N' and a.reseller !='V' and a.reseller != 'X' and a.part_type != 'D') "
   let qtrStr = qtrStr clipped, " ", wStr clipped, " order by lower(a.part_name)"
#display qtrStr
   prepare QID from qtrStr

declare ACurs cursor for QID

let cntStr="select count(*) from ", cov_tab clipped, " a, ", skill_tab clipped, " k ", wStr clipped
#display cntStr
prepare cntID from cntStr
execute cntID into cnt
if( cnt > 0 )then
   display "<p><span style='font-size:10px;'>", "(", cnt using "<<<"
   if( cnt > 1 )then
      display " partners)"
   else
      display " partner)"
   end if
   display "</span>"
end if


display "</td>"
display "<td style='text-align: left; width: 367px'>"
display "<div>"


foreach ACurs into URec.*, KRec.*

##############################################
## determine skill level for those wanting it
   if( not CtlRec.showaltskills )then
      let slLevelStr=" "
   else
      let slStr="select skill_", in_db using '&&', " from ", skill_tab clipped, " where ceid='", URec.ceid clipped, "'"
      prepare slID from slStr
      execute slID into slLevel
      case slLevel
         when "4"
            let slLevelStr="(", MasterRec.best_msg clipped, ")"
         when "3"
            let slLevelStr="(", MasterRec.top_msg clipped, ")"
         when "2"
            let slLevelStr="(", MasterRec.middle_msg clipped, ")"
         when "1"
            let slLevelStr="(", MasterRec.low_msg clipped, ")"
         otherwise
            let slLevelStr="(Skilled)"
      end case  #slLevel
   end if  #allowing multiple skill levels to be shown
##############################################

   display "<a href='../P/", URec.ceid clipped, ".html'>", URec.part_name clipped, "</a>"

   if( slLevelStr != " " )then
      display "&nbsp;<i><span style='font-size: 10px'>", slLevelStr clipped, "</span></i>"
   end if

   display "<br/>"
end foreach

display "</td></tr>"

end function
