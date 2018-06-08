
## Januaruy  19, 2015 - John M. Shoemaker, jshoe@us.ibm.com - change terminology from launch
## March     06, 2015 - John M. Shoemaker, jshoe@us.ibm.com - migate to units
## June      17, 2015 - John M. Shoemaker, jshoe@us.ibm.com - add PCRs
## July      17, 2015 - John M. Shoemaker, jshoe@us.ibm.com - add back TSS for Commerce

globals "globals.4gl"


main

define
   i smallint,
   tmp_t like eus.e_id,
   SQLStr char(256),
   tpcr like reps.r_name,
   tpcr_link like reps.r_link

call ReadCmdLn( "coverage_plan", 4 )
call ProcCmdLn( "coverage_plan" )
call Header(0, IRec.i_id, BRec.b_id, 1)

display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>E N G A G E * B R A N D * C O V E R A G E * P L A N</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "	<tbody>"

let SQLStr="select unique b.*, s.r_name, s.r_link, c.r_name, c.r_link, d.r_name, d.r_link ",
      "from eus b, reps s, outer reps c, outer reps d ",
      "where b.e_ssr = s.r_name ",
        "and b.e_ctp = c.r_name ",
        "and b.e_pcr = d.r_name ",
        "and b.e_brand = '", BRec.b_id clipped, "' order by b.e_id"
#display SQLStr
prepare CID from SQLStr
declare RepCurs cursor for CID

#display "<tr><th>Region","<th>", "Enterprise Unit","<th>", bprStr clipped, "</tr>"
case BRec.b_id
   when 'BU'
      display "<tr><th>Region","<th>", "Enterprise Unit","<th>", bprStr clipped, "<th>", tssStr clipped, "<th>", rpcrStr clipped, "</tr>"
   otherwise
      display "<tr><th>Region","<th>", "Enterprise Unit","<th>", bprStr clipped, "<th>", rpcrStr clipped, "</tr>"
end case
#display "<tr><th>Region","<th>", "Enterprise Unit","<th>", bprStr clipped, "<th>", rpcrStr clipped, "</tr>"
#display "<tr><th>Region","<th>", "Enterprise Unit","<th>", bprStr clipped, "<th>", tssStr clipped, "</tr>"
foreach RepCurs into EUArr[1].*, RepArr[1].*, tpcr, tpcr_link

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>", EUArr[1].e_region clipped
display "</td>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>", EUArr[1].e_name clipped
display "</td>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
if( RepArr[1].ssr != 'Open' )then
   display "<a href='", RepArr[1].ssr_link clipped, "' target='_blank'>",RepArr[1].ssr clipped, "</a>"
else
   display RepArr[1].ssr clipped
end if
display "</td>"


## TSS if needed
#case BRec.b_id
#   when 'BU'
      display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
      if( RepArr[1].ctp != 'Open' and RepArr[1].ctp != ' ')then
         display "<a href='", RepArr[1].ctp_link clipped, "' target='_blank'>", RepArr[1].ctp clipped, "</a>"
      else
         display RepArr[1].ctp clipped
      end if
      display "</td>"
#   otherwise
#end case

# for units, use field (CTP) for alternate SSR
{
if( RepArr[1].ctp != 'Open' )then
   display "<br><a href='", RepArr[1].ssr_link clipped, "' target='_blank'>",RepArr[1].ctp clipped, "</a>"
end if

}

## PCR
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
if( tpcr != 'Open' and tpcr != ' ')then
   display "<a href='", tpcr_link clipped, "' target='_blank'>", tpcr clipped, "</a>"
else
   display tpcr clipped
end if
display "</td>"

## don't display CTP as part of territory plan any longer (not with units)
{
if( RepArr[1].ctp != 'NA' )then
   display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
   if( RepArr[1].ctp != 'Open' )then
      display "<a href='", RepArr[1].ctp_link clipped, "' target='_blank'>",RepArr[1].ctp clipped, "</a>"
   else
      display RepArr[1].ctp clipped
   end if
end if
display "</td>"
}

display "</tr>"

end foreach

display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main


