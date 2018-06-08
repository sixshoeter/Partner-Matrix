
## January   15, 2015  John M. Shoemaker jshoemaker1@cox.net - add hidden TOP Level when absent
## March     05, 2015  John M. Shoemaker jshoemaker1@cox.net - remove Industries and EU
## April     16, 2015  John M. Shoemaker jshoemaker1@cox.net - re-add revised Industries 
## September 08, 2015  John M. Shoemaker jshoemaker1@cox.net - change header #36
## July      23, 2016  John M. Shoemaker jshoemaker1@cox.net - move to Markets #174
## April     21, 2017  John M. Shoemaker jshoemaker1@cox.net - add BG color #218
## September 28, 2017  John M. Shoemaker jshoemaker1@cox.net - change to revised format #263
## October   10, 2017  John M. Shoemaker jshoemaker1@cox.net - change featured solutions, #271
## November  10, 2017  John M. Shoemaker jshoemaker1@cox.net - limit feat sols to Industrial, #177
## February  14, 2017  John M. Shoemaker jshoemaker1@cox.net - highlight selected feat sols, #315

globals "globals.4gl"


function Header(inProg, inIOT, inBRAND, showHeader)
	define
	inProg smallint,
	inIOT like iots.i_id,
	inBRAND like brands.b_id,
        showHeader smallint,
	ColorStr char(16),
	TextColorStr char(16),
        bgColorStr char(16),
	str char(20),
        qs char(3),
        fs_cnt, ind_cnt smallint,
        outer_cnt, inner_cnt smallint,
        last_ind like featsols.i_name,
        SQLStr char(512)

#call ReadCmdLn("header", 0)
#call ProcCmdLn("header")
# 	let showHeader = TRUE

        let qs='\\"'
	display "<html><head><meta http-equiv='Content-Type' content='text/html; charset=windows-1252'>"
#        let str = GetProgName( inProg )
        let str="Partner Matrix"
	display "<title>", str clipped, " (", inIOT clipped, "-", inBRAND clipped, ")", "</title>"
#        display "<link href='styles.css' rel='stylesheet' type='text/css'>"
        if( inProg = 8 )then
           display "<link rel='stylesheet' href='https://www.w3schools.com/w3css/4/w3.css'>"
        end if  #if Partner Details
