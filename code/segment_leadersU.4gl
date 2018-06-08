
##
## April     08, 2015 - John M. Shoemaker, create
## August    20, 2015 - John M. Shoemaker, remove link if Open is name - #121


globals "globals.4gl"

main

define
   i smallint,
   SQLStr char(256),
   tmp_link like reps.r_link,
   SegRec record like segment_leaders.*
  

call ReadCmdLn( "coverage", 4 )
call ProcCmdLn( "coverage" )
call Header(0, IRec.i_id, BRec.b_id, 1)

display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>S E G M E N T * L E A D E R S</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "	<tbody>"

## 
let SQLStr="select a.*, s.r_link from segment_leaders a, reps s ",
           " where a.seg_lead = s.r_name ",
           " and a.b_id = '", BRec.b_id clipped, "' order by a.b_sort, a.seg_lead"


prepare CID from SQLStr
declare RepCurs cursor for CID


foreach RepCurs into SegRec.*, tmp_link
   display "<tr>"
   display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
   display "<h3>"

   display "<span style='font-size:14px;'>"
   if( SegRec.seg_lead != 'Open' )then
      display "<br /><a href='", tmp_link clipped, "' target='_blank'>", SegRec.seg_lead clipped, "</a>"
   else
      display "<br />", SegRec.seg_lead clipped, ""
   end if
   display "</span></td>"
   display "<td>", SegRec.seg_desc clipped, "</td></tr>"
end foreach

display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main



