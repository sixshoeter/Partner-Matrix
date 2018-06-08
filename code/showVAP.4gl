## March 06, 2014 - John - create showVAP.4gl

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
    TMPRec record 
       ceid like coverage_au.ceid,
       part_name like coverage_au.part_name,
       url like coverage_au.url,
       pwp like coverage_au.pwp
    end record

call ReadCmdLn( "showVAP", 4 )
call ProcCmdLn( "showVAP" )
call GetColor(BRec.b_id, 0,1) returning colorStr, textcolorStr

let colorArr[4] = "#00FF00"
let colorArr[3] = "#99FF99"
let colorArr[2] = "#FFFFCC"
let colorArr[1] = "#FFFFFF"

#let BrandArr[5] = "LO"
#let BrandArr[4] = "RA"
#let BrandArr[3] = "TI"
#let BrandArr[2] = "IM"
#let BrandArr[1] = "WS"

   let qtrStr = "select a.ceid, a.part_name, a.url, a.pwp ",
   "from ", cov_tab clipped, " a ",
   "where a.ceid = '", CLRec.CEID clipped, "' "

call ShowTitle( TRUE )
display " "

#display qtrStr
prepare QID from qtrStr
declare ACurs cursor for QID
foreach ACurs into TMPRec.*

display "<table align='center' border='0' style='width: 744px'>"
display "<tbody>"
display "<tr>"
display "<td style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<h1 style='text-align: center'>"
display "<span style='color: #ffffff'><span style='font-size: 36px'>",TMPRec.part_name clipped, "</span></span></h1>"
display "</td>"
display "<td style='text-align: center; width: 191px; vertical-align: middle'>"
#display "<div>"
display "<div style='text-align: center'>"

## make url consistent with http prefix
if( TMPRec.url[1,4] = "http" )then
   let tURL = TMPRec.url clipped
else
   let tURL = "http://", TMPRec.url clipped
end if

display "<span style='font-size: 12pt'><a href='", tURL clipped, "' target='_blank'>", TMPRec.url clipped,"</a></span></div>"

## display the PW Profile if present
if( TMPRec.pwp is not null) then
   display "<div style='text-align: center'>"
   display "<span style='font-size: 12pt'><a href='", TMPRec.pwp clipped, "' target='_blank'>PartnerWorld Profile", "</a></span></div>"
end if


## display the CEID
display "<div style='text-align: center'>"
display "<span style='font-size: 12pt'>CEID: ", TMPRec.ceid clipped,"</span></div>"
display "<span style='visibility: hidden'><span style='font-size: 133%'><span style='position: absolute; left: -4.92%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></span>"
#display "</div>"
display "</td>"
display "<td style='text-align: center; width: 115px; vertical-align: middle'>"
display "<img  style='block; width: auto; height: auto'; src='/", IRec.i_id clipped, "/I/", TMPRec.ceid clipped,".jpg' id='theImdID' /></td>"
display "</tr>"


display "</tbody>"
display "</table>"

display "<BR \>"

## VAP Section 
let G_VAPcnt = LoadVAP( TMPRec.ceid )

display "<table align='center' border='1' height='60' width='1341'>"
display "<tbody>"
display "<tr>"
display "<td colspan='100' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<span style='color: #ffffff'><span style='font-size: 22px'>", BRec.b_name clipped, " VAP Details</span></span></td>"
display "</tr>"
display "&nbsp;</p>"

display "<th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "Solution Name", "</strong></th>"

display "<th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "SVP Group(s)", "</strong></th>"

display "<th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "Solution Area", "</strong></th>"

display "<th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "Value Add Type", "</strong></th>"

display "<th class='centerText'; style='background-color: #add8e6; width=300px'>"
display "<strong>", "Description", "</strong></th>"

display "<th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "Solution ID", "</strong></th>"

display "<th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "Status", "</strong></th>"

 

for i = 1 to G_VAPcnt
   let vap_str = GetVAPforBrand(BRec.b_id, i)

if( vap_str is not NULL ) then
   display "<tr>"
   display "<td>"
   display "<strong>", VAPArr[i].sol_name clipped, "</strong></td>"

   display "<td>"
   display "<strong>", vap_str clipped, "</strong></td>"

   display "<td>"
   display "<strong>", VAPArr[i].sol_area clipped, "</strong></td>"

   display "<td>"
   display "<strong>", VAPArr[i].va_type clipped, "</strong></td>"

   display "<td 'style=width: 300px'>"
   display "<strong>", VAPArr[i].va_desc clipped, "</strong></td>"

   display "<td>"
   display "<strong>", VAPArr[i].sol_id clipped, "</strong></td>"

   display "<td>"
   display "<strong>", VAPArr[i].sol_status clipped, "</strong></td>"

   display "</tr>"
end if
end for

display "</tbody>"
display "</table>"
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
end foreach

call ShowVer( 1 )

end main

{
function ShowTitle()

   call Header(0, IRec.i_id, BRec.b_id, 1)

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

end function  #ShowTitle
}