#        if( CtlRec.bg_color is null or CtlRec.bg_color = " " )then
#           display "<style> div {display: block;} body { ",
#                   ";font-family: Verdana, Geneva, Tahoma, sans-serif;}"
#           display ".tsheader {"
#           display "background-color: #01579b;"
#           display "color: #FFFFFF;"
#           display "}"
#           display ".tdata {"
#           display "background-color: #FAFAFA;"
#           display "}"
#           display ".btn {"
#           display "padding: 6px 20px 6px 20px;"
#           display "}"
#           display "</style>"
#        else
##           display "<style> div {display: block;} body {font-family: Verdana, Geneva, Tahoma, sans-serif; }"
           display "<style>"
           display "div {"
           display "	display: block;"
           display "}"
           display "body {"
           display "	font-family: Calibri, Geneva, Tahoma, sans-serif;"
           display "    font-size: 11pt;"
           display "    margin: 0px"
           display "}"
           
           display ".mytable {"
           display "font-family: Calibri, Geneva, Tahoma, Verdana, sans-serif;"
           display "font-size: 11pt;"
           display "line-height: 1.5;"
           display "}"

           display ".box {"
           display " 	text-align: center;"
           display " 	vertical-align: middle;"
           display " 	background-color: #F0F0F0;"
           display " 	border-color: #FFFFFF;"
           display " 	border-style: solid;"
           display " 	border-width: 2px;"
           display " 	width: 125px;"
           display " 	height: 30px;"
           display "}"

           display ".tab {"
           display "        margin-left: 20px;"
           display "        margin-right: 20px;"
           display "        width: 78%;"
           display "        margin:0 auto;"
           display "}"

           display ".my-blue {"
           display "         background-color: #01579b;"
           display "         color: #FFFFFF;"
           display "         width: 80%;"
           display "}"

           display ".blue-bar {"
           display "         background-color: #add8e6;"
           display "         width: 70%;"
           display "         margin:5 auto;"
           display "         padding: 4px 4px 4px 10px;"
           display "         font-weight:bold;"
           display "}"

           display ".brand-details {"
           display "         width: 70%;"
           display "         margin:0 auto;"
           display "         padding-left: 10px;"
           display "}"

           display ".my-gray {"
           display "         background-color: #F0F0F0;"
           display "         color: #000000;"
           display "         width: 80%;"
           display "         margin:0 auto;"
           display "         font-weight: bold;"
           display "}"

           display ".w3-bar {"
           display "         background-color: #01579b;"
           display "         color: #FFFFFF;"
           display "         width: 80%;"
           display "         margin:0 auto;"
           display "}"

           display ".auto-style1 {"
           display "        text-decoration: none;"
           display "}"

           display ".auto-style3 {"
           display "        text-align: left;"
           display "        font-weight: normal;"
           display "}"

           display ".bottomborder {"
           display "        border-bottom-style: solid;"
           display "        border-bottom-width: 1px;"
	   display "        border-bottom-color: #C0C0C0;"
	   display "}"

           display ".bottomborder2 {"
           display "        border-bottom-style: dashed;"
           display "        border-bottom-width: 1px;"
	   display "        border-bottom-color: #DFDFDF;"
	   display "}"

           display ".lnheader {"
           display "	background-color: #cce9ff;"
           display "	color: #FFFFFF;"
           display "}"
           display ".tsheader {"
           display "	background-color: #01579b;"
           display "	color: #FFFFFF;"
           display "}"
           display ".tdata {"
           display "	background-color: #FAFAFA;"
           display "}"
           display ".btn {"
           display "	padding: 6px 20px 6px 20px;"
           display "}"

           display ".theader {"
           display "	text-align: left;"
           display "	background-color: #01579b;"
           display "	color: #FFFFFF;"
           display "}"

           display ".tdborder {"
           display "	border-bottom: 1px;"
           display "	border-bottom-style: solid;"
           display "	border-bottom-color:#CCCCCC;"
           display "}"

           display ".featsol {"
           display "	border: 6px ridge #016CC5;"
           display "	width: 280px;"
           display "	height: 230px;"
           display "	padding: 8px;"
           display "	font-size: 10pt;"
           display "	background-color: #FAFAFA;"
           display "	cursor: hand;"
           display "	float: left;"
           display "	margin-left: 20px;"
           display "	overflow: hidden;"
           display "    -webkit-transition: opacity .25s ease-in-out;"
           display "    -moz-transition: opacity .25s ease-in-out;"
           display "    -ms-transition: opacity .25s ease-in-out;"
           display "    -o-transition: opacity .25s ease-in-out;"
	   display "    opacity: 1;"
           display "}"

           display ".featsolfade {"
           display "	border: 6px ridge #016CC5;"
           display "	width: 280px;"
           display "	height: 230px;"
           display "	padding: 8px;"
           display "	font-size: 10pt;"
           display "	background-color: #FAFAFA;"
           display "	cursor: default;"
           display "	float: left;"
           display "	margin-left: 20px;"
           display "	overflow: hidden;"
           display "	opacity: 0;"
           display "    -webkit-transition: opacity .25s ease-in-out;"
           display "    -moz-transition: opacity .25s ease-in-out;"
           display "    -ms-transition: opacity .25s ease-in-out;"
           display "    -o-transition: opacity .25s ease-in-out;"
           display "}"

           display ".featsolnav {"
           display "	width: 250px;"
           display "	height: 250px;"
           display "	padding: 0px;"
           display "	font-size: 13pt;"
           display "	float: left;"
           display "	margin-left: 10px;"
           display "}"

           display ".section1 {"
           display "	width: 99%;"
           display "	padding-left: 10px;"
           display "}"

           display ".section2 {"
           display "	width: 99%;"
           display "	padding: 0 0 12 10;"
           display "	background:#EBEBEB;"
           display "	margin-bottom: 0;"
           display "}"

           display ".section3 {"
           display "	width: 99%;"
           display "	padding: 0 0 12 10;"
           display "	background:#D2E1ED;"
           display "	margin-top: 0"
           display "}"

           display ".heading {"
           display "	margin-top: 20px;"
           display "	padding-top: 10px;"
           display "	border-top-style: dotted;"
           display "	border-top-width: 1px;"
           display "	border-top-color: #CCCCCC;"
           display "	cursor: hand;"
           display "}"

           display "h3 {"
           display "	font-size: 18pt;"
           display "}"
           display ".imgstyle1 {"
           display "	vertical-align: middle;"
           display "}"

           display ".imgstyle2 {"
           display "	vertical-align: middle;"
           display "    -ms-transform: rotate(270deg); /* IE 9 */"
           display "    -webkit-transform: rotate(270deg); /* Chrome, Safari, Opera */"
           display "    transform: rotate(270deg);"
           display ""
           display "}"

           display ".featsolnavbar {"
           display "	visibility: hidden; "
           display "	position: relative; "
           display "	left: -10px; "
           display "	width: 5px; "
           display "	height: 15px; "
           display "	background: #01579b; "
           display "	margin-top: 5px; "
           display "	float: left;"
           display "}"

