## March   19, 2014 John M. Shoemaker jshoemaker1@cox.net, use controlrec for url
## November   05, 2014 John M. Shoemaker jshoemaker1@cox.net, remove Firefox message
## March      05, 2015 John M. Shoemaker jshoemaker1@cox.net, move to Units
## March      19, 2015 John M. Shoemaker jshoemaker1@cox.net, change BDR to BPR
## April      07, 2015 John M. Shoemaker jshoemaker1@cox.net, reorder things on page
## September  15, 2015 John M. Shoemaker jshoemaker1@cox.net, add tasklist to home page #120
## September  24, 2015 John M. Shoemaker jshoemaker1@cox.net, add blog to home page 
## June       07, 2015 John M. Shoemaker jshoemaker1@cox.net, add education links #169
## January    09, 2017 John M. Shoemaker jshoemaker1@cox.net, add last date updt dt #193
## February   15, 2017 John M. Shoemaker jshoemaker1@cox.net, change wording #207
## February   22, 2017 John M. Shoemaker jshoemaker1@cox.net, add referalls to other Matrix #211
## April      24, 2017 John M. Shoemaker, add page counts, #219


globals "globals.4gl"

main
define
   RepRec record like reps.*,
   mgrtype char(10),
   SQLStr char(512),
   str char(20),
   lastDt datetime year to minute,
   lastDtRec record 
      mo smallint,
      dy smallint,
      yr smallint,
      hrmi char(5)
   end record,
   cnt integer

call ReadCmdLn("home", 4)
call ProcCmdLn("home")

#call Init()
call Header(0, IRec.i_id, BRec.b_id, 1)
display " "

display "</div>"
display "<p dir='ltr'> &nbsp;</p>"

display "<p dir='ltr' style='text-align: center;'>"

## who url if present in control rec
if( G_url is not null )then
   if( BRec.b_id="NC" or BRec.b_id="SU" or BRec.b_id="AU" or BRec.b_id="SE" or BRec.b_id="ST" )then
      display "Addresss to new format: <a href='", G_url clipped,"'>", G_url clipped, "</a></p>"
   else
      display "Addresss to this location: <a href='", G_url clipped,"'>", G_url clipped, "</a></p>"
   end if  #AU/SU/NC
end if  #url is present

if( CtlRec.refer_text is not null )then
   display "<p dir='ltr' style='text-align: center;'>"
   display "<a href='", CtlRec.refer_url clipped,"' target='_blank'>", CtlRec.refer_text clipped, "</a></p>"
end if  ##refer_text not null

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
display "	<span style='font-size:28px;'>", IRec.i_name clipped, " ", CtlRec.menu_str clipped, "</span></div>"
display "<div dir='ltr' style='text-align: center;'>"
display "	<span style='font-size:28px;'>Partner Matrix ", V_Num clipped,"!</span></div>"
#let lastDtRec=LastUpdt(BRec.b_id)
call LastUpdt(BRec.b_id) returning lastDtRec.*
if( lastDtRec.mo is not NULL )then
   display "<div dir='ltr' style='text-align: center;color: red;'>"
   display "	<span style='font-size:18px;'>", MasterRec.updmsg clipped, ": ", lastDtRec.mo using "&&", "/", lastDtRec.dy using "&&", "/", lastDtRec.yr using "&&&&", " - ", lastDtRec.hrmi, "</span></div>"
end if

{
display "<h2 dir='ltr' style='color: rgb(34, 34, 34); font-family: Arial, Verdana, sans-serif; font-style: normal; font-variant: normal; "
display "letter-spacing: normal; line-height: normal; orphans: auto; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; "
display "word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-align: center;'>"
display "	<strong><span style='color: rgb(255, 0, 0);'>THE PARTNER MATRIX WORKS BEST WITH FIREFOX!!!</span></strong></h2>"
}


if( CtlRec.instr is not null )then
   display "<br><div dir='ltr' style='text-align: center;'>"
   display "<strong><span style='font-size: 26px;'>How to Use this Database</span></strong></div></p>"
   display "<p dir='ltr' style='color: rgb(34, 34, 34); font-family: Arial, Verdana, sans-serif; font-size: 12px; font-style: normal; "
   display "font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; "
   display "text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: "
#orig   display "auto; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);'>"
   display "auto; -webkit-text-stroke-width: 0px; background-color: ", CtlRec.bg_color clipped, ";'>"
   display "<span style='font-size: 18px;'>"
   display CtlRec.instr clipped
   display "</span></p>"
   display "<hr>"
{
else
   display "<strong><span style='font-size: 26px;'>Business Requirement for the Partner Matrix</span></strong></p>"
   display "<p dir='ltr' style='color: rgb(34, 34, 34); font-family: Arial, Verdana, sans-serif; font-size: 12px; font-style: normal; "
   display "font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; "
   display "text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: "
   display "auto; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);'>"
   display "	<span style='font-size: 18px;'>Advise the regions on the best geographic and solution skilled partners, which will "
   display "help sales reps expand their territory reach by integrating these Partners into their territory plans. It will also expose more Partners "
   display "to the sales reps, and advise them of activities and successes, leading to more effective demand generation activities and "
   display "an increase in channel revenue growth.</span></p>"
}
end if


