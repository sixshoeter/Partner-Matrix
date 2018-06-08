##
## October 11, 2013 John M. Shoemaker, multiple changes per LeeP
## February  17, 2016 John M. Shoemaker, filter out reseller X
##

globals "globals.4gl"

main

define
   i smallint,
   str char(20)

call ReadCmdLn( "businessunits", 4 )
call ProcCmdLn( "businessunits" )
call Header(5, IRec.i_id, BRec.b_id, 1)

display " "
let str = DOWNSHIFT(BRec.b_id)

display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed below are selling into these Business Units. </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>Those Partners with 'top' skills have the skills listed in (parens).</span></em></div><p>"
display "<div dir='ltr' style='text-align: center'>"
#display "	<em><span style='font-size: 16px'>The TOP Skilled Partners are marked with '*'. <a HREF='/query_", str clipped, ".html'>Find a Partner</a></span></em>"
display "</div><p>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "	<tbody>"

declare RepCurs cursor for
   select s.r_name, s.r_link, c.r_name, c.r_link 
      from bus b, reps s, reps c 
      where b.b_ssr = s.r_name
        and b.b_ctp = c.r_name
        and b.b_brand = BRec.b_id
      order by b.b_id


let i = 1
foreach RepCurs into RepArr[i].*
let i=i+1
end foreach

for i = 1 to 10
   call ShowBU( i )
end for

display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function ShowBU( in_bu )
define
   in_bu smallint,
   wStr char(512),
   qtrStr char(512),
   skillStr char(512),
   my_ssr like bus.b_ssr,
   my_ctp like bus.b_ctp,
   RRec record like reps.*,
   tmpnm char(1)

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
display "<h3>"

case in_bu
   when 1
      display "<span style='font-size: 18px'>Midwest</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != "NA" )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      let wStr = "where a.ceid = k.ceid and (a.bu_midwest='Y' or a.bu_midwest='H')"
   when 2
      display "<span style='font-size: 18px'>Pacifics</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != "NA" )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      let wStr = "where a.ceid = k.ceid and (a.bu_pacifics='Y' or a.bu_pacifics='H')"
   when 3
      display "<span style='font-size: 18px'>Great West</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != "NA" )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      let wStr = "where a.ceid = k.ceid and (a.bu_greatwest='Y' or a.bu_greatwest='H')"
   when 4
      display "<span style='font-size: 18px'>Southeast</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != "NA" )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      let wStr = "where a.ceid = k.ceid and (a.bu_southeast='Y' or a.bu_southeast='H')"
   when 5
      display "<span style='font-size: 18px'>Mid-Atlantic</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != "NA" )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      let wStr = "where a.ceid = k.ceid and (a.bu_midatl='Y' or a.bu_midatl='H')"
   when 6
      display "<span style='font-size: 18px'>New York</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != "NA" )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      let wStr = "where a.ceid = k.ceid and (a.bu_ny='Y' or a.bu_ny='H')"
   when 7
      display "<span style='font-size: 18px'>Northeast</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != "NA" )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      let wStr = "where a.ceid = k.ceid and (a.bu_northeast='Y' or a.bu_northeast='H')"
   when 8
      display "<span style='font-size: 18px'>Great Lakes</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != "NA" )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      let wStr = "where a.ceid = k.ceid and (a.bu_grtlakes='Y' or a.bu_grtlakes='H')"
   when 9
      display "<span style='font-size: 18px'>Federal</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != "NA" )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      let wStr = "where a.ceid = k.ceid and (a.bu_federal='Y' or a.bu_federal='H')"
   when 10
      display "<span style='font-size: 18px'>Canada</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != "NA" )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      let wStr = "where a.ceid = k.ceid and (a.bu_canada='Y' or a.bu_canada='H')"
end case

let qtrStr = BuildBaseStr( BRec.b_id, TRUE )

let wStr = wStr clipped, " and a.reseller !='N' and a.reseller != 'X' and a.part_type != 'D' "

## place results into temp table for changing sort name
   let qtrStr = qtrStr clipped, " ", wStr clipped, " order by a.part_name"
   prepare QID from qtrStr

   declare ACurs cursor for QID

display "</td>"
display "<td style='text-align: left; width: 367px'>"
display "<div>"


foreach ACurs into ARec.*, KRec.*

   let skillStr = BuildSkillStr( 3 )
   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", ARec.ceid clipped, ".html'>", ARec.part_name clipped, "</a>"

   case ARec.reseller 
      when "E" 
         display "<i><span style='font-size: 10px'>(Emerging)</span></i>"
      when "H" 
         if( ShowHVP )then
            display "<i><span style='font-size: 10px'>(HV)</span></i>"
         end if
      when "S" 
         display "<i><span style='font-size: 10px'>(S)</span></i>"
   end case

   if( skillStr is not null )then
      display " <br /><span style='font-size: 12px'>&nbsp &nbsp &nbsp &nbsp &nbsp (", skillStr clipped, ") </span><span class='1b-half'></span>"
   end if

   display "<br/>"
end foreach

display "</td></tr>"

end function

function IsEmpty( inStr )
   define
      inStr char(10),
      ret smallint


   if( inStr is NULL or inStr = " " or inStr ="" )then
      return true
   else
      return false
   end if

    
end function
