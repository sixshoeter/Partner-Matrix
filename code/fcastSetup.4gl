globals "globals.4gl"

main
define
   FcastBprRec record like fcast_bpr.*,
   FcastRec record like fcast_au.*,
   SQLStr char(128)

call ReadCmdLn( "fcastUpdate", 3 )
call ProcCmdLn( "fcastUpdate" )
call Header(0, IRec.i_id, BRec.b_id, 1)

display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>UPDATE FORECAST </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, "</span></em></div>"
display "<p>"

display "<FORM ID='fcast_upd' ACTION='/cgi-bin/fcastRec", BRec.b_id clipped, ".ksh' method='post'>"
display "EMAIL (required to update): <INPUT NAME='bemail' TYPE=email size=20 required>"
display "<INPUT TYPE=submit VALUE='Submit'>"
display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=701><br>"
display "This action will allow you to update your Forecast.<br>"

display "</FORM>"


end main
