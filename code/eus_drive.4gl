##
## March   31, 2014 John M. Shoemaker, create eus_drive.4gl

globals "globals.4gl"

main

define
   i smallint,
   str char(20)

call ReadCmdLn( "EUS", 4 )
call ProcCmdLn( "EUS" )
call Header(5, IRec.i_id, BRec.b_id, 1)

display " "
let str = DOWNSHIFT(BRec.b_id)

display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed below are selling into these Enterprise Units. </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>Those Partners with 'top' skills have the skills listed in (parens).</span></em></div><p>"
display "<div dir='ltr' style='text-align: center'>"
#display "	<em><span style='font-size: 16px'>The TOP Skilled Partners are marked with '*'. <a HREF='/query_", str clipped, ".html'>Find a Partner</a></span></em>"
display "</div><p>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

#display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
#display "	<tbody>"

display "<form class='regForm' id='regionForm' action=cgi-bin/", BRec.b_id clipped, "_eus_drive.ksh METHOD='GET'>"
display "<fieldset>"
display "<legend>Select Region / Enterprise Unit</legend>"
display "<p>"
display "<label Select list</label>"
display "<select id='regList' name='regList' onchange='this.form.submit()'>"

display "<option value='0'>Make section here</option>"
for i = 1 to G_EUcnt
## constrain to only those EUs that we have column names for
   if( i <= G_NumCols )then
      display "<option value='", i using "<<", "'>", EUArr[i].e_region clipped, " - ", EUArr[i].e_name clipped, "</option>"
   end if
end for
display "</select>"
display "</p>"
display "</fieldset>"
display "<noscript>"
display "<input type='submit' value='Submit'>"
display "<input type='reset' value='Clear'>"
display "</noscript>"

display "</form>"


#display "      </tbody>"
#display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"

call ShowVer( 0 )

end main

