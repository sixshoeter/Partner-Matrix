
## January   15, 2015  John M. Shoemaker jshoemaker1@cox.net - add hidden TOP Level when absent
## September 08, 2015  John M. Shoemaker jshoemaker1@cox.net - menu changes #36

globals "globals.4gl"


function Header(inProg, inIOT, inBRAND, showHeader)
	define
	inProg smallint,
	inIOT like iots.i_id,
	inBRAND like brands.b_id,
        showHeader smallint,
	ColorStr char(16),
	TextColorStr char(16),
	str char(20)

#call ReadCmdLn("header", 0)
#call ProcCmdLn("header")
# 	let showHeader = TRUE


	display "<html>"
	display "<head>"
        let str = GetProgName( inProg )
	display "<title>", inIOT clipped, "-", inBRAND clipped, "-", str clipped, "</title>"
        display "<link href='styles.css' rel='stylesheet' type='text/css'>"
        display "<style> div {display: block;} </style>"

        display "<script type='text/javascript'>"
        display "function addImgAttributes()"
        display "{"
        display "var theImg = document.getElementById('theImgID');"
        display "maxW = '300';"
        display "maxH = '50';"
	display "width = theImg.width;"
        display "height = theImg.height;"
        display "if( width == height )"
        display "{"
        display "   if (width > maxW )"
        display "   {"
        display "      nwidth = maxW;"
        display "      nheight = maxW;"
        display "   }"
        display "   else"
##  width is still equal height 
        display "   {"
        display "      if (height > maxH )"
        display "      {"
        display "         nwidth = maxH;"
        display "         nheight = maxH;"
	display "      }"
        display "      else"
        display "      {"
        display "         nwidth = width;"
        display "         nheight = height;"
	display "      }"
	display "   }"

        display "}"
        display "else "
        display "{"
        display "   if( width > height )"
        display "   {"
        display "      if (width > maxW )"
        display "      {"
        display "         nwidth = maxW;"
	display "         nheight = height - height*((width - nwidth)/width);"
	display "      }"
        display "      else"
        display "      {"
        display "         if( height > maxH )"
        display "         {"
        display "            nheight = maxH;"
        display "            nwidth = width - (width*((height - nheight)/height))"
        display "         }"
        display "         else"
        display "         {"
        display "            nwidth = width;"
        display "            nheight = height;"
        display "         }"
        display "      }"
        display "   }"
        display "   else"
        display "   {"
	display "      if (height > maxH )"
	display "      {"
	display "         nheight = maxH;"
	display "         nwidth = width - (width*((height - nheight)/height))"
	display "      }"
        display "      else"
        display "      {"
        display "         nwidth = width;"
        display "         nheight = height;"
        display "      }"
        display "   }"
        display ""
        display ""
        display "   theImg.setAttribute('width',nwidth);"
        display "   theImg.setAttribute('style', 'width:',nwidth);"
        display "   theImg.setAttribute('height',nheight);"
        display "   theImg.setAttribute('style', 'height:',nheight);"

        display "}"
        display "}"
        display "function togglerows(elementid) {"
        display "   if( document.getElementById(elementid).style.display=='none' ){"
        display "      document.getElementById(elementid).style.display = '';"
        display "   }else{"
        display "      document.getElementById(elementid).style.display = 'none';"
        display "   }"
        display "}"
        display "</script>"
	display "</head>"
        if( UpdateAllow )then
           display "<body onload='addImgAttributes()';style='background-color:#FA5858'></body>"
        else
           display "<body onload='addImgAttributes()'></body>"
        end if
#display "UpdateAllow: ", UpdateAllow

if( showHeader )then

if( showTop )then
## display Top header
        call GetColor(BRec.b_id, 0, 0) returning ColorStr, TextColorStr
	display "<div style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
#	display "<span style='font-size:14px;'>"
	display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/index.html' style='text-decoration:none'><span style='color: ", TextColorStr clipped, ";'><em>TOP Level</em></span></a></span></span></div>"
else
## display Top header
#        call GetColor(BRec.b_id, 0, 0) returning ColorStr, TextColorStr
	display "<div style='width: 125px; text-align: center; vertical-align: middle;'>"
