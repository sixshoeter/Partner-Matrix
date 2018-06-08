# 08/12/2013 - John M. Shoemaker - created
# 06/17/2015 - John M. Shoemaker - created
## February  17, 2016 John M. Shoemaker, filter out reseller X
## February  29, 2016 John M. Shoemaker, correct invalid link from Segments #137
## August    22, 2016 John M. Shoemaker, modify titles per #185
## February  15, 2017 John M. Shoemaker, modify titles per #207



globals "globals.4gl"

main

define
   SQLStr char(256),
   tStatus like coverage_ws.part_type

call ReadCmdLn( "byStatus", 4 )
call ProcCmdLn( "byStatus" )
call Header(0, IRec.i_id, BRec.b_id, 1)

display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>BUSINESS PARTNER SEGMENTATIONS</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", CtlRec.menu_str clipped," Software</span></em></div>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "	<tbody>"


   call ShowCoverage( 'G' )
   call ShowCoverage( 'O' )
   call ShowCoverage( 'S' )
   call ShowCoverage( 'B' )

display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function ShowCoverage( in_status )
define
   in_status like coverage_au.part_type,
   wStr char(128),
   qtrStr char(512),
   skillStr char(64),
   my_ssr like bus.b_ssr,
   my_ctp like bus.b_ctp,
   RRec record like reps.*

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
display "<h3>"

case in_status
   when 'G'
      display "<span style='font-size:18px;'>"
      display "<a href='/", IRec.i_id clipped,"/", BRec.b_id clipped, "../../all/H/Segmentation.html' target='_blank'>GROWTH</a> Partners<br />"
      display "</span"
   when 'O'
      display "<span style='font-size:18px;'>"
      display "<a href='/", IRec.i_id clipped,"/", BRec.b_id clipped, "../../all/H/Segmentation.html' target='_blank'>OPPORTUNISTIC</a> Partners<br />"
      display "</span"
   when 'S'
      display "<span style='font-size:18px;'>"
      display "<a href='/", IRec.i_id clipped,"/", BRec.b_id clipped, "../../all/H/Segmentation.html' target='_blank'>Strategic</a> Partners<br />"
      display "</span"
   when 'B'
      display "<span style='font-size:18px;'>"
      display "<a href='/", IRec.i_id clipped,"/", BRec.b_id clipped, "../../all/H/Segmentation.html' target='_blank'>BLUE CORE</a> Partners<br />"
      display "</span"
end case

   let wStr = "where a.part_type='", in_status clipped, "' and a.reseller !='N' and a.reseller != 'S' and a.reseller !='V' and a.reseller != 'X' "

let qtrStr = "select a.* from ", cov_tab clipped, " a "
#let qtrStr = BuildBaseStr( BRec.b_id, TRUE )

   let qtrStr = qtrStr clipped, " ", wStr clipped, " order by a.part_name"
#display "Q: ", qtrStr clipped
   prepare QID from qtrStr

declare ACurs cursor for QID

display "</td>"
display "<td style='text-align: left; width: 367px'>"
display "<div>"


foreach ACurs into URec.*, KRec.*
#   let skillStr = BuildSkillStr( 3 )

   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, ".html'>", URec.part_name clipped, "</a>"

#   case URec.reseller 
#      when "E"
#         display "<i><span style='font-size: 10px'>(Emerging)<span></i>"
#      when "H"
#         if( ShowHVP )then
#            display "<i><span style='font-size: 10px'>(HV)<span></i>"
#         end if
#      when "S"
#         display "<i><span style='font-size: 10px'>(S)<span></i>"
#   end case
#
   if( skillStr is not null )then
      display " <br /><span style='font-size: 12px'>&nbsp &nbsp &nbsp &nbsp &nbsp (", skillStr clipped, ") </span><span class='1b-half'></span>"
   end if

   display "<br/>"
end foreach

display "</td></tr>"

end function

