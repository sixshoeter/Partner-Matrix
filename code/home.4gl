## March   19, 2014 John M. Shoemaker jshoemaker1@cox.net, use controlrec for url
## November   05, 2014 John M. Shoemaker jshoemaker1@cox.net, remove Firefox message
## March      05, 2015 John M. Shoemaker jshoemaker1@cox.net, move to Units

globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   SQLStr char(512),
   str char(20)

call ReadCmdLn("home", 4)
call ProcCmdLn("home")

let SQLStr="select * from reps where r_name = '", BRec.sales_mgr clipped, "'"
prepare SRID from SQLStr
execute SRID into SRepRec.*

let SQLStr="select * from reps where r_name = '", BRec.tech_mgr clipped, "'"
prepare TRID from SQLStr
execute TRID into TRepRec.*

#call Init()
call Header(0, IRec.i_id, BRec.b_id, 1)
display " "

display "</div>"
display "<p dir='ltr'> &nbsp;</p>"

display "<p dir='ltr' style='text-align: center;'>"

## who url if present in control rec
if( G_url is not null )then
   display "Addresss to this location: <a href='", G_url clipped,"'>", G_url clipped, "</a></p>"
end if

{
case BRec.b_id
   when "WS"
      display "Addresss to this location: <a href='http://BP-PartnerMatrix.democentral.ibm.com/NA/WS/H/home.html'>http://BP-PartnerMatrix.democentral.ibm.com/NA/WS/H/home.html</a></p>"
   when "IM"
      display "Addresss to this location: <a href='http://BP-PartnerMatrix.democentral.ibm.com/NA/IM/H/home.html'>http://BP-PartnerMatrix.democentral.ibm.com/NA/IM/H/home.html</a></p>"
   when "TI"
      display "Addresss to this location: <a href='http://BP-PartnerMatrix.democentral.ibm.com/NA/TI/H/home.html'>http://BP-PartnerMatrix.democentral.ibm.com/NA/TI/H/home.html</a></p>"
   when "RA"
      display "Addresss to this location: <a href='http://BP-PartnerMatrix.democentral.ibm.com/NA/RA/H/home.html'>http://BP-PartnerMatrix.democentral.ibm.com/NA/RA/H/home.html</a></p>"
   when "LO"
      display "Addresss to this location: <a href='http://BP-PartnerMatrix.democentral.ibm.com/NA/LO/H/home.html'>http://BP-PartnerMatrix.democentral.ibm.com/NA/LO/H/home.html</a></p>"
end case
}

display "<p dir='ltr'>"
display "	&nbsp;</p>"
display "<div dir='ltr' style='text-align: center;'>"
display "	<span style='font-size:28px;'>Welcome to the </span></div>"
display "<div dir='ltr' style='text-align: center;'>"
display "	<span style='font-size:28px;'>", IRec.i_name clipped, " ", BRec.b_name clipped, "</span></div>"
display "<div dir='ltr' style='text-align: center;'>"
display "	<span style='font-size:28px;'>Partner Matrix v2.0!</span></div>"

{
display "<h2 dir='ltr' style='color: rgb(34, 34, 34); font-family: Arial, Verdana, sans-serif; font-style: normal; font-variant: normal; "
display "letter-spacing: normal; line-height: normal; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; "
display "word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-align: center;'>"
display "	<strong><span style='color: rgb(255, 0, 0);'>THE PARTNER MATRIX WORKS BEST WITH FIREFOX!!!</span></strong></h2>"
}

display "<p dir='ltr' style='text-align: center;'>"
display "	<span style='font-size:18px;'>The IBM Channels Team supporting our resell (<a href='https://www-304.ibm.com/partnerworld/wps/servlet/ContentHandler/software_value_plus' "
display "target='_blank'>SVP&nbsp;approved</a>) Partners is managed by:</span></p>"
display "<p dir='ltr' style='text-align: center;'>"
display "	<span style='font-size:18px;'><a href='", SRepRec.r_link clipped,"' target='_blank'>", BRec.sales_mgr clipped,"</a>, Manager Channels Sales Team</span></p>"
display "<p dir='ltr' style='text-align: center;'>"
display "	<span style='font-size:18px;'><a href='", TRepRec.r_link clipped, "' " 
display "target='_blank'>", BRec.tech_mgr clipped, "</a>, Manager Channels Technical Team</span></p>"
display "<p dir='ltr' style='color: rgb(34, 34, 34); font-family: Arial, Verdana, sans-serif; font-size: 12px; font-style: normal; "
display "font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; "
display "text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: "
display "auto; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);'>"
display "	&nbsp;</p>"
display "<p dir='ltr' style='color: rgb(34, 34, 34); font-family: Arial, Verdana, sans-serif; font-size: 12px; font-style: normal; "
display "font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; "
display "text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: "
display "auto; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);'>"

{
if( EUsFlg )then
   display "<span style='font-size:18px;'><a href='../H/coverage_plan.html'>Coverage Plan </a></span> &nbsp / &nbsp"
   display "<span style='font-size:18px;'><a href='../H/coverage_eus.html'>Coverage List (by BPR) </a></span> &nbsp / &nbsp"
   display "<span style='font-size:18px;'><a href='../H/coverage_eus_tss.html'>Coverage List (by TSS)</a></span><br /><br />"
else
   display "<span style='font-size:18px;'><a href='../H/coverage.html'>Coverage List </a></span><br /><br />"
end if

display "<span style='font-size:18px;'><a href='../H/byStatus.html'>Partner List by Segmentation (C-I-O code) </a></span><br /><br />"
#display "<span style='font-size:18px;'><a href='../H/hvp.html'>High Value Partner List </a></span><br /><br />"
}
display "<strong><span style='font-size: 26px;'>Business Requirement for the Partner Matrix</span></strong></p>"
display "<p dir='ltr' style='color: rgb(34, 34, 34); font-family: Arial, Verdana, sans-serif; font-size: 12px; font-style: normal; "
display "font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; "
display "text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: "
display "auto; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);'>"
display "	<span style='font-size: 18px;'>Advise the business units on the best geographic and solution skilled partners, which will "
display "help BU reps expand their territory reach by integrating these Partners into their territory plans. It will also expose more Partners "
display "to the BU reps, and advise them of 'in BU' activities and successes, leading to more effective demand generation activities and "
display "an increase in channel revenue growth.</span></p>"
display "<p dir='ltr' style='text-align: center;'>"
display "	&nbsp;</p>"
display "<p dir='ltr' style='text-align: center;'>"
display "	-----------------------------------</p>"
display "<p dir='ltr' style='text-align: center;'>"
if( BRec.b_id="WS" )then
display "WebSphere Win Watch: <a href='https://w3-connections.ibm.com/blogs/WSSuccessStories' target='_blank'>https://w3-connections.ibm.com/blogs/WSSuccessStories</a></p>"
end if

let str = DOWNSHIFT(BRec.b_id)

#display "<p dir='ltr' style='font-size:12px;text-align: center;'><a href='/query_", str clipped, "I.html'>", "Find a Partner (expanded)</a></p>"
display "<p dir='ltr' style='font-size:12px;text-align: center;'><a href='/query_", str clipped, "Export.html' target='_blank'>Exports</a></span><br /><br />"

display "<p dir='ltr'>"
display "	&nbsp;</p>"

call ShowVer( 0 )

end main