#	display "<span style='font-size:14px;'>"
	display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/index.html' style='text-decoration:none' class='no_show'>TOP Level</a></span></span></div>"
end if

## display the rest of the header
	display "<table align='center' border='0' dir='ltr' style='width: 800px;'>"
#	display "<table align='center' border='0' dir='ltr' style='width: 625px;'>"
	display "<tbody>"
	display "<tr>"

#option 1 (home)
        call GetColor(BRec.b_id, inProg, 1) returning ColorStr, TextColorStr
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
#	display "<span style='font-size:14px;'>"
if( BRec.b_id = "AU" or BRec.b_id = "SU" )then
	display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/homeU.html' style='text-decoration:none'><span style='color: ", TextColorStr clipped, "'>Home</span></a></span></span></th>"
else
	display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/home.html' style='text-decoration:none'><span style='color: ", TextColorStr clipped, "'>Home</span></a></span></span></th>"
end if

#option 6 (find a partner)

	call GetColor(BRec.b_id, inProg, 6) returning ColorStr, TextColorStr
        let str = BRec.b_id
#        let str = DOWNSHIFT(BRec.b_id)
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
        if( EUsFlg )then
	   display "<span style='font-size:14px;'><a href='/query_", str clipped, "_eus.html' style='text-decoration:none'>"
        else
	   display "<span style='font-size:14px;'><a href='/query_", str clipped, ".html' style='text-decoration:none'>"
        end if
	display "<span style='color: ", TextColorStr clipped, ";'>Find a Partner</span></a></span></th>"

#option 7 (coverage)
        call GetColor(BRec.b_id, inProg, 7) returning ColorStr, TextColorStr
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
	display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/menu_coverage.html' style='text-decoration:none'><span style='color: ", TextColorStr clipped, ";'>Coverage</span></a></span></span></th>"

#option 2 (authorizations)
        call GetColor(BRec.b_id, inProg, 2) returning ColorStr, TextColorStr
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
if( BRec.b_id = "AU" or BRec.b_id = "SU" )then
	display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/authorizationU.html' style='text-decoration:none'><span style='color: ", TextColorStr clipped, ";'>Partner List</span></a></span></span></th>"
else
	display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/authorization.html' style='text-decoration:none'><span style='color: ", TextColorStr clipped, ";'>Partner List</span></a></span></span></th>"
end if

#option 3 (skills)
        call GetColor(BRec.b_id, inProg, 3) returning ColorStr, TextColorStr
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
if( BRec.b_id = "AU" or BRec.b_id = "SU" )then
	display "<span style='font-size:14px;'><a href='/",  inIOT clipped, "/", inBRAND clipped, "/H/skillsU.html' style='text-decoration:none'> "
else
	display "<span style='font-size:14px;'><a href='/",  inIOT clipped, "/", inBRAND clipped, "/H/skills.html' style='text-decoration:none'> "
end if
	display "<span style='color: ", TextColorStr clipped, ";'>Skills</span></a></span></th>"

#option 4 (industries)
        call GetColor(BRec.b_id, inProg, 4) returning ColorStr, TextColorStr
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
	display "<span style='font-size:14px;'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/industries.html' style='text-decoration:none'> "
	display "<span style='color: ", TextColorStr clipped, ";'>Industries</span></a></span></th>"

#option 5 (business/enterprise units)
        call GetColor(BRec.b_id, inProg, 5) returning ColorStr, TextColorStr
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
        if( EUsFlg ) then
           if( G_eudropbox )then  #use dropbox box version
	      display "<span style='font-size:14px;'><a href='/", BRec.b_id clipped, "_eus_drive.html' style='text-decoration:none'>"
	      display "<span style='color: ", TextColorStr clipped, ";'>Enterprise Units</span></a></span></th>"
           else
	      display "<span style='font-size:14px;'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/eus.html' style='text-decoration:none'>"
	      display "<span style='color: ", TextColorStr clipped, ";'>Enterprise Units</span></a></span></th>"
           end if
        else
	   display "<span style='font-size:14px;'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/businessunits.html' style='text-decoration:none'>"
	   display "<span style='color: ", TextColorStr clipped, ";'>Business Units</span></a></span></th>"
        end if

## close table
	display "		</tr>"
	display "	</tbody>"
        display "</table>"
end if #showHeader

end function