## try for PopUp window below
# /* Popup container */
           display ".popup {"
           display "position: relative;"
           display "display: inline-block;"
           display "cursor: pointer;"
           display "}"

#/* The actual popup (appears on top) */
           display ".popup .popuptext {"
           display "visibility: hidden;"
           display "width: 600;"
           display "background-color: #01579b;"
           display "color: #fff;"
           display "text-align: left;"
           display "border-radius: 6px;"
           display "padding: 8px 8px;"
           display "position: absolute;"
           display "z-index: 1;"
           display "left: 50%;"
           display "margin-left: 80px;"
           display "}"

#/* Popup arrow */
           display ".popup .popuptext::after {"
           display "content: "";"
           display "position: absolute;"
           display "top: 100%;"
           display "left: 50%;"
           display "margin-left: -5px;"
           display "border-width: 5px;"
           display "border-style: solid;"
           display "border-color: #555 transparent transparent transparent;"
           display "}"

#/* Toggle this class when clicking on the popup container (hide and show the popup) */
           display ".popup .show {"
           display "visibility: visible;"
           display "-webkit-animation: fadeIn 1s;"
           display "animation: fadeIn 1s"
           display "}"

#/* Add animation (fade in the popup) */
           display "@-webkit-keyframes fadeIn {"
           display "from {opacity: 0;}"
           display "to {opacity: 1;}"
           display "}"

           display "@keyframes fadeIn {"
           display "from {opacity: 0;}"
           display "to {opacity:1 ;}"
           display "}"

## try for PopUp window above

           display "</style>"
#        end if

        display "<script type='text/javascript'>"

        display "function openTab(evt, tabName) {"
        display "   var i, x, tablinks;"
        display "   x = document.getElementsByClassName('tab');"
        display "   for (i = 0; i < x.length; i++) {"
        display "      x[i].style.display = 'none';"
        display "   }"
        display "   tablinks = document.getElementsByClassName('tablink');"
        display "   for (i = 0; i < x.length; i++) {"
        display "      tablinks[i].className = tablinks[i].className.replace('my-gray', '');"
        display "   }"
        display "   document.getElementById(tabName).style.display = 'block';"
	display "   evt.currentTarget.className += ' my-gray';"
	display "}"

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
        display "   if( document.getElementById('link_show').innerHTML =='Show Complete List' ){"
        display "      document.getElementById('link_show').innerHTML = 'Hide Complete List';"
        display "      document.getElementById(elementid).style.display = 'inline';"
        display "   }else{"
        display "      document.getElementById('link_show').innerHTML = 'Show Complete List';"
        display "      document.getElementById(elementid).style.display = 'none';"
        display "   }"
        display "}"

	display "function goBack() {"
        display "   window.history.back();"
        display "}"

        display "function shide(sec) {"
        display "   if (sec == 'name') {"
        display "      if (document.getElementById('nameimg').className == 'imgstyle1') {"
        display "         document.getElementById('nameimg').className = 'imgstyle2';"
        display "         document.getElementById('namesearch').style.display = 'none';"
        display "         document.getElementById('ssrsearch').style.display = 'none';"
        display "      } else {"
        display "         document.getElementById('nameimg').className = 'imgstyle1';"
        display "         document.getElementById('namesearch').style.display = 'inline';"
        display "         document.getElementById('ssrsearch').style.display = 'inline';"
        display "      }"
        display "   } else {"
        display "      if (sec == 'type') {"
        display "         if (document.getElementById('typeimg').className == 'imgstyle1') {"
        display "            document.getElementById('typeimg').className = 'imgstyle2';"
        display "            document.getElementById('browsetable').style.display = 'none';"
        display "         } else {"
        display "            document.getElementById('typeimg').className = 'imgstyle1';"
        display "            document.getElementById('browsetable').style.display = 'inline';"
        display "         }"
        display "      } else {"
        display "         if (document.getElementById('featimg').className == 'imgstyle1') {"
        display "            document.getElementById('featimg').className = 'imgstyle2';"
        display "            document.getElementById('featshow').style.display = 'none';"
        display "         } else {"
        display "            document.getElementById('featimg').className = 'imgstyle1';"
        display "            document.getElementById('featshow').style.display = 'inline';"
        display "         }"
        display "      }"
        display "   }"
        display "}"

        display "function navhover(itemid) {"
        display "	if (document.getElementById('n' + itemid).style.visibility == 'hidden') {"
        display "		document.getElementById('n' + itemid).style.visibility = 'visible';"
        display "	} else {"
	display "		document.getElementById('n' + itemid).style.visibility = 'hidden';"
	display "	}"
        display "}"

