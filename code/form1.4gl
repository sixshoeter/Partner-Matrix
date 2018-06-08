

globals "globals.4gl"

main

define
   i,cnt,mod_num smallint,
   colName char(15),
   old_n, new_n like eus.e_region,
   SQLStr char(512),
   f1Rec record 
      ceid like coverage_im.ceid,
      part_name like coverage_im.part_name,
      ssr like coverage_im.ssr,
      ctp like coverage_im.ctp
   end record 

call ReadCmdLn("findPartner", 4)
call ProcCmdLn("findPartner")
call Header(6, IRec.i_id, BRec.b_id, 1)
initialize old_n, new_n to null

display " "

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 16px'>Please select the desired filter options below. Each of your choices will further filter the results.</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 16px'>For Example: Checking both <i>Southwest</i> and <i>BPM</i> will find all Partners</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 16px'>selling in the <i>Southwest</i> Enterprise Unit that are top skilled in <i>BPM</i>.</span></em></div><p>"
display "<div dir='ltr' style='text-align: center'>"
display "<b>Important Note: Only TOP Skilled Partners will be returned from this query!</b></div>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"

display "<p dir='ltr'> &nbsp;</p>"

display "<h2>Query Inputs</h2>"
display "<form action=cgi-bin/", BRec.b_id clipped, "form1.ksh METHOD='GET'>"

let SQLStr = "select a.ceid, a.part_name, a.ssr, a.ctp from coverage_im a"
prepare f1ID from SQLStr
declare f1Curs cursor for f1ID
display "<fieldset>"

foreach f1Curs into f1Rec.*

display "<p>"
#display "<label><b><i>Enterprise Unit:</i></b></label>"
display "<br />"

display "<label><b><i>", f1Rec.ceid clipped, "</i></b></label>"
display "<label><b><i>", f1Rec.part_name clipped, "</i></b></label>"

display "<input type='text' name = '", f1Rec.ssr clipped, "' value = '", f1Rec.ssr clipped, "' />"
display "<input type='text' name = '", f1Rec.ctp clipped, "' value = '", f1Rec.ctp clipped, "' />"

end foreach
display "</fieldset>"

display "</p>"

let cnt = 0

display "</p>"
display "</fieldset>"

display "<input type='submit' value='Submit'>"
display "<input type='reset' value='Clear'>"
display "</form>"

call ShowVer( 0 )

end main

