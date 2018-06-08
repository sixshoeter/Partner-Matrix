
##  May  08, 2014 - John M. Shoemaker, create from coverate_eus.4gl
## Januaruy  19, 2015 - John M. Shoemaker, jshoe@us.ibm.com - change terminology from launch
## March     05, 2015 - John M. Shoemaker, jshoe@us.ibm.com - migate to units
## April     08, 2015 - John M. Shoemaker, jshoe@us.ibm.com - allow for spaces in ctp
## June      09, 2015 - John M. Shoemaker, jshoe@us.ibm.com - include ctp4/5
## June      11, 2015 - John M. Shoemaker, jshoe@us.ibm.com - migate Commerce to units
## August    05, 2015 - John M. Shoemaker, jshoe@us.ibm.com - move to 2 columns
## September 01, 2015 - John M. Shoemaker, jshoe@us.ibm.com - add BPR #124
## September 22, 2015 - John M. Shoemaker, jshoe@us.ibm.com - add in Social Unit OU
## February 15, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #131 & #132
## February 16, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #134
## February  17, 2016 John M. Shoemaker, filter out reseller X

globals "globals.4gl"

main

define
   i smallint,
   SQLStr char(2048)

call ReadCmdLn( "coverage", 4 )
call ProcCmdLn( "coverage" )
call Header(0, IRec.i_id, BRec.b_id, 1)

display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>B U I L D * B R A N D * C O V E R A G E (by TSS)</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

#display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "<table align='center' border='1' dir='ltr' height='376' style='width: 950px' width='950'>"
display "	<tbody>"

## use coverage file to determine ctp
   let SQLStr="select unique '' ssr, '' ssr_link, s.r_name, s.r_link ",
      "from ", cov_tab clipped, " b, reps s ",
      "where b.ctp1 = s.r_name ",
      " and b.ctp1 not in ('Open','NA', ' ')"
   let SQLStr=SQLStr clipped, " union select unique '' ssr, '' ssr_link, s.r_name, s.r_link ",
      "from ", cov_tab clipped, " b, reps s ",
      "where b.ctp2 = s.r_name ",
      " and b.ctp2 not in ('Open','NA', ' ')"
   let SQLStr=SQLStr clipped, " union select unique '' ssr, '' ssr_link, s.r_name, s.r_link ",
      "from ", cov_tab clipped, " b, reps s ",
      "where b.ctp3 = s.r_name ",
      " and b.ctp3 not in ('Open','NA', ' ')"
   let SQLStr=SQLStr clipped, " union select unique '' ssr, '' ssr_link, s.r_name, s.r_link ",
      "from ", cov_tab clipped, " b, reps s ",
      "where b.ctp4 = s.r_name ",
      " and b.ctp4 not in ('Open','NA', ' ')"
   let SQLStr=SQLStr clipped, " union select unique '' ssr, '' ssr_link, s.r_name, s.r_link ",
      "from ", cov_tab clipped, " b, reps s ",
      "where b.ctp5 = s.r_name ",
      " and b.ctp5 not in ('Open','NA', ' ')"
#display SQLStr
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
   qStr char(1024),
   wStr char(1024),
   qtrStr char(1024),
   skillStr char(64),
   my_ssr like bus.b_ssr,
   my_ctp like bus.b_ctp,
   SSRStr char(200),
   RRec record like reps.*

#display "<tr>"
#display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 200px; vertical-align: middle'>"
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

display "<br><br><span style='font-size:8px;'>BPR names in parans on right.</span>"

display "</span"