##
## START Load featured solution array
## 
        display "var featsol = new Array();"
        if( inProg != 39 )then
           let SQLStr="select a.* from featsols a where a.brand='", BRec.b_id clipped, "' and a.i_name is not NULL and a.i_name != ' ' and a.url is not null and a.url != ' ' order by a.i_name, a.lastshown"
        else
           let SQLStr="select a.* from featsols a where a.brand='", BRec.b_id clipped, "' and a.m_name='Industrial' and a.i_name is not NULL and a.i_name != ' ' and a.url is not null and a.url != ' ' order by a.i_name, a.lastshown"
        end if  #if special for Industrial
#display SQLStr clipped
        prepare LFSAID from SQLStr
        declare LFSACurs cursor for LFSAID
        let fs_cnt=0
        let ind_cnt=1 
        let outer_cnt=0
        let inner_cnt=0
        let last_ind=" "
        let G_FeatSols=0
        foreach LFSACurs into FSArr[fs_cnt+1].*
##LIMIT           if( (last_ind=" " or FSArr[fs_cnt+1].i_name = last_ind) and inner_cnt <3 )then
           if( inner_cnt <3 )then  
           let fs_cnt=fs_cnt+1
           if( FSArr[fs_cnt].i_name != last_ind )then
	      let last_ind=FSArr[fs_cnt].i_name
              let ind_cnt=1
              let outer_cnt=outer_cnt+1
              let inner_cnt=1
              display "// ", FSArr[fs_cnt].i_name clipped, " (", FSArr[fs_cnt].m_name clipped, ")"
	      display "   featsol[", outer_cnt using '<<<', "] = new Array()"
           else
              let ind_cnt=ind_cnt+1
              let inner_cnt=inner_cnt+1
           end if
           display "   featsol[", outer_cnt using '<<<', "][", inner_cnt using '<<<', "] = ",
                   " new Array ('", FSArr[fs_cnt].url clipped, "', 'http://bp-partnermatrix.democentral.ibm.com/", IRec.i_id clipped, "/I/", FSArr[fs_cnt].ceid clipped, ".jpg', '", FSArr[fs_cnt].title clipped, "', '", FSArr[fs_cnt].desc clipped, "');"
           let G_FeatSols=fs_cnt

##LIMIT           else
##LIMIT              let last_ind=FSArr[fs_cnt].i_name
##LIMIT           end if  #inner_cnt<3
           else
              let inner_cnt=0
           end if  #LIMIT 
        end foreach
