
globals "globals.4gl"

main

define
   i smallint

call ReadCmdLn( "industries", 4 )
call ProcCmdLn( "industries" )
call Header(4, IRec.i_id, BRec.b_id, 1)
{
display "<table align='center' border='0' dir='ltr' style='width: 625px;'>"
display "	<tbody>"
display "		<tr>"
display "		<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "	<span style='font-size:14px;'><a href='../H/home.html'> "
display "<span style='color:#ffffff;'>Home</span></a></span></th>"
display "	<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "	<span style='font-size:14px;'><a href='../H/authorization.html'>"
display "<span style='color: rgb(255, 255, 255);'>Authorizations</span></span></th>"
display "	<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); "
display "border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "<span style='font-size:14px;'><a href='../H/skills.html'> "
display "<span style='color:#ffffff;'>Skills</span></a></span></th>"
display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(128, 0, 128); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "<span style='color: rgb(255, 255, 255);'>Industries</span></th>"
display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "<span style='font-size:14px;'><a href='../H/businessunits.html'> "
display "<span style='color:#ffffff;'>Business Units</span></a></span></th>"
display "		</tr>"
display "	</tbody>"
display "</table>"
}
display " "

display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed below reflect all of our Partners</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>that have knowledge and experience in these Industries.</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>Those Partners with 'top' skills have the skills listed in (parens).</span></em></div><p>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "	<tbody>"

for i = 1 to 11
   call ShowIN( i )
end for

display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function ShowIN( in_in )
define
   in_in smallint,
   wStr char(512),
   qtrStr char(512),
   skillStr char(512)

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
display "<h3>"

case in_in
   when 1
      display "<span style='font-size: 18px'>Banking and Financial Market</span></h3>"
      let wStr = "where a.ceid = k.ceid and a.ind_bank='Y'"
   when 2
      display "<span style='font-size: 18px'>Energy & Utility</span></h3>"
      let wStr = "where a.ceid = k.ceid and a.ind_eu='Y'"
   when 3
      display "<span style='font-size: 18px'>Govt</span></h3>"
      let wStr = "where a.ceid = k.ceid and a.ind_gov='Y'"
   when 4
      display "<span style='font-size: 18px'>Healthcare & Lifescience</span></h3>"
      let wStr = "where a.ceid = k.ceid and a.ind_hl='Y'"
   when 5
      display "<span style='font-size: 18px'>Insurance</span></h3>"
      let wStr = "where a.ceid = k.ceid and a.ind_ins='Y'"
   when 6
      display "<span style='font-size: 18px'>Manufacturing</span></h3>"
      let wStr = "where a.ceid = k.ceid and a.ind_mfg='Y'"
   when 7
      display "<span style='font-size: 18px'>Media & Entertainment</span></h3>"
      let wStr = "where a.ceid = k.ceid and a.ind_me='Y'"
   when 8
      display "<span style='font-size: 18px'>Retail</span></h3>"
      let wStr = "where a.ceid = k.ceid and a.ind_ret='Y'"
   when 9
      display "<span style='font-size: 18px'>Telecommunication</span></h3>"
      let wStr = "where a.ceid = k.ceid and a.ind_tel='Y'"
   when 10
      display "<span style='font-size: 18px'>Transportation</span></h3>"
      let wStr = "where a.ceid = k.ceid and a.ind_trans='Y'"
   when 11
      display "<span style='font-size: 18px'>Wholesale Distribution</span></h3>"
      let wStr = "where a.ceid = k.ceid and a.ind_wd='Y'"
end case

let wStr = wStr clipped, "and a.reseller != 'N' and a.part_type != 'D' "

let qtrStr = BuildBaseStr( BRec.b_id, TRUE )

   let qtrStr = qtrStr clipped, " ", wStr clipped, " order by a.part_name"
#display qtrStr
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

