
globals "globals.4gl"

main

define
   i smallint,
   t_id like capability.c_num,
   SQLStr char(128)

call ReadCmdLn( "capabilities", 4 )
call ProcCmdLn( "capabilities" )
call Header(4, IRec.i_id, BRec.b_id, 1)
display " "

display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed below reflect all of our Partners</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>that are SVP Approved for the indicated Capabilities.</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>TOP Skilled Partners are marked with '*'.</span></em></div><p>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "	<tbody>"

let SQLStr="select c_id from capability order by c_id"
prepare CID from SQLStr
declare CCurs cursor for CID

foreach CCurs into t_id
   call ShowCA( t_id )
end foreach

display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function ShowCA( in_in )
define
   in_in smallint,
   wStr char(64),
   qtrStr char(512),
   skillStr char(64)

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


case BRec.b_id
   when "WS"
      let qtrStr = "select a.*, k.* from coverage_ws a, outer skills_ws k "
   when "IM"
      let qtrStr = "select a.*, k.* from coverage_im a, outer skills_im k "
   when "TI"
      let qtrStr = "select a.*, k.* from coverage_ti a, outer skills_ti k "
   when "RA"
      let qtrStr = "select a.*, k.* from coverage_ra a, outer skills_ra k "
   when "LO"
      let qtrStr = "select a.*, k.* from coverage_lo a, outer skills_lo k "
   otherwise
      let qtrStr = "select a.*, k.* from coverage a, outer skills k "
end case

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
         display "<i><span style='font-size: 10px'>(HV)</span></i>"
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

