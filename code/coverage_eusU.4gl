
##
#@  February 17, 2014 - John M. Shoemaker, add download of reports
## Januaruy  19, 2015 - John M. Shoemaker, jshoe@us.ibm.com - change terminology from launch
## March     05, 2015 - John M. Shoemaker, jshoe@us.ibm.com - migate to units
## June      11, 2015 - John M. Shoemaker, jshoe@us.ibm.com - migate to Commerce units
## August    05, 2015 - John M. Shoemaker, jshoe@us.ibm.com - show in 2 columns
## September 01, 2015 - John M. Shoemaker, jshoe@us.ibm.com - add TSS names #124
## September 22, 2015 - John M. Shoemaker, jshoe@us.ibm.com - add in Social Unit OU
## January   28, 2016 - John M. Shoemaker, jshoe@us.ibm.com - add filter on reseller code
## February 16, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #131 & #132
## February 16, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #134
## February  17, 2016 - John M. Shoemaker, filter out reseller X
## August    22, 2016 - John M. Shoemaker, modify titles per #185
## January   17, 2017 - John M. Shoemaker, remove download of reports (for now)
## February  15, 2017  John M. Shoemaker, change title menu variable, #207
## September 21, 2017  John M. Shoemaker, complete migration to focus 5 for AU, #249
## October   06, 2017 John M. Shoemaker, ignore case in part_name sort, #269

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
display "<em><span style='font-size: 20px'>", CtlRec.bpr_stext clipped, " Coverage", "</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", CtlRec.menu_str clipped,"</span></em></div>"
display "<p>"

#display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "<table align='center' border='1' dir='ltr' height='376' style='width: 950px' width='950'>"
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
      "where b.reseller != 'N' and b.ssr = s.r_name ",
      " and b.ssr not in ('Open','NA',' ')"

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
   if( i mod 2 = 1 )then
      display "<tr>"
   end if
   call ShowCoverage( i )
   if( i mod 2 = 0 )then
      display "</tr>"
   end if
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
   qStr char(512),
   wStr char(512),
   qtrStr char(768),
   skillStr char(64),
   my_ssr like bus.b_ssr,
   my_ctp like bus.b_ctp,
   CTPStr char(200),
   RRec record like reps.*

#display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 200px; vertical-align: middle'>"
#display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
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

if( NOT CTPPairFlg )then
   display "<br><br><span style='font-size:8px;'>TSS names in parans on right.</span>"
end if

display "</span"

