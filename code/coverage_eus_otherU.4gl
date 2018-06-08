
##
## May       04 2014 - John M. Shoemaker, created from coverage_eusU.4gl, #165
## August    22 2016 - John M. Shoemaker, modify titles per #185
## February  15, 2017  John M. Shoemaker, change title menu variable, #207
## February  15 2017 - John M. Shoemaker, remove flash reps and add others, #208
## April     11 2017   John M. Shoemaker, jshoemaker1@cox.net - add in Power SPR, #212


globals "globals.4gl"

define
   repTypeArr array[100] of char(10)

main

define
   i smallint,
   SQLStr char(2048)

call ReadCmdLn( "coverage", 4 )
call ProcCmdLn( "coverage" )
call Header(0, IRec.i_id, BRec.b_id, 1)

display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", "Storage SISS SPR", " Coverage", "</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", CtlRec.menu_str clipped,"</span></em></div>"
display "<p>"

if( CtlRec.coverextend_tab is not NULL and CtlRec.coverextend_tab != " " )then
#display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
   display "<table align='center' border='1' dir='ltr' height='376' style='width: 950px' width='950'>"
   display "	<tbody>"

## use coverextend file to determine rep
#   let SQLStr="select unique s.r_name, s.r_link, '' ctp, '' ctp_link ",
#      "from ", CtlRec.coverextend_tab clipped, " b, reps s ",
#      "where b.ssr = s.r_name ",
#      " and b.ssr not in ('Open','NA',' ') UNION ",
   let SQLStr = 
      "select unique s.r_name, s.r_link, '' ctp, '' ctp_link, 'PTA' rep_type ",
      "from ", CtlRec.coverextend_tab clipped, " b, reps s ",
      "where b.pta = s.r_name ",
      " and b.pta not in ('Open','NA',' ') UNION ",
      "select unique s.r_name, s.r_link, '' ctp, '' ctp_link, 'PTA-HW' rep_type ",
      "from ", CtlRec.coverextend_tab clipped, " b, reps s ",
      "where b.pta_hw = s.r_name ",
      " and b.pta_hw not in ('Open','NA',' ') UNION ",
      "select unique s.r_name, s.r_link, '' ctp, '' ctp_link, 'SPR-HW' rep_type ",
      "from ", CtlRec.coverextend_tab clipped, " b, reps s ",
      "where b.spr_hw = s.r_name ",
      " and b.spr_hw not in ('Open','NA',' ') UNION ",
      "select unique s.r_name, s.r_link, '' ctp, '' ctp_link, 'SPR-Power' rep_type ",
      "from ", CtlRec.coverextend_tab clipped, " b, reps s ",
      "where b.spr_power = s.r_name ",
      " and b.spr_power not in ('Open','NA',' ') UNION ",
      "select unique s.r_name, s.r_link, '' ctp, '' ctp_link, 'SPR  ' rep_type ",
      "from ", CtlRec.coverextend_tab clipped, " b, reps s ",
      "where b.spr = s.r_name ",
      " and b.spr not in ('Open','NA',' ') "

#"select unique s.r_name, s.r_link, '' ctp, '' ctp_link, 'Flash' rep_type ",
      #"from ", CtlRec.coverextend_tab clipped, " b, reps s ",
      #"where b.flash = s.r_name ",
      #" and b.flash not in ('Open','NA',' ') UNION ",
## remove PTA and PCR
#      "select unique s.r_name, s.r_link, '' ctp, '' ctp_link, 'PTA  ' rep_type ",
#      "from ", CtlRec.coverextend_tab clipped, " b, reps s ",
#      "where b.pta = s.r_name ",
#      " and b.pta not in ('Open','NA',' ') UNION ",
#      "select unique s.r_name, s.r_link, '' ctp, '' ctp_link, 'PCR  ' rep_type ",
#      "from ", CtlRec.coverextend_tab clipped, " b, reps s ",
#      "where b.pcr = s.r_name ",
#      " and b.pcr not in ('Open','NA',' ')"

#display SQLStr
   prepare CID from SQLStr
   declare RepCurs cursor for CID


   let i = 1
   foreach RepCurs into RepArr[i].*, RepTypeArr[i]
      if( i mod 2 = 1 )then
         display "<tr>"
      end if
      call ShowCoverage( i, RepTypeArr[i] )
      if( i mod 2 = 0 )then
         display "</tr>"
      end if
      let i=i+1
   end foreach
   
   display "      </tbody>"
   display "   </table>"