display "<p dir='ltr' style='font-size:18px;text-align: center;'><a href='http://ibm.biz/PartnerMatrixBlog' target='_blank'>Partner Matrix Blog</a></span><br /><br />"

if( CtlRec.home_msg is not null )then
   display "<p dir='ltr' style='text-align: center;'>", CtlRec.home_msg clipped, "</p>"
end if
#display "	<span style='font-size:18px;'>The IBM Channels Team supporting our resell (<a href='https://www-304.ibm.com/partnerworld/wps/servlet/ContentHandler/software_value_plus' "
#display "target='_blank'>SVP&nbsp;approved</a>) Partners is managed by:</span></p>"

let SQLStr = "select a.*, b.* from unit_mgrs a, reps b where a.mgr_name=b.r_name and a.u_id='", BRec.b_id clipped, "' order by a.mgr_type, a.mgr_ord"
prepare UM1ID from SQLStr
declare UM1Curs cursor for UM1ID
#display SQLStr
foreach UM1Curs into UMgrRec.*, RepRec.*

   display "<p dir='ltr' style='text-align: center;'>"
   display "	<span style='font-size:18px;'><a href='", RepRec.r_link clipped,"' target='_blank'>", UMgrRec.mgr_name clipped,"</a> ", UMgrRec.mgr_title clipped, " (", UMgrRec.mgr_scope clipped, ")</span></p>"
end foreach

#display "<p dir='ltr' style='color: rgb(34, 34, 34); font-family: Arial, Verdana, sans-serif; font-size: 12px; font-style: normal; "
#display "font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: center; "
#display "text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: "
#display "auto; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);'>"
#display "	&nbsp;</p>"
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
display "<p dir='ltr' style='text-align: center;'>"
display "	&nbsp;</p>"
display "<p dir='ltr' style='text-align: center;'>"
let cnt=PageHits(BRec.b_id, 'home')
if( cnt>0 )then
   display "Page Counter: ", cnt, "<br>"
end if
display "	-----------------------------------</p>"
display "<p dir='ltr' style='text-align: center;'>"
if( BRec.b_id="WS" )then
display "WebSphere Win Watch: <a href='https://w3-connections.ibm.com/blogs/WSSuccessStories' target='_blank'>https://w3-connections.ibm.com/blogs/WSSuccessStories</a></p>"
end if

## add links for education
if( MasterRec.education_pres is not null or MasterRec.education_replay is not null )then
   display "<span><p dir='ltr' style='font-size:16px;text-align: center;'>*** Partner Matrix Education Files *** </span><br>"
   if( MasterRec.education_intro is not null and MasterRec.education_intro != " " )then
      display "<a href='", MasterRec.education_intro clipped, "' target='_blank'>Short Introductory Video (3m)</a></span><br>"
   end if
   if( MasterRec.education_pres is not null and MasterRec.education_pres != " " )then
      display "<a href='", MasterRec.education_pres clipped, "' target='_blank'>Powerpoint Presentation</a></span><br>"
   end if
   if( MasterRec.education_replay is not null and MasterRec.education_replay != " " )then
      display "<a href='", MasterRec.education_replay clipped, "' target='_blank'>Training Webinar Replay</a></span>"
   end if

   display "</p>"

   display "<p dir='ltr' style='text-align: center;'>"
   display "	-----------------------------------</p>"
end if  #add links for education

let str = DOWNSHIFT(BRec.b_id)

#display "<p dir='ltr' style='font-size:12px;text-align: center;'><a href='/query_", str clipped, "I.html'>", "Find a Partner (expanded)</a></p>"
display "<p dir='ltr' style='font-size:12px;text-align: center;'><a href='/query_", str clipped, "Export.html' target='_blank'>Exports</a></span>"
display "<p dir='ltr' style='font-size:12px;text-align: center;'><a href='../../all/H/tasklist.html' target='_blank'>Change Request Listing</a></span>"
#display "<p dir='ltr' style='font-size:12px;text-align: center;'><a href='http://ibm.biz/PartnerMatrixBlog' target='_blank'>Partner Matrix Blog</a></span><br /><br />"

display "<p dir='ltr'>"
display "	&nbsp;</p>"

call ShowVer( 0 )

end main

function PageHits(inbrand, inpage)
define
   inbrand like access_cnt.brand,
   inpage like access_cnt.page,
   cnt like access_cnt.cnt,
   SQLStr char(128)

   let SQLStr="select a.cnt from access_cnt a where a.brand='", inbrand clipped, "' and a.page='",
              inpage clipped, "' "
   prepare PHID from SQLStr
   execute PHID into cnt

   return cnt

end function  #PageHits

