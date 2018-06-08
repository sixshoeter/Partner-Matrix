##
## March 28, 2014  John M. Shoemaker, jshoemaker1@cox.net - require a selection of radio buttons
## February 02, 2015  John M. Shoemaker, jshoemaker1@cox.net, convert to Units
## February 06, 2015  John M. Shoemaker, jshoemaker1@cox.net, fix sort/db skill column ID
##

globals "globals.4gl"

main

define
   i,cnt,mod_num,idx,oidx smallint,
   colName char(15),
   old_n, new_n like eus.e_region,
   scat_cnt smallint

call ReadCmdLn("findPartner", 4)
call ProcCmdLn("findPartner")
call Header(6, IRec.i_id, BRec.b_id, 1)
initialize old_n, new_n to null

## load skill categories if available
if( CtlRec.skill_cat )then
   let scat_cnt = LoadSkillCat( BRec.b_id )
end if


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
display "<form action=cgi-bin/", BRec.b_id clipped, "query_eus.ksh>"

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
#display "<label><b><i>Enterprise Unit:</i></b></label>"
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
   when "SC"
      let mod_num = 3
   otherwise
      let mod_num = 4
end case

let new_n = EUArr[1].e_region
let old_n = new_n
display "<label><b><i>", new_n clipped, "</i></b></label>"
display "<br />"

for i = 1 to G_EUcnt
   let new_n = EUArr[i].e_region

    if( new_n != old_n )then
       display "<br />"
       display "<label><b><i>", new_n clipped, "</i></b></label>"
       display "<br />"
       let old_n = new_n
    end if

     let cnt = EUArr[i].e_id
     let colName = EUColNamesArr[ cnt ].colname

    display "<input type='radio'"
    display "   name = 'eu'"
    display "   value = '", colName clipped, "' required='required'/>"
    display "  <label for = 'chkEU", EUArr[i].e_id using "<<", "'>", 
              EUArr[i].e_name clipped, "</label>"
end for

display "</p>"
display "</fieldset>"

## show skills
display "<fieldset>"
display "<p>"
display "<label><b><i>Skills:</i></b></label>"
display "<br />"

let cnt = 0
let idx = 0
let oidx = 0
for i = 1 to SkillsMax
    if( SkillArr[i].s_name != "NA" )then
       let cnt = cnt + 1  

    if(CtlRec.skill_cat )then
       let idx = SkillArr[i].c_id
       if( idx > oidx )then
          display "<p><em>", SkillCatArr[idx].c_long clipped,"</em><br />"
          let oidx = idx
          let cnt = 1
       end if
    end if
#   display "Category", i, scat_cnt, SkillCatArr[i].c_id, SkillArr[i].c_id

       display "<input type='checkbox'"
       display "   name = 'skill_", SkillArr[i].db_num using "&&", "'"
       display "   value = 'skill_", SkillArr[i].db_num using "&&", "' />"
#       display "   name = 'skill_", i using "&&", "'"
#       display "   value = 'skill_", i using "&&", "' />"
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