if( UnitModeYN() )then
   case BRec.b_id
      when 'AU'
         let wStr = "where a.ceid = k.ceid and ",
                    " a.ceid = l.ceid and ",
                    " a.ceid = m.ceid and ",
                    " a.ceid = n.ceid and ",
                    " ((a.ctp1='", RepArr[in_bu].ctp clipped, "' and a.ctp1 != ' ' ) or ",
                    "  (a.ctp2='", RepArr[in_bu].ctp clipped, "' and a.ctp2 != ' ' ) or ",
                    "  (a.ctp3='", RepArr[in_bu].ctp clipped, "' and a.ctp3 != ' ' ) or ",
                    "  (a.ctp4='", RepArr[in_bu].ctp clipped, "' and a.ctp4 != ' ' ) or ",
                    "  (a.ctp5='", RepArr[in_bu].ctp clipped, "' and a.ctp5 != ' ' ) ) ",
                    " and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' "
      when 'SU'
         let wStr = "where a.ceid = k.ceid and ",
                    " a.ceid = l.ceid and ",
                    " a.ceid = m.ceid and ",
                    " a.ceid = n.ceid and ",
                    " a.ceid = o.ceid and ",
                    " ((a.ctp1='", RepArr[in_bu].ctp clipped, "' and a.ctp1 != ' ' )or ",
                    "  (a.ctp2='", RepArr[in_bu].ctp clipped, "' and a.ctp2 != ' ' )or ",
                    "  (a.ctp3='", RepArr[in_bu].ctp clipped, "' and a.ctp3 != ' ' )or ",
                    "  (a.ctp4='", RepArr[in_bu].ctp clipped, "' and a.ctp4 != ' ' )or ",
                    "  (a.ctp5='", RepArr[in_bu].ctp clipped, "' and a.ctp5 != ' ' )) ",
                    " and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' "
      when 'CU'
         let wStr = "where a.ceid = k.ceid and ",
                    " ((a.ctp1='", RepArr[in_bu].ctp clipped, "' and a.ctp1 != ' ' ) or ",
                    "  (a.ctp2='", RepArr[in_bu].ctp clipped, "' and a.ctp2 != ' ' ) or ",
                    "  (a.ctp3='", RepArr[in_bu].ctp clipped, "' and a.ctp3 != ' ' ) or ",
                    "  (a.ctp4='", RepArr[in_bu].ctp clipped, "' and a.ctp4 != ' ' ) or ",
                    "  (a.ctp5='", RepArr[in_bu].ctp clipped, "' and a.ctp5 != ' ' ) ) ",
                    " and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' "
      when 'BU'
         let wStr = "where a.ceid = k.ceid and ",
                    " ((a.ctp1='", RepArr[in_bu].ctp clipped, "' and a.ctp1 != ' ' ) or ",
                    "  (a.ctp2='", RepArr[in_bu].ctp clipped, "' and a.ctp2 != ' ' ) or ",
                    "  (a.ctp3='", RepArr[in_bu].ctp clipped, "' and a.ctp3 != ' ' ) or ",
                    "  (a.ctp4='", RepArr[in_bu].ctp clipped, "' and a.ctp4 != ' ' ) or ",
                    "  (a.ctp5='", RepArr[in_bu].ctp clipped, "' and a.ctp5 != ' ' ) ) ",
                    " and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' "
      when 'ST'
         let wStr = "where a.ceid = k.ceid and ",
                    " ((a.ctp1='", RepArr[in_bu].ctp clipped, "' and a.ctp1 != ' ' )or ",
                    "  (a.ctp2='", RepArr[in_bu].ctp clipped, "' and a.ctp2 != ' ' )or ",
                    "  (a.ctp3='", RepArr[in_bu].ctp clipped, "' and a.ctp3 != ' ' )or ",
                    "  (a.ctp4='", RepArr[in_bu].ctp clipped, "' and a.ctp4 != ' ' )or ",
                    "  (a.ctp5='", RepArr[in_bu].ctp clipped, "' and a.ctp5 != ' ' )) ",
                    " and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' "
      when 'ES'
         let wStr = "where a.ceid = k.ceid and ",
                    " ((a.ctp1='", RepArr[in_bu].ctp clipped, "' and a.ctp1 != ' ' )or ",
                    "  (a.ctp2='", RepArr[in_bu].ctp clipped, "' and a.ctp2 != ' ' )or ",
                    "  (a.ctp3='", RepArr[in_bu].ctp clipped, "' and a.ctp3 != ' ' )or ",
                    "  (a.ctp4='", RepArr[in_bu].ctp clipped, "' and a.ctp4 != ' ' )or ",
                    "  (a.ctp5='", RepArr[in_bu].ctp clipped, "' and a.ctp5 != ' ' )) ",
                    " and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' "

      when 'OU'
         let wStr = " "

      otherwise
         let wStr = "where a.ceid = k.ceid and ",
                    " ((a.ctp1='", RepArr[in_bu].ctp clipped, "' and a.ctp1 != ' ' )or ",
                    "  (a.ctp2='", RepArr[in_bu].ctp clipped, "' and a.ctp2 != ' ' )or ",
                    "  (a.ctp3='", RepArr[in_bu].ctp clipped, "' and a.ctp3 != ' ' )or ",
                    "  (a.ctp4='", RepArr[in_bu].ctp clipped, "' and a.ctp4 != ' ' )or ",
                    "  (a.ctp5='", RepArr[in_bu].ctp clipped, "' and a.ctp5 != ' ' )) ",
                    " and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' "
   end case

  let wStr = wStr clipped, " ", 
             " and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' "