##
## END Load featured solution array
## 
        display "	"
        display "var currentFeatedIndustry = 1;"
        display "	"
        display "function updatefeat(itemid) {"
        display "   currentFeatedIndustry = itemid;"
        display ""
        display "   for (var i = 1; i <= ", outer_cnt using '<<<', "; i++) { "
        display "      document.getElementById('nl' + i).style.fontWeight = 'normal';"
        display "      document.getElementById('nl' + i).style.backgroundColor = '#ebebeb';"
        display "   }"
        display "   document.getElementById('nl' + itemid).style.fontWeight = 'bold';"
        display "   document.getElementById('nl' + itemid).style.backgroundColor = '#b0c4de';"

        display ""
        display "    document.getElementById('featsol1').className = 'featsolfade';"
        display "    document.getElementById('featsol2').className = 'featsolfade';"
        display "    document.getElementById('featsol3').className = 'featsolfade';"
        display " "
        display "    if (featsol[itemid].length > 1) {"
        display "   	setTimeout(function(){ "
        display "		document.getElementById('featsol1').className = 'featsol'; "
	display "		document.getElementById('featsol1').innerHTML = '' + "
        display "		'<div style=", qs clipped, "height: 80px;", qs clipped, " align=", qs clipped, "center", qs clipped, "><img style=", qs clipped, "max-width: 250px; max-height: 72px;", qs clipped, 
                                " src=", qs clipped, "' + featsol[itemid][1][1] + '", qs clipped, "></div><br>' + "
        display "		'<strong>' + featsol[itemid][1][2] + '</strong><br>' + featsol[itemid][1][3];"
        display "	}, 250);"
        display "    }"
        display ""
        display "    if (featsol[itemid].length > 2) {"
        display "	setTimeout(function(){ "
        display "		document.getElementById('featsol2').className = 'featsol'; "
        display "		document.getElementById('featsol2').innerHTML = '' + "
        display "	   '<div style=", qs clipped, "height: 80px;", qs clipped, " align=", qs clipped, "center", qs clipped, "><img style=", qs clipped, "max-width: 250px; max-height: 72px;", qs clipped, 
                " src=", qs clipped, "' + featsol[itemid][2][1] + '",qs clipped, "></div><br>' + "
        display "	   '<strong>' + featsol[itemid][2][2] + '</strong><br>' + featsol[itemid][2][3];"
        display "	}, 450);"
        display "    }"
        display ""
        display "    if (featsol[itemid].length > 3) {"
        display "	setTimeout(function(){ "
        display "		document.getElementById('featsol3').className = 'featsol'; "
        display "		document.getElementById('featsol3').innerHTML = '' + "
        display "	   '<div style=", qs clipped, "height: 80px;", qs clipped, " align=", qs clipped, "center", qs clipped, "><img style=", qs clipped, "max-width: 250px; max-height: 72px;", qs clipped, 
                " src=", qs clipped, "' + featsol[itemid][3][1] + '",qs clipped, "></div><br>' + "
        display "	   '<strong>' + featsol[itemid][3][2] + '</strong><br>' + featsol[itemid][3][3];"
        display "	}, 650);"
        display "    }"
        display ""
        display "}"

        display "function popupSolution(itemid) {"
        display "   if (featsol[currentFeatedIndustry][itemid])"
        display "	window.open (featsol[currentFeatedIndustry][itemid][0]);"
        display "}"

## try for PopUp window below
        display "function myFunction() {"
        display "var popup = document.getElementById('myPopup');"
        display "popup.classList.toggle('show');"
        display "}"
## try for PopUp window above

## PopUp window for Skills
        display "function skillPopUp() {"
        display "var popup = document.getElementById('SPUP');"
        display "popup.classList.toggle('show');"
        display "}"

## PopUp window for Market/Industry
        display "function marketPopUp() {"
        display "var popup = document.getElementById('MIPUP');"
        display "popup.classList.toggle('show');"
        display "}"

## PopUp window for Geography
        display "function geoPopUp() {"
        display "var popup = document.getElementById('GPUP');"
        display "popup.classList.toggle('show');"
        display "}"

## PopUp window for Social
        display "function socialPopUp() {"
        display "var popup = document.getElementById('SOCPUP');"
        display "popup.classList.toggle('show');"
        display "}"

## PopUp window for Resell
        display "function resellPopUp() {"
        display "var popup = document.getElementById('RESELLPUP');"
        display "popup.classList.toggle('show');"
        display "}"

## PopUp window for Details from other brands
        display "function detailPopUp() {"
        display "var popup = document.getElementById('DETAILPUP');"
        display "popup.classList.toggle('show');"
        display "}"

## PopUp window for Details from other brands
        display "function targetPopUp() {"
        display "var popup = document.getElementById('TARGETPUP');"
        display "popup.classList.toggle('show');"
        display "}"

## PopUp window for Solutions from other brands
        display "function solutionPopUp() {"
        display "var popup = document.getElementById('SOLUTIONPUP');"
        display "popup.classList.toggle('show');"
        display "}"

