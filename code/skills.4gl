
## November 24, 2013 John M. Shoemaker, expand to 30 skills

globals "globals.4gl"

define
   skill_cat smallint
main

define
   i,idx smallint

call ReadCmdLn("skills", 4)
call ProcCmdLn("skills")
call Header(3, IRec.i_id, BRec.b_id, 1)

display " "

display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed below reflect our 'top' skilled Partner in each Product set.</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>There are other skilled partners that are building their practices,</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>and they will be added to this list as they reach the 'top'.</span></em></div><p>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
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
display "<span style='font-size: 18px'>Top Skilled Partners</span></h3>"
display "</td>"

if( CtlRec.skill_cat )then
   let skill_cat = LoadSkillCat( BRec.b_id )
end if

for i = 1 to 20
   let idx = SkillArr[i].db_num
   if( SkillArr[idx].s_name != "NA") then
      call ShowSkilledPartners( idx, i )
   end if
end for

display "</tbody>"
display "</table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function ShowSkilledPartners( in_db, in_sort )
define
   in_db, in_sort smallint,
   cnt smallint,
   wStr char(128),
   qtrStr char(512),
   cntStr char(512),
   catStr like skill_cat.c_long

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"

if( CtlRec.skill_cat and skill_cat > 0 )then
   let catStr = GetSkillCatDesc( SkillArr[in_sort].c_id ) 
   display "<h2><span style='font-size: 16px'>", catStr clipped, "</span></h2>"
end if

display "<h3><span style='font-size: 18px'>", SkillArr[in_sort].s_desc clipped, "</span></h3>"

case in_db
   when 1
      let wStr = "where a.ceid = k.ceid and k.skill_01 = 3 "
   when 2
      let wStr = "where a.ceid = k.ceid and k.skill_02 = 3 "
   when 3
      let wStr = "where a.ceid = k.ceid and k.skill_03 = 3 "
   when 4
      let wStr = "where a.ceid = k.ceid and k.skill_04 = 3 "
   when 5
      let wStr = "where a.ceid = k.ceid and k.skill_05 = 3 "
   when 6
      let wStr = "where a.ceid = k.ceid and k.skill_06 = 3 "
   when 7
      let wStr = "where a.ceid = k.ceid and k.skill_07 = 3 "
   when 8
      let wStr = "where a.ceid = k.ceid and k.skill_08 = 3 "
   when 9
      let wStr = "where a.ceid = k.ceid and k.skill_09 = 3 "
   when 10
      let wStr = "where a.ceid = k.ceid and k.skill_10 = 3 "
   when 11
      let wStr = "where a.ceid = k.ceid and k.skill_11 = 3 "
   when 12
      let wStr = "where a.ceid = k.ceid and k.skill_12 = 3 "
   when 13
      let wStr = "where a.ceid = k.ceid and k.skill_13 = 3 "
   when 14
      let wStr = "where a.ceid = k.ceid and k.skill_14 = 3 "
   when 15
      let wStr = "where a.ceid = k.ceid and k.skill_15 = 3 "
   when 16
      let wStr = "where a.ceid = k.ceid and k.skill_16 = 3 "
   when 17
      let wStr = "where a.ceid = k.ceid and k.skill_17 = 3 "
   when 18
      let wStr = "where a.ceid = k.ceid and k.skill_18 = 3 "
   when 19
      let wStr = "where a.ceid = k.ceid and k.skill_19 = 3 "
   when 20
      let wStr = "where a.ceid = k.ceid and k.skill_20 = 3 "
   when 21
      let wStr = "where a.ceid = k.ceid and k.skill_21 = 3 "
   when 22
      let wStr = "where a.ceid = k.ceid and k.skill_22 = 3 "
   when 23
      let wStr = "where a.ceid = k.ceid and k.skill_23 = 3 "
   when 24
      let wStr = "where a.ceid = k.ceid and k.skill_24 = 3 "
   when 25
      let wStr = "where a.ceid = k.ceid and k.skill_25 = 3 "
   when 26
      let wStr = "where a.ceid = k.ceid and k.skill_26 = 3 "
   when 27
      let wStr = "where a.ceid = k.ceid and k.skill_27 = 3 "
   when 28
      let wStr = "where a.ceid = k.ceid and k.skill_28 = 3 "
   when 29
      let wStr = "where a.ceid = k.ceid and k.skill_29 = 3 "
   when 30
      let wStr = "where a.ceid = k.ceid and k.skill_30 = 3 "
end case


let qtrStr = BuildBaseStr( BRec.b_id, FALSE )

   let wStr = wStr clipped, " and (reseller != 'N' and a.reseller !='V' and part_type != 'D') "
   let qtrStr = qtrStr clipped, " ", wStr clipped, " order by a.part_name"

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


foreach ACurs into ARec.*, KRec.*
   display "<a href='../P/", ARec.ceid clipped, ".html'>", ARec.part_name clipped, " </a>"

   case ARec.reseller 
   when "E" 
      display "<i><span style='font-size: 10px'>(Emerging)</span></i>"
   when "H" 
      if( ShowHVP )then
         display "<i><span style='font-size: 10px'>(HV)</span></i>"
      end if
   when "S" 
      display "<i><span style='font-size: 10px'>(Services)</span></i>"
   end case

   display "<br/>"
end foreach

display "</td></tr>"

end function