end if  #UnitModerYN

let qtrStr = BuildBaseStr( BRec.b_id, TRUE )

let qtrStr = qtrStr clipped, " ", wStr clipped, " order by a.part_name"
#display qtrStr
prepare QID from qtrStr

declare ACurs cursor for QID

display "</td>"
#display "<td style='text-align: left; width: 367px'>"
display "<td style='text-align: left; width: 450px'>"
display "<div>"


foreach ACurs into URec.*, KRec.*
   let skillStr = BuildSkillStr( 3 )

   let SSRStr = GetSSRStr()
   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, ".html'>", URec.part_name clipped, "</a> ", SSRStr clipped
{
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
         display "<i><span style='font-size: 10px'>(S)</span></i>"
   end case
}
 
   display "<i><span style='font-size: 10px'><a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/R/", URec.ceid clipped, "-report.rtf' target='_blank'>download</a></span></i>"


   if( skillStr is not null )then
      display " <br /><span style='font-size: 12px'>&nbsp &nbsp &nbsp &nbsp &nbsp (", skillStr clipped, ") </span><span class='1b-half'></span>"
   end if

   display "<br/>"
end foreach

display "</td>"
#display "</td></tr>"

end function

function GetCoverageCnt( in_ssr, in_ctp )
define
   in_ssr like reps.r_link,
   in_ctp like reps.r_link,
   cnt smallint,
   SQLStr char(512)

let SQLStr = "select count(*) from ", cov_tab clipped, " a where ("

if( NOT CtlRec.onlyshowaca )then
   let SQLStr = SQLStr clipped, " ",
             " a.ctp1='", in_ctp clipped, "' or ",
             "  a.ctp2='", in_ctp clipped, "' or ",
             "  a.ctp3='", in_ctp clipped, "' or ",
             "  a.ctp4='", in_ctp clipped, "' or "
end if
   let SQLStr = SQLStr clipped, " ",
	     "  a.ctp5='", in_ctp clipped, "' ) ",
	     " and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' "

#display SQLStr
prepare GCCID from SQLStr
execute GCCID into cnt

return cnt

end function  #GetCoverageCnt

{
function GetSSRStr()

define
   SSRStr char(200)

   initialize SSRStr to NULL

   if( URec.ssr is not null and URec.ssr != ' ')then
      let SSRStr = "<span style='font-size: 8px'>(", URec.ssr clipped
   end if

   if(SSRStr is not NULL )then
      let SSRStr = SSRStr clipped, ")</span>"
   end if
return SSRStr

end function  #GetSSRStr
}
