globals "globals.4gl"


function Header(inProg, inIOT, inBRAND)
	define
	inProg smallint,
	inIOT like iots.i_id,
	inBRAND like brands.b_id,
	ColorStr char(16),
	str char(20)

#call ReadCmdLn("header", 0)
#call ProcCmdLn("header")

	display "<html>"
	display "<head>"
        let str = GetProgName( inProg )
	display "<title>", inIOT clipped, "-", inBRAND clipped, "-", str clipped, "</title>"
        display "<link href='styles.css' rel='stylesheet' type='text/css'>"
        display "<style> div {display: block;} </style>"
	display "</head>"
	display "<table align='center' border='0' dir='ltr' style='width: 625px;'>"
	display "	<tbody>"
	display "		<tr>"
#option 1 (home)
let ColorStr = GetColor(inProg, 1)
	display "		<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
	display "	<span style='font-size:14px;'>"
	display " <span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href=/", inIOT clipped, "/", inBRAND clipped, "/H/home.html><span style='color:#ffffff;'>Home</span></span></th>"

#option 2 (authorizations)
let ColorStr = GetColor(inProg, 2)
	display "	<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
	display "	<span style='font-size:14px;'><span style='color: rgb(255, 255, 255);'><a href=/", inIOT clipped, "/", inBRAND clipped, "/H/authorization.html><span style='color:#ffffff;'>Authorizations</a></span></span></th>"

#option 3 (skills)
let ColorStr = GetColor(inProg, 3)
	display "	<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
	display "<span style='font-size:14px;'><a href=/",  inIOT clipped, "/", inBRAND clipped, "/H/skills.html> "
	display "<span style='color:#ffffff;'>Skills</span></a></span></th>"

#option 4 (industries)
let ColorStr = GetColor(inProg, 4)
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
	display "<span style='font-size:14px;'><a href=/", inIOT clipped, "/", inBRAND clipped, "/H/industries.html> "
	display "<span style='color: rgb(255, 255, 255);'>Industries</span></a></span></th>"

#option 5 (business units)
let ColorStr = GetColor(inProg, 5)
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
	display "<span style='font-size:14px;'><a href=/", inIOT clipped, "/", inBRAND clipped, "/H/businessunits.html>"
	display "<span style='color:#ffffff;'>Business Units</span></a></span></th>"

#option 6 (find a partner)
	let ColorStr = GetColor(inProg, 6)
let str = DOWNSHIFT(BRec.b_id)
	display "<th style='width: 125px; text-align: center; vertical-align: middle; background-color: ", ColorStr clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
	display "<span style='font-size:14px;'><a href='/query_", str clipped, ".html'>"
	display "<span style='color:#ffffff;'>Find a Partner</span></a></span></th>"

## close table
	display "		</tr>"
	display "	</tbody>"
display "</table>"

end function
