

globals "globals.4gl"

main

define
   i,cnt,mod_num smallint,
   colName char(15)

call ReadCmdLn("findPartner", 4)
call ProcCmdLn("findPartner")
call Header(6, IRec.i_id, BRec.b_id, 1)

display " "

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 16px'>Please select the desired filter options below. Each of your choices will further filter the results.</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 16px'>For Example: Checking both <i>Pacifics</i> and <i>Southeast</i> and checking <i>BPM</i> will find all Partners</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 16px'>selling in BOTH the <i>Pacifics</i> and <i>Southeast</i> Business Units that are top skilled in <i>BPM</i>.</span></em></div><p>"
display "<div dir='ltr' style='text-align: center'>"
display "<b>Important Note: Only TOP Skilled Partners will be returned from this query!</b></div>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"

display "<p dir='ltr'> &nbsp;</p>"

display "<h2>Query Inputs</h2>"
display "<form action=cgi-bin/", BRec.b_id clipped, "query.ksh>"

## don't use right now
if( BRec.b_id = "XX" )then
   display "<fieldset>"
   display "<p>"
   display "<label><b><i>High Value Partners:</i></b></label>"
   display "<br />"
   display "<input type='checkbox'"
   display "   name='reseller'"
   display "   value = 'reseller' />"
   display "<lable for = 'chkHVP'>Only Show High Value Partners</label>"
   display "</p>"
   display "</fieldset>"
end if

display "<fieldset>"
display "<p>"
display "<label><b><i>Business Unit:</i></b></label>"
display "<br />"

case BRec.b_id
   when "WS"
      let mod_num = 5
   when "IM"
      let mod_num = 3
   when "TI"
      let mod_num = 5
   when "RA"
      let mod_num = 2
   when "LO"
      let mod_num = 5
end case

for i = 1 to 10

case BUArr[i].b_id
   when 1
      let colName = "bu_midwest"
   when 2
      let colName = "bu_pacifics"
   when 3
      let colName = "bu_greatwest"
   when 4
      let colName = "bu_southeast"
   when 5
      let colName = "bu_midatl"
   when 6
      let colName = "bu_ny"
   when 7
      let colName = "bu_northeast"
   when 8
      let colName = "bu_grtlakes"
   when 9
      let colName = "bu_federal"
   when 10
      let colName = "bu_canada"
end case

    display "<input type='radio'"
    display "   name = 'bu'"
    display "   value = '", colName clipped, "' />"
    display "  <label for = 'chkBU", BUArr[i].b_id using "<<", "'>", 
              BUArr[i].b_name clipped, "</label>"
    if( i mod 5 = 0 )then
       display "<br />"
    end if
end for

display "</p>"
display "</fieldset>"

## show skills
display "<fieldset>"
display "<p>"
display "<label><b><i>Skills:</i></b></label>"
display "<br />"

let cnt = 0
for i = 1 to SkillsMax
    if( SkillArr[i].s_name != "NA" )then
       let cnt = cnt + 1  
       display "<input type='checkbox'"
       display "   name = 'skill_'", i using "&&", "'"
       display "   value = 'skill_", i using "&&", "' />"
#       display "   value = '", BRec.b_id clipped, ".skill_", i using "&&", "' />"
       display "  <label for = 'chkSK'>", 
                 SkillArr[i].s_desc clipped, "</label>"
       if( (cnt mod mod_num ) = 0 )then
          display "<br />"
       end if
    end if

end for

display "</p>"
display "</fieldset>"

display "<input type='submit' value='Submit'>"
display "<input type='reset' value='Clear'>"
display "</form>"

call ShowVer( 0 )

end main