end if  #if CtlRec.coverextend_tab

display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function ShowCoverage( in_bu, in_type )
define
   in_bu smallint,
   in_type char(10),
   field_type char(20),
   cov_cnt smallint,
   qStr char(512),
   wStr char(512),
   qtrStr char(1024),
   skillStr char(64),
   my_ssr like bus.b_ssr,
   my_ctp like bus.b_ctp,
   CTPStr char(200),
   RRec record like reps.*,
   repType char(5)

#display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 200px; vertical-align: middle'>"
display "<h3>"

display "<span style='font-size:14px;'>"
display repTypeArr[in_bu] clipped, " Rep <br /><a href='", RepArr[in_bu].ssr_link clipped, "' target='_blank'>",RepArr[in_bu].ssr clipped, "</a><p>"

case in_type
   when "SPR"
      let field_type="spr"
   when "SPR-HW"
      let field_type="spr_hw"
   when "SPR-Power"
      let field_type="spr_power"
   when "PTA"
      let field_type="pta"
   when "PTA-HW"
      let field_type="pta_hw"
end case

let cov_cnt = GetCoverageCnt(RepArr[in_bu].ssr, field_type)
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

case BRec.b_id
   when 'ST'
      let qtrStr = 
      "select a.* from ", cov_tab clipped, " a, ", CtlRec.coverextend_tab clipped, " b where a.ceid = b.ceid and (b.spr='", RepArr[in_bu].ssr clipped, "' and b.spr != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X') UNION ",
      "select a.* from ", cov_tab clipped, " a, ", CtlRec.coverextend_tab clipped, " b where a.ceid = b.ceid and (b.spr_hw='", RepArr[in_bu].ssr clipped, "' and b.spr_hw != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X') UNION ",
      "select a.* from ", cov_tab clipped, " a, ", CtlRec.coverextend_tab clipped, " b where a.ceid = b.ceid and (b.spr_power='", RepArr[in_bu].ssr clipped, "' and b.spr_power != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X') UNION ",
      "select a.* from ", cov_tab clipped, " a, ", CtlRec.coverextend_tab clipped, " b where a.ceid = b.ceid and (b.pta='", RepArr[in_bu].ssr clipped, "' and b.pta != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X') UNION ",
      "select a.* from ", cov_tab clipped, " a, ", CtlRec.coverextend_tab clipped, " b where a.ceid = b.ceid and (b.pta_hw='", RepArr[in_bu].ssr clipped, "' and b.pta_hw != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X') ",
      "order by a.part_name"
#      "select a.* from ", cov_tab clipped, " a, ", CtlRec.coverextend_tab clipped, " b where a.ceid = b.ceid and (b.pta='", RepArr[in_bu].ssr clipped, "' and b.pta != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X') UNION ",
#      "select a.* from ", cov_tab clipped, " a, ", CtlRec.coverextend_tab clipped, " b where a.ceid = b.ceid and (b.pcr='", RepArr[in_bu].ssr clipped, "' and b.pcr != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X')",

   end case

#display qtrStr
prepare QID from qtrStr

declare ACurs cursor for QID

display "</td>"
#display "<td style='text-align: left; width: 367px'>"
display "<td style='text-align: left; width: 450px'>"
display "<div>"


foreach ACurs into URec.*
   let skillStr = BuildSkillStr( 3 )

   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, ".html'>", URec.part_name clipped, "</a> "

#   display "<i><span style='font-size: 10px'><a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/R/", URec.ceid clipped, "-report.rtf' target='_blank'>download</a></span></i>"
   

   if( skillStr is not null )then
      display " <br /><span style='font-size: 12px'>&nbsp &nbsp &nbsp &nbsp &nbsp (", skillStr clipped, ") </span><span class='1b-half'></span>"
   end if

   display "<br/>"
end foreach

#display "</td></tr>"
display "</td>"

end function

function GetCoverageCnt( in_ssr, in_field )
define
   in_ssr like reps.r_link,
   in_field char(20),
   cnt smallint,
   SQLStr char(256)

let SQLStr = "select count(*) from ", CtlRec.coverextend_tab clipped, " a where a.", in_field clipped, "='", in_ssr clipped, "' "

#display SQLStr
prepare GCCID from SQLStr
execute GCCID into cnt

return cnt

end function  #GetCoverageCnt



