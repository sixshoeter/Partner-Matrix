
database partners

globals
define
    ARec record like coverage.*
end globals

main

define
   i smallint

display "<table align='center' border='0' dir='ltr' style='width: 625px;'>"
display "	<tbody>"
display "		<tr>"
display "		<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "	<span style='font-size:14px;'><a href='../H/home.html'> "
display "<span style='color:#ffffff;'>Home</span></a></span></th>"
display "	<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "	<span style='font-size:14px;'><a href='../H/authorization.html'>"
display "<span style='color: rgb(255, 255, 255);'>Authorizations</span></span></th>"
display "	<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); "
display "border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "<span style='font-size:14px;'><a href='../H/skills.html'> "
display "<span style='color:#ffffff;'>Skills</span></a></span></th>"
display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "<span style='font-size:14px;'><a href='../H/industries.html'> "
display "<span style='color: rgb(255, 255, 255);'>Industries</span></a></span></th>"
display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(128, 0, 128); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "<span style='color:#ffffff;'>Business Units</span></th>"
display "		</tr>"
display "	</tbody>"
display "</table>"

display " "

display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed below are selling into these Business Units. </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The list does not reflect only the 'top'Partners within the Business Unit.</span></em></div><p>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>TOP Skilled Partners are marked with '*'.</span></em></div><p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "	<tbody>"

for i = 1 to 10
   call ShowBU( i )
end for

display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"


end main

function ShowBU( in_bu )
define
   in_bu smallint,
   qStr char(128),
   qtrStr char(512)

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
display "<h3>"

case in_bu
   when 1
      display "<span style='font-size: 18px'>Midwest</span></h3>"
      let qtrStr = "where a.bu_midwest='Y'"
   when 2
      display "<span style='font-size: 18px'>Pacifics</span></h3>"
      let qtrStr = "where a.bu_pacifics='Y'"
   when 3
      display "<span style='font-size: 18px'>Great West</span></h3>"
      let qtrStr = "where a.bu_greatwest='Y'"
   when 4
      display "<span style='font-size: 18px'>Southeast</span></h3>"
      let qtrStr = "where a.bu_southeast='Y'"
   when 5
      display "<span style='font-size: 18px'>Mid-Atlantic</span></h3>"
      let qtrStr = "where a.bu_midatl='Y'"
   when 6
      display "<span style='font-size: 18px'>New York</span></h3>"
      let qtrStr = "where a.bu_ny='Y'"
   when 7
      display "<span style='font-size: 18px'>Northeast</span></h3>"
      let qtrStr = "where a.bu_northeast='Y'"
   when 8
      display "<span style='font-size: 18px'>Great Lakes</span></h3>"
      let qtrStr = "where a.bu_grtlakes='Y'"
   when 9
      display "<span style='font-size: 18px'>Federal</span></h3>"
      let qtrStr = "where a.bu_federal='Y'"
   when 10
      display "<span style='font-size: 18px'>Canada</span></h3>"
      let qtrStr = "where a.bu_canada='Y'"
end case


   let qtrStr = "select a.* from coverage a ", qtrStr clipped
   prepare QID from qtrStr

declare ACurs cursor for QID

display "</td>"
display "<td style='text-align: center; width: 367px'>"
display "<div>"


foreach ACurs into ARec.*
   if (ARec.skill_mq=3 or 
       ARec.skill_mb=3 or 
       ARec.skill_bpm=3 or 
       ARec.skill_odm=3 or 
       ARec.skill_dp=3 or 
       ARec.skill_ci=3 or 
       ARec.skill_was=3 or 
       ARec.skill_ex=3 or 
       ARec.skill_wl=3 or 
       ARec.skill_ipas=3 ) then
      display "*"
   end if
   display "<a href='../P/", ARec.ceid clipped, ".html'>", ARec.part_name clipped, " </a>"

   display "<br/>"
end foreach

display "</td></tr>"

end function