## PopUp window for References from other brands
        display "function referencePopUp() {"
        display "var popup = document.getElementById('REFERENCEPUP');"
        display "popup.classList.toggle('show');"
        display "}"

## Random number generator
        display "function randomIntFromInterval(min,max) {"
        display "var rval = Math.floor(Math.random()*(max-min+1)+min);"
        display "return rval;"
        display "}"

##
#
        display "</script>"
	display "</head>"
        if( UpdateAllow )then
           display "<body onload='addImgAttributes()';style=background-color:'#FA5858'>"
        else
           display "<body onload='addImgAttributes()'>"
        end if

if( showHeader )then

   if( CtlRec.bg_color is NULL or CtlRec.bg_color=" " )then
      let bgColorStr="#FFFFFF"
   else
      let bgColorStr=CtlRec.bg_color
   end if  #bg_color
if( showTop )then
## display Top header
        call GetColor(BRec.b_id, 0, 0) returning ColorStr, TextColorStr
	display "<div style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
#	display "<span style='font-size:14px;'>"
	display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/index.html' style='text-decoration:none'><span style='color: ", TextColorStr clipped, ";'><em>TOP Level</em></span></a></span></span></div>"
#need?	display "<span style='font-size:14px;'><span style='color: ", bgColorStr clipped, ";'><a href='/index.html' style='text-decoration:none'><span style='color: ", bgColorStr clipped, ";'><em>TOP Level</em></span></a></span></span></div>"
else
## display Top header
#        call GetColor(BRec.b_id, 0, 0) returning ColorStr, TextColorStr
	display "<div style='width: 125px; text-align: center; vertical-align: middle;'>"
#	display "<span style='font-size:14px;'>"
#orig	display "<span style='font-size:14px;'><span style='color: ", bgColorStr clipped, ";'><a href='/index.html' style='text-decoration:none' class='no_show'>TOP Level</a></span></span></div>"
	display "<span style='font-size:14px;'><span style='color: ", bgColorStr clipped, ";'><a href='/index.html' style='text-decoration:none' class='no_show", BRec.b_id clipped, "'>TOP Level</a></span></span></div>"
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
        if( UnitModeYN() )then
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
        if( UnitModeYN() )then
	   display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/menu_coverageU.html' style='text-decoration:none'><span style='color: ", TextColorStr clipped, ";'>Coverage</span></a></span></span></th>"
        else
	   display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/menu_coverage.html' style='text-decoration:none'><span style='color: ", TextColorStr clipped, ";'>Coverage</span></a></span></span></th>"
        end if  #UnitModeYN

#option 2 (authorizations)
        call GetColor(BRec.b_id, inProg, 2) returning ColorStr, TextColorStr
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
        if( UnitModeYN() )then
	   display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/authorizationU.html' style='text-decoration:none'><span style='color: ", TextColorStr clipped, ";'>Partner List</span></a></span></span></th>"
        else
	   display "<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/authorization.html' style='text-decoration:none'><span style='color: ", TextColorStr clipped, ";'>Partner List</span></a></span></span></th>"
        end if

#option 3 (skills)
        call GetColor(BRec.b_id, inProg, 3) returning ColorStr, TextColorStr
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
        
        if( UnitModeYN() )then
	   display "<span style='font-size:14px;'><a href='/",  inIOT clipped, "/", inBRAND clipped, "/H/skillsU.html' style='text-decoration:none'> "
        else
	   display "<span style='font-size:14px;'><a href='/",  inIOT clipped, "/", inBRAND clipped, "/H/skills.html' style='text-decoration:none'> "
        end if
	display "<span style='color: ", TextColorStr clipped, ";'>Skills</span></a></span></th>"
   #option 4 (industries)
           call GetColor(BRec.b_id, inProg, 4) returning ColorStr, TextColorStr
	   display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
	   display "<span style='font-size:14px;'><a href='/", inIOT clipped, "/", inBRAND clipped, "/H/industriesU.html' style='text-decoration:none'> "
	   display "<span style='color: ", TextColorStr clipped, ";'>Markets</span></a></span></th>"

if( NOT UnitModeYN() )then
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
end if  #NOT UnitModeYN

## close table
	display "		</tr>"
	display "	</tbody>"
        display "</table>"
end if #showHeader

end function
