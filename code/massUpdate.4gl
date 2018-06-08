
## June   29, 2015 John M. Shoemaker, add lookup from entire reps table

globals "globals.4gl"

main

call ReadCmdLn( "massUpdate", 3 )
call ProcCmdLn( "massUpdate" )
call Header(0, IRec.i_id, BRec.b_id, 1)

display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>MASS COVERAGE UPDATES</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

   display "<FORM ID='mass_ssr' ACTION='/cgi-bin/massRec", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT TYPE=submit VALUE='Submit'>"
   display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=508><br>"
   display "This action will replace the BPR name in all matching Partner Matrix records.<br>"
   display "Replace ALL occurances of this BPR Name: "
   call ListBoxSSR( "" )
   display "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;With this BPR Name: "
   call ListBoxREP( "" )
   display "</FORM>"


end main

function ListBoxSSR( inSel )
define
   inSel like coverage_au.ssr,
   sqlStr char(64),
   tssr like coverage_au.ssr

   let sqlStr = "select unique a.ssr from ", cov_tab clipped, " a order by 1"
   prepare LBSSRID from sqlStr
   declare LBSSRCurs cursor for LBSSRID

   display "BPR: <SELECT NAME='ssr'>"

   foreach LBSSRCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT><br>"
end function  #ListBoxSSR

function ListBoxREP( inSel )
define
   inSel like coverage_au.ssr,
   sqlStr char(64),
   tssr like coverage_au.ssr

   let sqlStr = "select unique a.r_name from reps a where a.r_name not in ('VAD') order by 1"
   prepare LBREPID from sqlStr
   declare LBREPCurs cursor for LBREPID

   display "BPR: <SELECT NAME='ssr'>"

   foreach LBREPCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT><br>"
end function  #ListBoxREP

