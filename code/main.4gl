
database partners

main

define
    ARec record like coverage.*

declare ACurs cursor for
   select * from coverage

display "<table align='center' border='0' dir='ltr' style='width: 625px;'>"
display "	<tbody>"
display "		<tr>"
display "		<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "	<span style='font-size:14px;'><a href='/wikis/home#!/wiki/North%20America%20WebSphere%20Partner%20Matrix/page/Welcome%20to%20North%20America%20WebSphere%20Partner%20Matrix' "
display "id='wikiLink1362089277548' lconnwikimacro='wikilink' "
display "lconnwikiparamwikipage='Welcome to North America WebSphere Partner Matrix' page='Welcome to North America WebSphere Partner Matrix' "
display "wiki='North America WebSphere Partner Matrix'><span style='color:#ffffff;'>Home</span></a></span></th>"
display "	<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(128, 0, 128); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "	<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'>Authorizations</span></span></th>"
display "	<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); "
display "border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "	<span style='font-size:14px;'><a href='/wikis/home#!/wiki/North%20America%20WebSphere%20Partner%20Matrix/page/WebSphere%20Skills' "
display "id='wikiLink1362089277549' lconnwikimacro='wikilink' lconnwikiparamwikipage='WebSphere Skills' page='WebSphere Skills' "
display "wiki='North America WebSphere Partner Matrix'><span style='color:#ffffff;'>Skills</span></a></span></th>"
display "			<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "			<span style='font-size:14px;'><a href='/wikis/home#!/wiki/North%20America%20WebSphere%20Partner%20Matrix/page/Industries' "
display "id='wikiLink1362089277550' lconnwikimacro='wikilink' lconnwikiparamwikipage='Industries' page='Industries' "
display "wiki='North America WebSphere Partner Matrix'><span style='color: rgb(255, 255, 255);'>Industries</span></a></span></th>"
display "			<th style='width: 125px; text-align: center; vertical-align: middle; background-color: rgb(221, 160, 221); border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
display "			<span style='font-size:14px;'><a href='/wikis/home#!/wiki/North%20America%20WebSphere%20Partner%20Matrix/page/Business%20Units' id='wikiLink1362089277551' "
display "lconnwikimacro='wikilink' lconnwikiparamwikipage='Business Units' page='Business Units' wiki='North America WebSphere Partner Matrix'>"
display "<span style='color:#ffffff;'>Business Units</span></a></span></th>"
display "		</tr>"
display "	</tbody>"
display "</table>"

display " "

display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed below reflect all of our Partners </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>that are SVP Approved for resell of WebSphere CORE, WebSphere BPM, </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>or are authorized for DataPower.</span></em></div>"
display "<table align='left' border='0' cellpadding='0' cellspacing='0' dir='ltr' height='78' width='725'>"
display "	<colgroup>"
display "		<col style='width: 252px' />"
display "		<col span='3' style='width: 65px' />"
display "	</colgroup>"
display "	<tbody>"

display "		<tr>"
display "			<td style='background-color: rgb(230,230,250); width: 258px; height: 18px'>"
display "				<h2>"
display "					BP Company Name</h2>"
display "			</td>"
display "			<td style='background-color: rgb(230,230,250); width: 75px; height: 18px'>"
display "				<h2 style='text-align: center'>"
display "					CORE</h2>"
display "			</td>"
display "			<td style='background-color: rgb(230,230,250); width: 58px; height: 18px'>"
display "				<h2 style='text-align: center'>"
display "					BPM</h2>"
display "			</td>"
display "			<td style='background-color: rgb(230,230,250); width: 144px; height: 18px'>"
display "				<h2>"
display "					DataPower</h2>"
display "			</td>"
display "			<td style='width: 190px; height: 18px'>"
display "				&nbsp;</td>"
display "		</tr>"
display "	</tbody>"
display "</table>"
display "<div dir='ltr' style='border-bottom: #ccc 1px solid; border-left: #ccc 1px solid; width: 600px; font: 16px/26px Georgia, Garamond, Serif; height: 360px; overflow: auto; border-top: #ccc 1px solid; border-right: #ccc 1px solid'>"

display "	<table align='left' border='0' cellpadding='0' cellspacing='0' dir='ltr' style='width: 484px' width='450'>"
display "		<colgroup>"
display "			<col style='width: 252px' />"
display "			<col span='3' style='width: 65px' />"
display "		</colgroup>"
display "		<tbody>"

foreach ACurs into ARec.*
   display "    <tr height='12' style='height: 12px'>"
   display "    <td height='12' style='height: 12px; border-top: medium none'>"
   display ARec.part_name clipped, " </td>"
   display "    <td style='text-align: center; border-left: medium none; border-top: medium none'>"
   display ARec.svp_core, "</td>"
   display "    <td style='text-align: center; border-left: medium none; border-top: medium none'>"
   display ARec.svp_core, "</td>"
   display "<td style='text-align: center; border-left: medium none; width: 100px; border-top: medium none'>"
   display ARec.svp_core, "</td>"
   display "    </tr>"
end foreach

display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"


end main
