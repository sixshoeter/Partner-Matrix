
##
##  February 17, 2014 - John M. Shoemaker, add download of reports
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
display "<em><span style='font-size: 20px'>B U I L D  *  C O V E R A G E </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "	<tbody>"

if( CTPPairFlg )then
   let SQLStr="select unique s.r_name, s.r_link, c.r_name, c.r_link ",
      "from eus b, reps s, reps c ",
      "where b.e_ssr = s.r_name ",
        "and b.e_ctp = c.r_name ",
        "and b.e_brand = '", BRec.b_id clipped, "'"
else
## use coverage file to determine ssr
   let SQLStr="select unique s.r_name, s.r_link, '' ctp, '' ctp_link ",
      "from ", cov_tab clipped, " b, reps s ",
      "where b.ssr = s.r_name ",
      " and b.ssr not in ('Open','NA')"

## still use EUS table to determine ssr
#   let SQLStr="select unique s.r_name, s.r_link, '' ctp, '' ctp_link ",
#      "from eus b, reps s ",
#      "where b.e_ssr = s.r_name ",
#        "and b.e_brand = '", BRec.b_id clipped, "'"
end if

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
display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"

if( RepArr[in_bu].ctp != 'NA' and CTPPairFlg )then
   display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
end if

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

{
case in_bu
   when 1
      display "<span style='font-size:14px;'>"
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != 'NA' )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      display "</span"
      display "</span"
   when 2
      display "<span style='font-size:14px;'>"
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != 'NA' )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      display "</span"
   when 3
      display "<span style='font-size:14px;'>"
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != 'NA' )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      display "</span"
   when 4
      display "<span style='font-size:14px;'>"
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != 'NA' )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      display "</span"
   when 5
      display "<span style='font-size:14px;'>"
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != 'NA' )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      display "</span"
   when 6
      display "<span style='font-size:14px;'>"
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != 'NA' )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      display "</span"
   when 7
      display "<span style='font-size:14px;'>"
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != 'NA' )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      display "</span"
   when 8
      display "<span style='font-size:14px;'>"
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != 'NA' )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      display "</span"
   when 9
      display "<span style='font-size:14px;'>"
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != 'NA' )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
      display "</span"
   when 10
      display "<span style='font-size:14px;'>"
      display bprStr clipped, "<br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"
      if( RepArr[in_bu].ctp != 'NA' )then
         display tssStr clipped, "<br /><a href='", RepArr[in_bu].ctp_link clipped, "' target='_blank'>",RepArr[in_bu].ctp clipped, "</a>"
      end if
end case
}

let wStr = "where a.ceid = k.ceid and a.ssr='", RepArr[in_bu].ssr clipped, "' and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X')"
if( CTPPairFlg )then
   let wStr = wStr clipped, " and a.ctp='", RepArr[in_bu].ctp clipped, "'"
end if

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
         display "<i><span style='font-size: 10px'>(Services)</span></i>"
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

let SQLStr = "select count(*) from ", cov_tab clipped, " a where a.ssr='", in_ssr clipped, "' and (a.reseller != 'N' or a.reseller = 'V')"
if( CTPPairFlg )then
 let SQLStr = SQLStr clipped, " and a.ctp='", in_ctp clipped, "'"
end if

#display SQLStr
prepare GCCID from SQLStr
execute GCCID into cnt

return cnt

end function  #GetCoverageCnt