if( UnitModeYN() )then
   case BRec.b_id
      when 'AU'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = c.ceid and a.ceid = d.ceid and (a.ssr='", RepArr[in_bu].ssr clipped, "' and a.ssr != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X')"
      when 'SU'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and a.ceid = o.ceid and (a.ssr='", RepArr[in_bu].ssr clipped, "' and a.ssr != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X')"

      when 'BU'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and (a.ssr='", RepArr[in_bu].ssr clipped, "' and a.ssr != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X')"

      when 'ST'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and (a.ssr='", RepArr[in_bu].ssr clipped, "' and a.ssr != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X')"

      otherwise
         let wStr = "where a.ceid = k.ceid and (a.ssr='", RepArr[in_bu].ssr clipped, "' and a.ssr != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X')"
   end case
else
   let wStr = "where a.ceid = k.ceid and (a.ssr='", RepArr[in_bu].ssr clipped, "' and a.ssr != ' ') and (a.reseller != 'N' or a.reseller = 'V' or a.reseller != 'X')"
end if  #UnitModeYN

if( CTPPairFlg )then
   let wStr = wStr clipped, " and a.ctp1='", RepArr[in_bu].ctp clipped, "'"
end if

let qtrStr = BuildBaseStr( BRec.b_id, TRUE )

let qtrStr = qtrStr clipped, " ", wStr clipped, " order by lower(a.part_name)"
#display qtrStr
prepare QID from qtrStr

declare ACurs cursor for QID

display "</td>"
#display "<td style='text-align: left; width: 367px'>"
display "<td style='text-align: left; width: 450px'>"
display "<div>"


foreach ACurs into URec.*, KRec.*
   let skillStr = BuildSkillStr( 3 )

   let CTPStr = GetCTPStr()
   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, ".html'>", URec.part_name clipped, "</a> "

   if( NOT CTPPairFlg )then
      display CTPStr clipped
   end if

   case URec.part_type 
      when "C"
         display "<i><span style='font-size: 10px'>[core]<span></i>"
      when "I"
         display "<i><span style='font-size: 10px'>[invest]<span></i>"
      when "O"
         display "<i><span style='font-size: 10px'>[opportunistic]<span></i>"
      when "D"
         display "<i><span style='font-size: 10px'>[dormant]<span></i>"
   end case

   case URec.reseller 
      when "E"
         display "<i><span style='font-size: 10px'>(Emerging)</span></i>"
      when "H"
         Display "<i><span style='font-size: 10px'>(HV)</span></i>"
      when "S"
         display "<i><span style='font-size: 10px'>(Services)</span></i>"
   end case

   if( CtlRec.allowdownload )then
      display "<i><span style='font-size: 10px'><a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/R/", URec.ceid clipped, "-report.rtf' target='_blank'>download</a></span></i>"
   end if  #CtlRec.allowdownload
   

   if( skillStr is not null )then
      display " <br /><span style='font-size: 12px'>&nbsp &nbsp &nbsp &nbsp &nbsp (", skillStr clipped, ") </span><span class='1b-half'></span>"
   end if

   display "<br/>"
end foreach

#display "</td></tr>"
display "</td>"

end function

function GetCoverageCnt( in_ssr, in_ctp )
define
   in_ssr like reps.r_link,
   in_ctp like reps.r_link,
   cnt smallint,
   SQLStr char(256)

let SQLStr = "select count(*) from ", cov_tab clipped, " a where a.ssr='", in_ssr clipped, "' and (a.reseller != 'N' and a.reseller != 'V')"
#if( CTPPairFlg )then
# let SQLStr = SQLStr clipped, " and a.ctp='", in_ctp clipped, "'"
#end if

#display SQLStr
prepare GCCID from SQLStr
execute GCCID into cnt

return cnt

end function  #GetCoverageCnt



function GetCTPStr()

define
   CTPStr char(200)

   initialize CTPStr to NULL

   if( URec.ctp1 is not null and URec.ctp1 != " ")then
      let CTPStr = "<span style='font-size: 8px'>(", URec.ctp1 clipped
   end if

   if( URec.ctp2 is not null and URec.ctp2 != " ")then
      if(CTPStr is not NULL )then
         let CTPStr = CTPStr clipped, ",", URec.ctp2 clipped
      else
         let CTPStr = "<span style='font-size: 8px'>(", URec.ctp2 clipped
      end if
   end if

   if( URec.ctp3 is not null and URec.ctp3 != " ")then
      if(CTPStr is not NULL )then
         let CTPStr = CTPStr clipped, ",", URec.ctp3 clipped
      else
         let CTPStr = "<span style='font-size: 8px'>(", URec.ctp3 clipped
      end if
   end if

   if( URec.ctp4 is not null and URec.ctp4 != " ")then
      if(CTPStr is not NULL )then
         let CTPStr = CTPStr clipped, ",", URec.ctp4 clipped
      else
         let CTPStr = "<span style='font-size: 8px'>(", URec.ctp4 clipped
      end if
   end if

   if( URec.ctp5 is not null and URec.ctp5 != " ")then
      if(CTPStr is not NULL )then
         let CTPStr = CTPStr clipped, ",", URec.ctp5 clipped
      else
         let CTPStr = "<span style='font-size: 8px'>(", URec.ctp5 clipped
      end if
   end if


   if(CTPStr is not NULL )then
      let CTPStr = CTPStr clipped, ")</span>"
   end if
return CTPStr

end function  #GetCTPStr

