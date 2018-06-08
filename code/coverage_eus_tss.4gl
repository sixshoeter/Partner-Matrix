
##
##  May  08, 2014 - John M. Shoemaker, create from coverate_eus.4gl
## Januaruy  19, 2015 - John M. Shoemaker, jshoe@us.ibm.com - change terminology from launch
## February  17, 2016 John M. Shoemaker, filter out reseller X

globals "globals.4gl"

main

define
   i smallint,
   SQLStr char(256)

call ReadCmdLn( "coverage", 4 )
call ProcCmdLn( "coverage" )
call Header(0, IRec.i_id, BRec.b_id, 1)

display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>B U I L D * B R A N D * C O V E R A G E (by TSS)</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "	<tbody>"

## use coverage file to determine ctp
   let SQLStr="select unique '' ssr, '' ssr_link, s.r_name, s.r_link ",
      "from ", cov_tab clipped, " b, reps s ",
      "where b.ctp = s.r_name ",
      " and b.ctp not in ('Open','NA')"

prepare CID from SQLStr
declare RepCurs cursor for CID


let i = 1
foreach RepCurs into RepArr[i].*
   call ShowCoverage( i )
   let i=i+1
end foreach

display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function ShowCoverage( in_bu )
define
   in_bu smallint,
   cov_cnt smallint,
   qStr char(256),
   wStr char(256),
   qtrStr char(512),
   skillStr char(64),
   my_ssr like bus.b_ssr,
   my_ctp like bus.b_ctp,
   RRec record like reps.*

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
display "<h3>"

display "<span style='font-size:14px;'>"
display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a><p>"

let cov_cnt = GetCoverageCnt(RepArr[in_bu].ssr, RepArr[in_bu].ctp)
if( cov_cnt > 0 )then
   display "<p><span style='font-size:10px;'>", "(", cov_cnt using "<<<"
   if( cov_cnt > 1 )then
      display " partners)"
   else
      display " partner)"
   end if
   display "</span>"
end if


display "</span"

let wStr = "where a.ceid = k.ceid and a.ctp='", RepArr[in_bu].ctp clipped, "' and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' "

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

   case ARec.part_type 
      when "C"
         display "<i><span style='font-size: 10px'>[core]<span></i>"
      when "I"
         display "<i><span style='font-size: 10px'>[invest]<span></i>"
      when "O"
         display "<i><span style='font-size: 10px'>[opportunistic]<span></i>"
      when "D"
         display "<i><span style='font-size: 10px'>[dormant]<span></i>"
   end case

   case ARec.reseller 
      when "E"
         display "<i><span style='font-size: 10px'>(Emerging)</span></i>"
      when "H"
         Display "<i><span style='font-size: 10px'>(HV)</span></i>"
      when "S"
         display "<i><span style='font-size: 10px'>(S)</span></i>"
   end case

   display "<i><span style='font-size: 10px'><a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/R/", ARec.ceid clipped, "-report.rtf' target='_blank'>download</a></span></i>"
   

   if( skillStr is not null )then
      display " <br /><span style='font-size: 12px'>&nbsp &nbsp &nbsp &nbsp &nbsp (", skillStr clipped, ") </span><span class='1b-half'></span>"
   end if

   display "<br/>"
end foreach

display "</td></tr>"

end function

function GetCoverageCnt( in_ssr, in_ctp )
define
   in_ssr like reps.r_link,
   in_ctp like reps.r_link,
   cnt smallint,
   SQLStr char(256)

let SQLStr = "select count(*) from ", cov_tab clipped, " a where a.ctp='", in_ctp clipped, "' and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' "

#display SQLStr
prepare GCCID from SQLStr
execute GCCID into cnt

return cnt

end function  #GetCoverageCnt


