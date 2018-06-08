## June      23, 2016 - John Shoemaker jshoemaker1@cox.net - create showSolutions.4gl, #183

globals "globals.4gl"

#define
#  BrandArr array[5] of char(2)

main

define
    i smallint,
    color_idx smallint,
    qtrStr char(256),
    colorStr char(16),
    textcolorStr char(16),
    colorArr array[4] of char(7),
    tURL char(60),
    vap_cnt smallint,
    vap_str char(128),
    tCEID like gsd_solutions.ceid,
    tcomp_name like gsd_solutions.comp_name,
    TMPRec record like gsd_solutions.*


call ReadCmdLn( "showGSD", 5 )
call ProcCmdLn( "showGSD" )
let tCEID=CLRec.CEID
let tcomp_name=arg_val(5)
#let tCEID="18z7821h"
#let tcomp_name="Data Repository and Appliances"

call GetColor(BRec.b_id, 0,1) returning colorStr, textcolorStr

let colorArr[4] = "#00FF00"
let colorArr[3] = "#99FF99"
let colorArr[2] = "#FFFFCC"
let colorArr[1] = "#FFFFFF"

call ShowTitleLoc()
display " "


#display "<td style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
#display "<h1 style='text-align: center'>"
#display "<span style='color: #ffffff'><span style='font-size: 36px'>",TMPRec.part_name clipped, "</span></span></h1>"
#display "</td>"
display "<table align='center' border='0' style='width: 544px'>"
display "<tbody>"
display "<tr>"
display "<td style='text-align: center; width: 191px; vertical-align: middle'>"
#display "<div>"

## display the CEID
display "<div style='text-align: center'>"
display "<span style='font-size: 12pt'>CEID: ", tCEID clipped,"</span></div>"
display "<span style='visibility: hidden'><span style='font-size: 133%'><span style='position: absolute; left: -4.92%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></span>"
#display "</div>"
display "</td>"
display "<td style='text-align: center; width: 115px; vertical-align: middle'>"
display "<img  style='block; width: auto; height: auto'; src='/", IRec.i_id clipped, "/I/", tCEID clipped,".jpg' id='theImdID' /></td>"
display "</tr>"


display "</tbody>"
display "</table>"

display "<BR \>"

## Solution Section 

display "<table align='center' border='1' height='60' width='900'>"
display "<tbody>"
display "<tr>"
display "<td colspan='100' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<span style='color: #ffffff'><span style='font-size: 22px'>", BRec.b_name clipped, " Partner Solution Details</span></span></td>"
display "</tr>"
display "&nbsp;</p>"

display "<th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "Solution Name", "</strong></th>"

display "<th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "Competency", "</strong></th>"

display "<th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "Solution ID (link to GSD Details)", "</strong></th>"

let qtrStr = "select a.* from gsd_solutions a where a.ceid='", tCEID clipped, "' and a.comp_name='", tcomp_name clipped, "'"
#   "where a.ceid = '", CLRec.CEID clipped, "' "

#display qtrStr
prepare QID from qtrStr
declare ACurs cursor for QID
foreach ACurs into TMPRec.*
   display "<tr>"
   display "<td>"
   display "<strong>", TMPRec.sol_name clipped, "</strong></td>"

   display "<td>"
   display "<strong>", TMPRec.comp_name clipped, "</strong></td>"

   display "<td>"
   display "<strong>", "<a href='http://www-304.ibm.com/partnerworld/gsd/solutiondetails.do?solution=", TMPRec.sol_id using "<<<<<<", "' target='_blank'>", TMPRec.sol_id clipped, "</a>", "</strong></td>"
#   display "<strong>", TMPRec.sol_url clipped, "</strong></td>"

   display "</tr>"
end foreach

display "</tbody>"
display "</table>"
display "<br />"

display "<div style='text-align: center'>"
display "<span style='font-size: 12pt'>*** Notice : There may be a disconnect between the number of Solutions identified on the previous page and the number of actual solutions shown here.</span></div>"
display "<br />"


## close out the page
display "<p>"

display "<span style='visibility: hidden'><span style='font-size: 78%'><span style='position: absolute; left: -2.94%'><span style='color: #7889fb'>–</span></span></span></span></div>"
display "<div>"
display "		<span style='font-size: 78%'><span style='position: absolute; left: -2.65%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></div>"
display "	<div>"
display "		<span style='visibility: hidden'><span style='font-size: 133%'><span style='position: absolute; left: -2.65%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></span></div>"
display "</div>"
display "<p dir='ltr'>"
display "	&nbsp;</p>"


call ShowVer( 1 )

end main

function ShowTitleLoc()

   call Header(0, IRec.i_id, BRec.b_id, 1)

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

end function  #ShowTitleLoc

