globals "globals.4gl"

main
define
   CrossRec record like cross.*,
   tpart_name like coverage_au.part_name,
   SQLStr char(128)

call ReadCmdLn( "pcrUpdate", 3 )
call ProcCmdLn( "pcrUpdate" )
call Header(0, IRec.i_id, BRec.b_id, 1)

display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>MASS PCR COVERAGE UPDATES</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, "</span></em></div>"
display "<p>"

display "<FORM ID='mass_ssr' ACTION='/cgi-bin/massRec", BRec.b_id clipped, ".ksh' method='post'>"
display "<INPUT TYPE=submit VALUE='Submit'>"
display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=601><br>"
display "This action will allow you to replace the PCR name in the records.<br>"

let SQLStr = "select a.* from cross a order by part_name"
prepare CRID from SQLStr
declare CRCurs cursor for CRID

foreach CRCurs into CrossRec.*
   display "<INPUT NAME='ceid' READONLY VALUE='", CrossRec.ceid clipped, "'>"
   display "<INPUT NAME='part_name' READONLY SIZE=50 VALUE='", CrossRec.part_name clipped, "'>"
   call ListBoxPCR( CrossRec.pcr )
end foreach

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

function ListBoxPCR( inSel )
define
   inSel like cross.pcr,
   sqlStr char(64),
   tssr like cross.pcr

   let sqlStr = "select unique a.pcr from cross a order by 1"
   prepare LBPCRID from sqlStr
   declare LBPCRCurs cursor for LBPCRID

   display "PCR: <SELECT NAME='pcr'>"

   foreach LBPCRCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT><br>"
end function  #ListBoxPCR

