##
## October 11, 2013 John M. Shoemaker, multiple changes
## January 16, 2014 John M. Shoemaker, convert to EU from BU
## September 29, 2014 John M. Shoemaker, verify with categories
## November 24, 2014 John M. Shoemaker, expand to 30 skills
## February 03, 2015 John M. Shoemaker, convert to Units
## March    17, 2015 John M. Shoemaker, correct for SU
## April    15, 2015 John M. Shoemaker, fix error for table alias for skills_s5
## April    15, 2015 John M. Shoemaker, add table n
## June     11, 2015 John M. Shoemaker, add Commerce
## August   18, 2015 John M. Shoemaker, correct error with selecting all EUs
## September14, 2015 John M. Shoemaker, remove landing BPR #125
## September24, 2015 John M. Shoemaker, allow selection at region level #115
## February  17, 2016 John M. Shoemaker, filter out reseller X
## July      22, 2016 John M. Shoemaker, add support for market/industry #174
## September 20, 2016 John M. Shoemaker, allow Industry search to be provided val and greater #174
## September 04, 2017 John M. Shoemaker, revise AU tables, #255
## September 12, 2017 John M. Shoemaker, add export button of results, #259
## September 21, 2017 John M. Shoemaker, use sorted ranking and limit results, #262
## September 21, 2017 John M. Shoemaker, make simple an option, #263
## October   06, 2017 John M. Shoemaker, ignore case in part_name sort, #269
## October   31, 2017 John M. Shoemaker, allow search by ceid, #282
## January   10, 2018 John M. Shoemaker, add question button, #292
## January   31, 2018 John M. Shoemaker jshoemaker1@cox.net, migrate to sales specialties, #300
## March     23, 2018 John M. Shoemaker jshoemaker1@cox.net, include abbreviations in search, #318
## April     02, 2018 John M. Shoemaker jshoemaker1@cox.net, build partner pages dynamically, #319
## April     12, 2018 John M. Shoemaker jshoemaker1@cox.net, expand IO to three tables, #320
## May       14, 2018 John M. Shoemaker sixshoeter@gmail.com, add MasterRec columns for dirs, #324


globals "globals.4gl"

define
   AdhocStr char(2048),
   DispStr char(512),
   searchName char(128),
   searchSSR char(128),
   SkillSrchStr char(1024),
   tStr char(128),
   tMStr char(128),
   tGStr char(128),
   skilllevelStr char(64),
   aEUArr array[30] of char(30),
   aINDArr array[30] of char(30),
   aEUcnt, aINDcnt smallint,
   cnt smallint,
   pcnt smallint,  #number of partners in the current list
   NEWRepArr array[2] of
   record
      ssr      like reps.r_name,
      ssr_link like reps.r_link
   end record,
   tssr like reps.r_name,
   tssr_link like reps.r_link,
   kUsed, lUsed, mUsed, bUsed, cUsed, dUsed, nUsed smallint,
   pUsed, qUsed, rUsed, tUsed, uUsed, vUsed, wUsed, xUsed, yUsed, zUsed smallint,
   eUsed, fUsed, gUsed, hUsed smallint,
   sUsed, iUsed, jUsed smallint,
   i1Used,i2Used,i3Used,i4Used smallint,
   sSkill smallint,
   wStr char(2048),
   sStr char(512),
   QArr array[7] of smallint,
   QSArr array[30] of
      record
         n char(50),
         v char(50)
      end record



main

define
   i smallint,
   SQLStr char(1024),
   qStr char(1024)

call ReadCmdLn( "adhoc1", 5)
call ProcCmdLn( "adhoc1" )
let AdhocStr = arg_val(5)
call Header(0, IRec.i_id, BRec.b_id, 0)
#TEST let AdhocStr="SLevel=3&k=skill_01&l=skill_01&m=&c=&d=&mk=1&reg=1"
#display "Adhoc Str: ", AdhocStr clipped, "<br>"
## check for name search before parsing rest of string
let wStr=" "
let searchName = " "
let searchSSR = " "
let SkillSrchStr=" "
if( AdhocStr[1,8]="nmsearch" )then
## name search
   let searchName=CleanUp( ParseName( AdhocStr ) )
   let DispStr=searchName
   let searchName="*", downshift(searchName) clipped, "*"
else
   if( AdhocStr[1,9]="ssrsearch" )then
## SSR/BPR search
      let searchSSR=CleanUp( ParseSSR( AdhocStr ) )
      let DispStr=searchSSR
      let searchSSR="*", downshift(searchSSR) clipped, "*"

   else
      call ParseStrS( AdhocStr )
   end if
end if
#display "wStr: ", wStr clipped, "<br>"

display "<div dir='ltr' style='width: 1100px;margin :0 auto;'>"
#display "<h2>Search Results <a href='/NA/all/H/SearchResults.html' target='_blank'><img style='margin-bottom: 2px;' height='17' src='/", IRec.i_id clipped, "/I/question.jpg' width='20' alt='' title='Search Explanation'></a></h2>"

display "<table>"
display "<tr><td><h2>Search Results</h2></td><td style='vertical-align: top;'><div class='popup' onclick='myFunction()'><img style='margin-bottom: 2px;' height='17' src='/", IRec.i_id clipped, "/I/question.jpg' width='20' alt='' title='Search Explanation'>"
#display "<span class='popuptext' id='myPopup'><h2>Search Results Explanation</h2><p>We want to reward those <em>IBM Business Partners</em> that are investing in themselves and in IBM technologies. "
display "<span class='popuptext' id='myPopup'><h2>Search Results Explanation</h2><p>", MasterRec.sr_txt clipped
{
display "We also want to utilize those top performing partners that we know can manage and close opportunities.</p>"
display "<p>When a search is performed via the <strong>Partner Matrix</strong> Search Screen, the results are evaluated and returned using a prioritization algorithm that considers many factors. "
display "While the specific sort factors may change from time to time, here is the general prioritization:"
display "<ol>"
display "<li>If a product skill is included in the search criteria and one of more partners are considered to be Elite status (the Cream of the Crop), they will be moved to the top of the list"
display "<li>Partners with software revenue in the past 12 months (rolling 12 months) will be placed higher"
display "<li>Partners that have Solutions in the Global Solutions Directory (GSD) will be sorted higher"
display "<li>If the Partner has any product skills, they will be prioritized above those without"
display "<li>Finally, since it's important to have a contact at the Partner to engage them, having a contact available will be the final sort"
display "</ol>"
display "<br>"
display "Using this ordering technique, our best Partners should bubble up towards the top of the results."
}
display "</span>"
display "</div>"
display "</td></tr></table>"

{
display "<dialog id='window'>"
display "<h2>Search Results Explanation</h2>"
display "<p>We want to reward those <em>IBM Business Partners</em> that are investing in themselves and in IBM technologies. We also want to utilize those top performing partners that we know can manage and close opportunities.</p>"
display "<button id='exit'>Close Dialog</button>"
display "</dialog>"
display "<button id='show'>Show Dialog</button>"
}

display "<p>"
if( DispStr is not null and DispStr != " ")then
   display "<em>", DispStr clipped, "&nbsp;</em><br>"
end if
if( tMStr is not null and tMStr != " ")then
   display "<em>", tMStr clipped, "&nbsp;</em><br>"
end if
if( tGStr is not null and tGStr != " ")then
   display "<em>", tGStr clipped, "&nbsp;</em><br>"
end if
display "</p>"

display "<table dir='ltr' style='width: 1100px' border='0' cellspacing='0' class='mytable'>"
display "<tbody>"
display "<tr style='height: 30px'>"
display "        <td style='width:200px' class='theader'><strong>Partner Name</strong></td>"
display "        <td class='theader'><strong>Authorizations</strong></td>"
#display "        <td class='theader'><strong>Skill Focus</strong></td>"
display "        <td class='theader'><strong></strong></td>"
display "        <td class='theader'><strong>Market Solutions</strong></td>"
display "        <td class='theader'><strong>Partner Contact</strong></td>"
display "        <td class='theader'><strong>IBM Contact</strong></td>"
display "        <td class='theader'><strong>Social Feedback</strong></td>"
display "</tr>"

call ShowAdhocS() returning qStr

display "</tbody>"
display "</table>"
display "</div>"
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 492px; font: 16px/26px Georgia, Garamond, Serif;'>"
display "Number of Partners: ", cnt using "<<<&"
#if( BRec.b_id='SU' )then
display "<table>"
display "<tr valign='top'><td>"
display "<FORM ID='expfap' ACTION='/", MasterRec.cgi_dir clipped, "/exportFAP", BRec.b_id clipped, ".ksh' method='post'>"
display "<INPUT TYPE=submit VALUE='Export Results to CSV'>"
display '<INPUT NAME="qry" TYPE=hidden READONLY VALUE="', qStr clipped, '">'
display "</FORM>"
display "</td>"

display "<td style='width: 100px'></td>"
# go-back button
display "<td><button onClick='goBack()'>Back to Search Screen</button></td>"
display "</tr></table>"
#end if
display "</div"
display "<p dir='ltr'> &nbsp;</p>"
#display "</tr>"

call ShowVer( 0 )

end main

function ShowAdhocS()
define
   in_bu smallint,
   qtrStr char(2048),
   skillStr char(300),
   my_ssr like bus.b_ssr,
   my_ctp like bus.b_ctp,
   RRec record like reps.*,
   sort_by char(512),
   SSRStr char(64),
   extStr char(256),
   r_link like reps.r_link,
   tflg like curr_revenue.curr_rev_flg,
   tsols like curr_revenue.has_sol,
   tskill like curr_revenue.has_skill,
   tcontact like curr_revenue.has_contact,
   rcnt smallint, 
   ravg smallfloat,
   rStr char(512)

let qtrStr = "select cr.curr_rev_flg, cr.has_sol, cr.has_skill, cr.has_contact, a.* "
#AU
if( kUsed )then let qtrStr = qtrStr clipped, ", k.* " end if
if( lUsed )then let qtrStr = qtrStr clipped, ", l.* " end if
if( mUsed )then let qtrStr = qtrStr clipped, ", m.* " end if
if( bUsed )then let qtrStr = qtrStr clipped, ", b.* " end if
if( cUsed )then let qtrStr = qtrStr clipped, ", c.* " end if
if( dUsed )then let qtrStr = qtrStr clipped, ", d.* " end if

if( pUsed )then let qtrStr = qtrStr clipped, ", p.* " end if
if( qUsed )then let qtrStr = qtrStr clipped, ", q.* " end if
#if( rUsed )then let qtrStr = qtrStr clipped, ", r.* " end if
if( i1Used )then let qtrStr = qtrStr clipped, ", i1.* " end if
if( i2Used )then let qtrStr = qtrStr clipped, ", i2.* " end if
if( i3Used )then let qtrStr = qtrStr clipped, ", i3.* " end if
if( i4Used )then let qtrStr = qtrStr clipped, ", i4.* " end if

#if( sUsed )then let qtrStr = qtrStr clipped, ", s.* " end if
if( sUsed )then let qtrStr = qtrStr clipped, ", s.* " end if
if( iUsed )then let qtrStr = qtrStr clipped, ", i.* " end if
if( jUsed )then let qtrStr = qtrStr clipped, ", j.* " end if

#SU
if( tUsed )then let qtrStr = qtrStr clipped, ", t.* " end if
if( uUsed )then let qtrStr = qtrStr clipped, ", u.* " end if
#if( vUsed )then let qtrStr = qtrStr clipped, ", v.* " end if
#if( wUsed )then let qtrStr = qtrStr clipped, ", w.* " end if

#if( xUsed )then let qtrStr = qtrStr clipped, ", x.* " end if
if( yUsed )then let qtrStr = qtrStr clipped, ", y.* " end if
if( zUsed )then let qtrStr = qtrStr clipped, ", z.* " end if

#BU
if( eUsed )then let qtrStr = qtrStr clipped, ", e.* " end if
if( fUsed )then let qtrStr = qtrStr clipped, ", f.* " end if
if( gUsed )then let qtrStr = qtrStr clipped, ", g.* " end if
if( hUsed )then let qtrStr = qtrStr clipped, ", h.* " end if

#SE
if( nUsed )then let qtrStr = qtrStr clipped, ", n.* " end if

if( BRec.b_id="NC" or BRec.b_id="MC" )then
   case BRec.b_id
      when "NC"
         let qtrStr = qtrStr clipped, " from coverage_nc a"
      when "MC"
         let qtrStr = qtrStr clipped, " from coverage_mc a"
   end case
else
if( kUsed or lUsed or mUsed or cUsed or dUsed or bUsed )then
   let qtrStr = qtrStr clipped, " from coverage_au a"
else
   if( tUsed or uUsed or vUsed or wUsed or xUsed )then
      let qtrStr = qtrStr clipped, " from coverage_su a"
   else
      if( eUsed or fUsed or gUsed or hUsed )then
         let qtrStr = qtrStr clipped, " from coverage_bu a"
      else
         if( zUsed )then
            let qtrStr = qtrStr clipped, " from coverage_cu a"
         else 
            if( sUsed or jUsed or jUsed )then
              let qtrStr = qtrStr clipped, " from coverage_st a"
            else
               if( i1Used or i2Used or i3Used or i4Used )then
                 let qtrStr = qtrStr clipped, " from coverage_io a"
               else
                  if( qUsed )then
                     let qtrStr = qtrStr clipped, " from coverage_es a"
                  else
                     if( pUsed )then
                        let qtrStr = qtrStr clipped, " from coverage_wu a"
                     else
                        if( pUsed )then
                           let qtrStr = qtrStr clipped, " from coverage_se a"
                        else
                           let qtrStr = qtrStr clipped, " from coverage_", downshift(BRec.b_id) clipped, " a"
                        end if
                     end if
                  end if
               end if
            end if
         end if
      end if
   end if
end if
end if

if( kUsed )then let qtrStr = qtrStr clipped, ", skills_n1 k " end if
if( lUsed )then let qtrStr = qtrStr clipped, ", skills_n2 l " end if
if( mUsed )then let qtrStr = qtrStr clipped, ", skills_n3 m " end if
if( cUsed )then let qtrStr = qtrStr clipped, ", skills_n4 c " end if
if( dUsed )then let qtrStr = qtrStr clipped, ", skills_n5 d " end if
if( bUsed )then let qtrStr = qtrStr clipped, ", skills_ag b " end if
if( pUsed )then let qtrStr = qtrStr clipped, ", skills_wu p " end if
if( qUsed )then let qtrStr = qtrStr clipped, ", skills_es q " end if
#if( rUsed )then let qtrStr = qtrStr clipped, ", skills_io r " end if
if( i1Used )then let qtrStr = qtrStr clipped, ", skills_i1 i1 " end if
if( i2Used )then let qtrStr = qtrStr clipped, ", skills_i2 i2 " end if
if( i3Used )then let qtrStr = qtrStr clipped, ", skills_i3 i3 " end if
if( i4Used )then let qtrStr = qtrStr clipped, ", skills_i4 i4 " end if
#if( sUsed )then let qtrStr = qtrStr clipped, ", skills_st s " end if
if( tUsed )then let qtrStr = qtrStr clipped, ", skills_n6 t " end if
if( uUsed )then let qtrStr = qtrStr clipped, ", skills_n7 u " end if
#if( vUsed )then let qtrStr = qtrStr clipped, ", skills_s3 v " end if
#if( wUsed )then let qtrStr = qtrStr clipped, ", skills_s4 w " end if
#if( xUsed )then let qtrStr = qtrStr clipped, ", skills_s5 x " end if
if( yUsed )then let qtrStr = qtrStr clipped, ", skills_co y " end if
if( zUsed )then let qtrStr = qtrStr clipped, ", skills_cu z " end if

if( eUsed )then let qtrStr = qtrStr clipped, ", skills_b1 e " end if
if( fUsed )then let qtrStr = qtrStr clipped, ", skills_b2 f " end if
if( gUsed )then let qtrStr = qtrStr clipped, ", skills_b3 g " end if
if( hUsed )then let qtrStr = qtrStr clipped, ", skills_b4 h " end if

if( sUsed )then let qtrStr = qtrStr clipped, ", skills_sw s " end if
if( iUsed )then let qtrStr = qtrStr clipped, ", skills_sh i " end if
if( jUsed )then let qtrStr = qtrStr clipped, ", skills_sv j " end if

if( nUsed )then let qtrStr = qtrStr clipped, ", skills_se n " end if

##add in from table curr_revenue
let qtrStr = qtrStr clipped, ", curr_revenue cr "

if( sStr is not null and sStr != " " )then
   let sStr="(", sStr clipped, ") and "
end if

if( wStr is not null and wStr != " " )then
   let wStr="(", wStr clipped, ") and "
end if

# display "wStr: ", wStr clipped, "<br>"
# display "sStr: ", sStr clipped, "<br>"
let AdhocStr = " and ", sStr clipped, " ", wStr clipped, " (a.reseller != 'N' and a.reseller != 'X' and a.part_type != 'D') "

#if( not CtlRec.cflg4 )then
   if( length(SkillSrchStr) < 3 )then
      let sort_by = "cr.curr_rev_flg desc, cr.has_sol desc, cr.has_skill desc, cr.has_contact desc, lower(a.part_name)"
   else
#display "SkillSrchStr - jit: ", SkillSrchStr clipped, "<br>"
      let sort_by = SkillSrchStr clipped, " cr.curr_rev_flg desc, cr.has_sol desc, cr.has_skill desc, cr.has_contact desc, a.part_name"
   end if  #SkillSrchStr
#display "sort_by: ", sort_by clipped, "</br>"
#   let qtrStr = qtrStr clipped, " where a.ceid=k.ceid and a.ceid=l.ceid and a.ceid=m.ceid ", AdhocStr clipped, " order by ", sort_by clipped
   let qtrStr = qtrStr clipped, " where 1=1 "
   if( searchName != " " )then 
      let qtrStr = qtrStr clipped, " and ((lower(a.part_name) matches '", searchName clipped, "') or "
##    include abbreviation in search, #318
      let qtrStr = qtrStr clipped,   " (lower(a.part_name_abbr) matches '", searchName clipped, "') or "
      let qtrStr = qtrStr clipped,   " (lower(a.ceid) matches '", searchName clipped, "'))"
   end if
   if( searchSSR != " " )then 
      let qtrStr = qtrStr clipped, " and ((lower(a.ssr) matches '", searchSSR clipped, "') or ",
                                        " (lower(a.ctp1) matches '", searchSSR clipped, "') or ",
                                        " (lower(a.ctp2) matches '", searchSSR clipped, "') or ",
                                        " (lower(a.ctp3) matches '", searchSSR clipped, "') or ",
                                        " (lower(a.ctp4) matches '", searchSSR clipped, "') or ",
                                        " (lower(a.ctp5) matches '", searchSSR clipped, "'))"
   end if
   if( kUsed )then let qtrStr = qtrStr clipped, " and a.ceid=k.ceid " end if
   if( lUsed )then let qtrStr = qtrStr clipped, " and a.ceid=l.ceid " end if
   if( mUsed )then let qtrStr = qtrStr clipped, " and a.ceid=m.ceid " end if
   if( cUsed )then let qtrStr = qtrStr clipped, " and a.ceid=c.ceid " end if
   if( dUsed )then let qtrStr = qtrStr clipped, " and a.ceid=d.ceid " end if
   if( bUsed )then let qtrStr = qtrStr clipped, " and a.ceid=b.ceid " end if
   if( nUsed )then let qtrStr = qtrStr clipped, " and a.ceid=n.ceid " end if
   if( pUsed )then let qtrStr = qtrStr clipped, " and a.ceid=p.ceid " end if
   if( qUsed )then let qtrStr = qtrStr clipped, " and a.ceid=q.ceid " end if
#   if( rUsed )then let qtrStr = qtrStr clipped, " and a.ceid=r.ceid " end if
   if( i1Used )then let qtrStr = qtrStr clipped, " and a.ceid=i1.ceid " end if
   if( i2Used )then let qtrStr = qtrStr clipped, " and a.ceid=i2.ceid " end if
   if( i3Used )then let qtrStr = qtrStr clipped, " and a.ceid=i3.ceid " end if
   if( i4Used )then let qtrStr = qtrStr clipped, " and a.ceid=i4.ceid " end if
#   if( sUsed )then let qtrStr = qtrStr clipped, " and a.ceid=s.ceid " end if
   if( tUsed )then let qtrStr = qtrStr clipped, " and a.ceid=t.ceid " end if
   if( uUsed )then let qtrStr = qtrStr clipped, " and a.ceid=u.ceid " end if
#   if( vUsed )then let qtrStr = qtrStr clipped, " and a.ceid=v.ceid " end if
#   if( wUsed )then let qtrStr = qtrStr clipped, " and a.ceid=w.ceid " end if
#   if( xUsed )then let qtrStr = qtrStr clipped, " and a.ceid=x.ceid " end if
   if( yUsed )then let qtrStr = qtrStr clipped, " and a.ceid=y.ceid " end if
   if( zUsed )then let qtrStr = qtrStr clipped, " and a.ceid=z.ceid " end if

   if( eUsed )then let qtrStr = qtrStr clipped, " and a.ceid=e.ceid " end if
   if( fUsed )then let qtrStr = qtrStr clipped, " and a.ceid=f.ceid " end if
   if( gUsed )then let qtrStr = qtrStr clipped, " and a.ceid=g.ceid " end if
   if( hUsed )then let qtrStr = qtrStr clipped, " and a.ceid=h.ceid " end if

   if( sUsed )then let qtrStr = qtrStr clipped, " and a.ceid=s.ceid " end if
   if( iUsed )then let qtrStr = qtrStr clipped, " and a.ceid=i.ceid " end if
   if( jUsed )then let qtrStr = qtrStr clipped, " and a.ceid=j.ceid " end if

## add in curr_revenue join
   let qtrStr = qtrStr clipped, " and a.ceid=cr.ceid and cr.brand='", BRec.b_id clipped, "'"

   let qtrStr = qtrStr clipped, " ", AdhocStr clipped, " order by ", sort_by clipped
#else
#   let sort_by = "a.part_name"
#   let qtrStr = qtrStr clipped, " where a.ceid = k.ceid ", AdhocStr clipped, " order by ", sort_by clipped
#end if

#   let qtrStr = qtrStr clipped, " where a.ceid = k.ceid ", AdhocStr clipped, " order by ", sort_by clipped
#let qtrStr = qtrStr clipped, " into temp _t1"
#display qtrStr
#prepare Q0ID from qtrStr
#execute Q0ID
#let qtrStr = "select a.* from _t1"

##FINAL PREPARE
#display qtrStr, "<br>"
#whenever error continue
   prepare Q1ID from qtrStr
#display "SQLCODE: ", SQLCA.SQLCODE
   declare ACurs cursor for Q1ID
#display "SQLCODE: ", SQLCA.SQLCODE


let cnt = 0

foreach ACurs into tflg, tsols, tskill, tcontact, URec.*, KRec.*, LRec.*, MRec.*, NRec.*
#display "SQLCODE: ", SQLCA.SQLCODE
#display "START"
   let cnt = cnt + 1
# display "skillStr: ", skillStr clipped

   if( cnt = MasterRec.fap_results+1 )then
      display "</tbody>"
      display "</table>"

      display "<div style='margin-top: 10px; margin-bottom: 10px;'>"
#display "  <button class='w3-bar-item w3-button tablink' onClick=togglerows('More')>More</button>"
      display "  <a href='javascript:;' onClick=togglerows('More') id='link_show'>Show Complete List</a>"
      display "</div>"

      display "<div id='More' style='display: none;'>"
      display "<table dir='ltr' style='width: 1100px' border='0' cellspacing='0' class='mytable'>"
      display "<tbody>"
      display "<tr style='height: 30px'>"
      display "        <td style='width:200px' class='theader'><strong>Partner Name</strong></td>"
      display "        <td class='theader'><strong>Authorizations</strong></td>"
#      display "        <td class='theader'><strong>Skill Focus</strong></td>"
      display "        <td class='theader'><strong></strong></td>"
      display "        <td class='theader'><strong>Market Solutions</strong></td>"
      display "        <td class='theader'><strong>Partner Contact</strong></td>"
      display "        <td class='theader'><strong>IBM Contact</strong></td>"
      display "        <td class='theader'><strong>Social Feedback</strong></td>"
      display "</tr>"

   end if
   let SSRStr = GetSSRStr()
   display "<tr valign='top'>"

## show partner name
##   if( BRec.b_id[1]!="M" )then
##    use static page
##      display "<td class='tdborder'><a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/S/", URec.ceid clipped, ".html' target='pdetails'>", URec.part_name clipped, "</a><span style='font-size: 8px'></span></td>"
##    else
##    use dynamic page  #319
      display "<td class='tdborder'><a href='/", MasterRec.cgi_dir clipped, "/showNew", BRec.b_id clipped, "S.ksh?", URec.ceid clipped, "' target='pdetails'>", URec.part_name clipped, "</a><span style='font-size: 8px'></span></td>"
##   end if  #Market

## show authorizations
   let extStr=getAuth(URec.ceid clipped)
   display "<td class='tdborder'>", extStr clipped, "</td>"

## show skills
#   let extStr=getSkillFocus(URec.ceid clipped)
   let extStr=" "
   display "<td class='tdborder'>", extStr clipped, "</td>"

## show markets
   let extStr=getMarket(URec.ceid clipped)
   display "<td class='tdborder'>", extStr clipped, "</td>"

## show partner contact
   if( URec.p_name is not null and URec.p_name != " " and URec.p_email is not null and URec.p_email != " ")then
      display "<td class='tdborder'>", "<a href='mailto:", URec.p_email clipped, "' target='_blank'>", URec.p_name clipped, "</a></td>"
   else
      display "<td class='tdborder'>", "</td>"
   end if

## show ibm contact
   if( URec.ssr is not null and URec.ssr != " " )then
      let r_link=getRepLink( URec.ssr )
      display "<td class='tdborder'>", "<a href='", r_link clipped, "' target='_blank'>", URec.ssr clipped, "</a></td>"
   else
      display "<td class='tdborder'>", "</td>"
   end if


## show social
   call commentInfo( URec.ceid ) returning rcnt, ravg
   let rStr=getRatingStars( ravg )
	display "<td class='tdborder'><a href='/", MasterRec.cgi_dir clipped, "/review", BRec.b_id clipped, "S.ksh?", 
           URec.ceid clipped, "' target='_blank'>", rStr clipped, "</a></td>"
#   display "<td class='tdborder'>", rStr clipped, "</td>"
display "</tr>"

#display SSRStr clipped


end foreach
#display "CNT: ", cnt
if( cnt = 0 )then
   display "<em>No partners meet the search criteria.</em>"
end if
display "</td></tr>"

return qtrStr

end function  #ShowAdhocS

function ParseStrS( inStr)
define
   inStr, tStr char(2048),
   l,i,j smallint,
   EUStr char(2048),
   INDStr char(2048),
   SKStr char(2048),
   bucnt, indcnt, skcnt smallint,
   NewStr, oNewStr char(2048),
   skilllevel char(2),
#   skilllevelStr char(4),
   currBrand like brands.b_id,
   num_cnt, foundInd smallint,
   skillStr, nStr, vStr char(50),
   twoLtr smallint,
   caseStr char(2)
 

let bucnt = 0
let indcnt = 0
let skcnt = 0
initialize NewStr to NULL

let l=length(inStr clipped)

##------------------------------------
## look for SLevel
##------------------------------------
   for i=1 to l-6
      if( inStr[i,i+5] = "SLevel" )then
         let nStr=inStr[i,i+5]
         let vStr=inStr[i+7,i+7]
         let sSkill=vStr clipped
         exit for
      end if
   end for

##------------------------------------
## look for reg
##------------------------------------
initialize wStr to NULL
   let num_cnt=0
   let vStr=""
   for i=1 to l-2
      if( inStr[i,i+2] = "reg" )then
         let nStr=inStr[i,i+2]
         let vStr=inStr[i+4,i+4]
         let num_cnt=num_cnt+1
         let QArr[num_cnt] = vStr
#         display "nStr: ", nStr clipped
#         display "vStr: ", vStr clipped
      end if
   end for
#   display "Region: ", wStr clipped
#   display "vStr: ", vStr clipped
   if( vStr >0 )then
#   if( vStr != "" and vStr != " " and vStr >0 )then
      let wStr=buildRegionQ ( num_cnt )
#      display "wStr: ", wStr clipped
   end if

## fill out for display
   let tGStr=" "
   for i=1 to num_cnt
      let tStr=getRegionByID(QArr[i])
      if( tGStr is null or tGStr= " ")then
         if( num_cnt > 1 )then
            let tGStr="GEOGRAPHIES: ", tStr clipped
         else
            let tGStr="GEOGRAPHY: ", tStr clipped
         end if
      else
         let tGStr=tGStr clipped, ", ", tStr clipped
      end if
   end for

##------------------------------------
## look for mk
##------------------------------------
   let num_cnt=0
   let vStr=""
#  clear QArr
   for i=1 to 7
      let QArr[i]=""
   end for  #clear QArr
   for i=1 to l-1
#      let tStr = inStr[i,i+1]
#      display "tmp: ", tStr clipped
      if( inStr[i,i+1] = "mk" )then
         let nStr=inStr[i,i+1]
         let vStr=inStr[i+3,i+3]
	 let num_cnt=num_cnt+1
	 let QArr[num_cnt] = vStr
#         display "vStr: ", vStr clipped
      end if
   end for
   if( wStr is NULL or wStr =" " )then
      let wStr=buildMarketQ ( num_cnt )
   else
      if( vStr != "" )then
         let wStr=wStr clipped, " or ", buildMarketQ ( num_cnt )
      end if
   end if

## fill out for display
   let tMStr=" "
   for i=1 to num_cnt
      let tStr=getMarketByID(QArr[i])
      if( tMStr is null or tMStr= " ")then
         if( num_cnt >1 )then
            let tMStr="MARKETS: ", tStr clipped
         else
            let tMStr="MARKET: ", tStr clipped
         end if
      else
         let tMStr=tMStr clipped, ", ", tStr clipped
      end if
   end for

#   display "wStr: ", wStr clipped


##FIND SKILLS
let kUsed = FALSE
let lUsed = FALSE
let mUsed = FALSE
let cUsed = FALSE
let dUsed = FALSE
let bUsed = FALSE
let nUsed = FALSE
let pUsed = FALSE
let qUsed = FALSE
#let rUsed = FALSE
let i1Used = FALSE
let i2Used = FALSE
let i3Used = FALSE
let i4Used = FALSE
let sUsed = FALSE
let iUsed = FALSE
let jUsed = FALSE
let tUsed = FALSE
let uUsed = FALSE
#let vUsed = FALSE
#let wUsed = FALSE
#let xUsed = FALSE
let yUsed = FALSE
let zUsed = FALSE

let eUsed = FALSE
let fUsed = FALSE
let gUsed = FALSE
let hUsed = FALSE

let twoLtr=FALSE

for i = 1 to l-7
  if(inStr[i+2,i+7]="skill_") then
     let skillStr=inStr[i+2,i+9]
     let SKStr=inStr[i+2,i+9]

## first case is single letter
if( inStr[i-1]="&" and inStr[i+1]="=" )then
  let caseStr=inStr[i,i+1]
#display "A"
## second case is two letters
else
   let caseStr=inStr[i-1,i]
   let twoLtr=TRUE
#display "B"
end if  #inStr

   case caseStr
#case inStr[i,i+1] 
   when "k="
      let kUsed = TRUE
#      let currBrand = "A1"
      let currBrand = "N1"
   when "l="
      let lUsed = TRUE
#      let currBrand = "A2"
      let currBrand = "N2"
   when "m="
      let mUsed = TRUE
#      let currBrand = "A3"
      let currBrand = "N3"
   when "c="
      let cUsed = TRUE
#      let currBrand = "A4"
      let currBrand = "N4"
   when "d="
      let dUsed = TRUE
#      let currBrand = "A5"
      let currBrand = "N5"
   when "b="
      let bUsed = TRUE
      let currBrand = "AG"
   when "n="
      let nUsed = TRUE
      let currBrand = "SE"
   when "p="
      let pUsed = TRUE
      let currBrand = "WA"
   when "q="
      let qUsed = TRUE
      let currBrand = "ES"
#   when "r"
#      let rUsed = TRUE
#      let currBrand = "IO"
   when "i1"
      let i1Used = TRUE
      let currBrand = "I1"
   when "i2"
      let i2Used = TRUE
      let currBrand = "I2"
   when "i3"
      let i3Used = TRUE
      let currBrand = "I3"
   when "i4"
      let i4Used = TRUE
      let currBrand = "I4"
   when "s="
      let sUsed = TRUE
      let currBrand = "SW"
   when "i="
      let iUsed = TRUE
      let currBrand = "SH"
   when "j="
      let jUsed = TRUE
      let currBrand = "SV"
   when "t="
      let tUsed = TRUE
#      let currBrand = "S1"
      let currBrand = "N6"
   when "u="
      let uUsed = TRUE
#      let currBrand = "S2"
      let currBrand = "N7"
{
   when "v"
      let vUsed = TRUE
      let currBrand = "S3"
   when "w"
      let wUsed = TRUE
      let currBrand = "S4"
   when "x"
      let xUsed = TRUE
      let currBrand = "S5"
}
   when "y="
      let yUsed = TRUE
      let currBrand = "CO"
   when "z="
      let zUsed = TRUE
      let currBrand = "CU"

   when "e="
      let eUsed = TRUE
      let currBrand = "B1"
   when "f="
      let fUsed = TRUE
      let currBrand = "B2"
   when "g="
      let gUsed = TRUE
      let currBrand = "B3"
   when "h="
      let hUsed = TRUE
      let currBrand = "B4"
end case

if( sStr is not null )then
   let sStr = sStr clipped, " and "
end if
#display "twoLtr:", twoLtr, " currBrand: ", currBrand, " inStr:", inStr clipped, " i:", i
if( twoLtr )then
   let sStr=sStr clipped, " (", currBrand clipped, ".", inStr[i+2,i+9], ">='3') "
#   let sStr=sStr clipped, " (", inStr[i-1,i], ".", inStr[i+3,i+10], ">='3') "
else
   let sStr=sStr clipped, " (", inStr[i], ".", inStr[i+2,i+9], ">='3') "
end if
if( SkillSrchStr = " " )then
   if( twoLtr )then
      let SkillSrchStr="case when ", currBrand clipped, ".", inStr[i+2,i+9], "> 3 then 1 else 0 end desc, "
   else
      let SkillSrchStr="case when ", inStr[i], ".", inStr[i+2,i+9], "> 3 then 1 else 0 end desc, "
   end if  #twoLtr
#   let SkillSrchStr=inStr[i], ".", inStr[i+2,i+9], "> 3 desc, "
else
   if( twoLtr )then
      let SkillSrchStr=SkillSrchStr clipped, "case when ", currBrand clipped, ".", inStr[i+2,i+9], "> 3 then 1 else 0 end desc, "
   else
      let SkillSrchStr=SkillSrchStr clipped, "case when ", inStr[i], ".", inStr[i+2,i+9], "> 3 then 1 else 0 end desc, "
   end if  #twoLtr
#   let SkillSrchStr=SkillSrchStr clipped, " ", inStr[i], ".", inStr[i+2,i+9], "> 3 desc, "
end if  #SkilSrchStr
#display "SkillSrchStr: ", SkillSrchStr clipped, "<br>"

{
     let skilllevel=inStr[i+15,i+15]
display "SKILLLEVEL: ", skilllevel, "<br>"
     case skilllevel
        when '3'
           let skilllevelStr = "(Recommended Partners Only)"
        when '2'
           let skilllevelStr = "(Recommended AND Skilled Partners)"
        when '1'
           let skilllevelStr = "(Recommended, Skilled, and Learning Partners)"
     end case
}


#display "NEXT STEP. currBrand=", currBrand clipped, " <br>"
#     for j = i to l
#        if( inStr[j]="=")then
#	display "i:", i, " j:", j, " l:", l, " inStr:", inStr clipped, "<br>"
#           let SKStr = inStr[i,j-2]
           let NewStr = GetSKStrU(currBrand, SKStr)
#display "currBrand: ", currBrand
#display "SKStr: ", SKStr
#display "NewStr: ", NewStr 
           if( skcnt =0 )then
              let DispStr = DispStr clipped, "SKILLS: ", NewStr clipped, " "
           else  #ParseStr
              let DispStr = DispStr clipped, ", ", NewStr clipped, " "
            end if
           let skcnt = skcnt + 1
#           exit for
#        end if
#     end for

  end if 
end for

let DispStr = DispStr clipped, " ", skilllevelStr clipped

#display "DispStr: ", DispStr clipped, "<br>"
end function  #ParseStrS

function GetEUStr( inStr)
define
   inStr char(64),
   colStr char(30),
   QStr char(128),
   tStr like eus.e_name,
   i smallint


   initialize tStr to NULL
   initialize QStr to NULL
   let QStr = "select unique a.e_name from eus a where a.e_brand = '", BRec.b_id clipped, "' and a.e_id = "
   let colStr = inStr[3,64] clipped

#   display "QStr (before for): ", QStr clipped
   for i = 1 to G_NumCols
      if( EUColNamesArr[i].colname = colStr )then
         let QStr = QStr clipped, " ", EUColNamesArr[i].idx using '##'
         exit for
      end if
   end for
#   display "QStr (after for): ", QStr clipped

#display "QStr: ", QStr
prepare LBID from QStr 
execute LBID into tStr

return tStr

end function  #GetEUStr


function GetINDStr( inStr)
define
   inStr char(64),
   colStr char(30),
   QStr char(128),
   tStr like industry.i_name,
   i smallint


   initialize tStr to NULL
   initialize QStr to NULL
   let QStr = "select unique a.i_name from industry a where a.i_brand = '", BRec.b_id clipped, "' and a.i_id = "
   let colStr = inStr[3,64] clipped

#   display "inStr: ", inStr clipped, "<br>"
#   display "QStr (before for): ", QStr clipped, "<br>"
#   display "colStr: ", colStr clipped, "<br>"
   for i = 1 to G_INDNumCols
#display "i:", i, " i_col: ", INDColNamesArr[i].i_col clipped, " idx: ", INDColNamesArr[i].idx using "##", " colStr: ", colStr clipped, "<br>"
      if( INDColNamesArr[i].i_col = colStr )then
         let QStr = QStr clipped, " ", INDColNamesArr[i].idx using '##'
         exit for
      end if
   end for
#   display "QStr (after for): ", QStr clipped, "<br>"

#display "QStr: ", QStr
prepare GISID from QStr 
execute GISID into tStr

return tStr

end function  #GetINDStr

function GetSKStrU( inBrand, inStr )
define
   inBrand like brands.b_id,
   inStr char(64),
   colStr char(20),
   QStr char(128),
   tStr char(128)

   let QStr = "select unique a.s_desc from skill a where a.b_id = '", inBrand clipped,
              "' and a.db_num = "
   let colStr = inStr clipped

#display "QStr: ", QStr clipped
#display "colStr: ", colStr clipped

   case colStr 
      when "skill_01"
         let QStr = QStr clipped, " 1"
      when "skill_02"
         let QStr = QStr clipped, " 2"
      when "skill_03"
         let QStr = QStr clipped, " 3"
      when "skill_04"
         let QStr = QStr clipped, " 4"
      when "skill_05"
         let QStr = QStr clipped, " 5"
      when "skill_06"
         let QStr = QStr clipped, " 6"
      when "skill_07"
         let QStr = QStr clipped, " 7"
      when "skill_08"
         let QStr = QStr clipped, " 8"
      when "skill_09"
         let QStr = QStr clipped, " 9"
      when "skill_10"
         let QStr = QStr clipped, "10"
      when "skill_11"
         let QStr = QStr clipped, "11"
      when "skill_12"
         let QStr = QStr clipped, "12"
      when "skill_13"
         let QStr = QStr clipped, "13"
      when "skill_14"
         let QStr = QStr clipped, "14"
      when "skill_15"
         let QStr = QStr clipped, "15"
      when "skill_16"
         let QStr = QStr clipped, "16"
      when "skill_17"
         let QStr = QStr clipped, "17"
      when "skill_18"
         let QStr = QStr clipped, "18"
      when "skill_19"
         let QStr = QStr clipped, "19"
      when "skill_20"
         let QStr = QStr clipped, "20"
      when "skill_21"
         let QStr = QStr clipped, "21"
      when "skill_22"
         let QStr = QStr clipped, "22"
      when "skill_23"
         let QStr = QStr clipped, "23"
      when "skill_24"
         let QStr = QStr clipped, "24"
      when "skill_25"
         let QStr = QStr clipped, "25"
      when "skill_26"
         let QStr = QStr clipped, "26"
      when "skill_27"
         let QStr = QStr clipped, "27"
      when "skill_28"
         let QStr = QStr clipped, "28"
      when "skill_29"
         let QStr = QStr clipped, "29"
      when "skill_30"
         let QStr = QStr clipped, "30"
      otherwise
      let QStr = QStr clipped, "99"
   end case

#display "Skill QStr: ", QStr
prepare LSID from QStr 
execute LSID into tStr
#display "tStr: ", tStr

return tStr

end function


function buildRegionQ( inCnt )
define
   inCnt smallint,
   i, val smallint,
   tColname like _eucolnamesU.colname,
   retStr char(1024),
   SQLStr char(1024)

#display "buildRegionQ: inCnt: ", inCnt
   initialize retStr to NULL
   for i=1 to inCnt
      let val=QArr[i]
      let SQLStr="select a.colname from _eucolnamesU a, eus b, region c where a.idx=b.e_id and b.e_region=c.e_region and b.e_brand='", BRec.b_id clipped, "' and ",
                 "c.e_ord=", val
#display "buildRegionQ: SQLStr: ", SQLStr
      prepare BRQID from SQLStr
      declare BRQCurs cursor for BRQID
      foreach BRQCurs into tColname
         if( retStr is NOT NULL )then
            let retStr = retStr clipped, " or "
         end if
         let retStr=retStr clipped, " (a.", tColname clipped, "='H' or a.", tColname clipped, "='Y')"
      end foreach
   end for

   return retStr

end function  #buildRegionQ



function buildMarketQ( inCnt )
define
   inCnt smallint,
   i, val smallint,
   tColname like _ind_colname.i_col,
   retStr char(512),
   SQLStr char(1024)

   initialize retStr to NULL
   for i=1 to inCnt
      let val=QArr[i]
      let SQLStr="select a.i_col from _ind_colname a, industry b, market c where a.idx=b.i_id and b.ig_name=c.m_name and b.i_brand='", BRec.b_id clipped, "' and ",
                 "c.ord=", val
#display SQLStr
      prepare BMQID from SQLStr
      declare BMQCurs cursor for BMQID
      foreach BMQCurs into tColname
         if( retStr is NOT NULL )then
            let retStr = retStr clipped, " or "
         end if
         let retStr=retStr clipped, " (a.", tColname clipped, ">='3')"
      end foreach
   end for

   return retStr

end function  #buildMarketQ



function buildSkillQ( inCnt, inLevel )
define
   inCnt smallint,
   inLevel smallint,
   i smallint, 
   nm, val char(50),
   ttab like unit_brand.ltr,
   retStr char(512),
   SQLStr char(1024)

   initialize retStr to NULL
   for i=1 to inCnt
      let nm=QSArr[i].n
      let val=QSArr[i].v
      let SQLStr="select a.ltr from unit_brand a where a.b_id='", nm clipped, "'"
#    display SQLStr clipped
      prepare BSQID from SQLStr
      declare BSQCurs cursor for BSQID
      foreach BSQCurs into ttab
         let retStr=retStr clipped, " (", ttab clipped, ".", val clipped, ">=", inLevel using "<",")"
      end foreach
   end for

   return retStr

end function  #buildSkillQ

function getAuth( inCEID )
define
   inCEID like coverage_au.ceid,
   tauth like svp_info.prod_grp_desc,
   retStr char(256),
   SQLStr char(512)

   let retStr=" "
   let SQLStr="select unique a.prod_grp_desc from svp_info a, svp b where a.prod_grp_desc=b.comp_name and b.s_brand='", BRec.b_id clipped, "' and a.ceid='", inCEID clipped, "' order by 1"
   prepare gAID from SQLStr
   declare gACurs cursor for gAID
   foreach gACurs into tauth
      if( retStr = "" or retStr = " ")then
         let retStr=tauth
      else
         let retStr=retStr clipped, "<br>", tauth
      end if
     
   end foreach

   return retStr

end function  #getAuth


function getSkillFocus( inCEID )
define
   inCEID like coverage_au.ceid,
   skill_top like unit_brand.sdesc,
   vSkillStr, retStr char(256),
   SQLStr char(512)

   let retStr=" "
   let SQLStr="select unique a.prod_grp_desc from svp_info a, svp b where a.prod_grp_desc=b.comp_name and b.s_brand='", BRec.b_id clipped, "' and a.ceid='", inCEID clipped, "' order by 1"

   let vSkillStr=" "
   if( CtlRec.skill_tab1 is not null and CtlRec.skill_tab1 != " " )then
      let vSkillStr=skillInTab( CtlRec.skill_tab1 )
      if( vSkillStr != " ")then
         let retStr=vSkillStr
      end if
   end if
   if( CtlRec.skill_tab2 is not null and CtlRec.skill_tab2 != " " )then
      let vSkillStr=skillInTab( CtlRec.skill_tab2 )
      if( retStr != " " )then
         let retStr=retStr clipped, "<br>"
      end if
      if( vSkillStr != " ")then
         let retStr=retStr clipped, vSkillStr
      end if
   end if
   if( CtlRec.skill_tab3 is not null and CtlRec.skill_tab3 != " " )then
      let vSkillStr=skillInTab( CtlRec.skill_tab3 )
      if( retStr != " " )then
         let retStr=retStr clipped, "<br>"
      end if
      if( vSkillStr != " ")then
         let retStr=retStr clipped, vSkillStr
      end if
   end if
   if( CtlRec.skill_tab4 is not null and CtlRec.skill_tab4 != " " )then
      let vSkillStr=skillInTab( CtlRec.skill_tab4 )
      if( retStr != " " )then
         let retStr=retStr clipped, "<br>"
      end if
      if( vSkillStr != " ")then
         let retStr=retStr clipped, vSkillStr
      end if
   end if
   if( CtlRec.skill_tab5 is not null and CtlRec.skill_tab5 != " " )then
      let vSkillStr=skillInTab( CtlRec.skill_tab5 )
      if( retStr != " " )then
         let retStr=retStr clipped, "<br>"
      end if
      if( vSkillStr != " ")then
         let retStr=retStr clipped, vSkillStr
      end if
   end if

   return retStr

end function  #getSkillFocus


function skillInTab( intab )
define
   intab like control.skill_tab1,
   i,l smallint,
   tbr char(2),
   tresp char(1),
   retval like unit_brand.sdesc,
   fn char(1),  #focus number
   SQLStr char(2048)


   let fn="2"
   let tresp=" "
  
   let SQLStr="select unique 'Y' from ", intab clipped, " where ",
      "skill_01>", fn, " or skill_02>", fn, " or skill_03>", fn, "  or skill_04>", fn, "  or skill_05>", fn, "  or skill_06>", fn, "  or skill_07>", fn, "  or skill_08>", fn, "  or skill_09>", fn, "  or skill_10>", fn, "  or ",
      "skill_11>", fn, "  or skill_12>", fn, "  or skill_13>", fn, "  or skill_14>", fn, "  or skill_15>", fn, "  or skill_16>", fn, "  or skill_17>", fn, "  or skill_18>", fn, "  or skill_19>", fn, "  or skill_20>", fn, "  or ",
      "skill_21>", fn, "  or skill_22>", fn, "  or skill_23>", fn, "  or skill_24>", fn, "  or skill_25>", fn, "  or skill_26>", fn, "  or skill_27>", fn, "  or skill_28>", fn, "  or skill_29>", fn, "  or skill_30>", fn

#display SQLStr clipped
   prepare sITID from SQLStr
   execute sITID into tresp

   if( tresp="Y" )then
      let tbr=upshift(intab[8,9])
      let SQLStr="select sdesc from unit_brand where b_id='", tbr clipped, "'"
      prepare sIT2ID from SQLStr
      execute sIT2ID into retval
   end if

   return retval

end function  #skillInTab


function getMarketByID( inID )
define
   inID like market.ord,
   SQLStr char(128),
   retStr like market.m_name

   let SQLStr="select m_name from market where ord=", inID
   prepare gMBID from SQLStr
   execute gMBID into retStr

   return retStr

end function  #getMarketByID


function getRegionByID( inID )
define
   inID like region.e_ord,
   SQLStr char(128),
   retStr like region.e_region

   let SQLStr="select e_region from region where e_ord=", inID
   prepare gRBID from SQLStr
   execute gRBID into retStr

   return retStr

end function  #getRegionByID

function getMarket( inCEID )
define
   inCEID like coverage_au.ceid,
   tmkt like market.m_short,
   retStr char(256),
   SQLStr char(512)

   let retStr=" "
#   let SQLStr="select unique a.m_short, c.i_col from market a, industry b, _ind_colname c where a.m_name=b.ig_name and b.i_id=c.idx and b.i_brand='", BRec.b_id clipped, "' order by 1"
   let SQLStr="select a.* from ", cov_tab clipped, " a where a.ceid='", inCEID clipped, "'"
   prepare gMID from SQLStr
   execute gMID into URec.*
      if( URec.ind_csi >='3' or URec.ind_eu >='3' or URec.ind_me >='3' or URec.ind_tel >='3' )then
         if( retStr = " " )then
            let retStr='Comms/CSI'
         else
            let retStr=retStr clipped, "<br>", 'Comms/CSI'
         end if
      end if

      if( URec.ind_consume >='3' or URec.ind_ret >='3' or URec.ind_trans >='3' )then
         if( retStr = " " )then
            let retStr='Distribution'
         else
            let retStr=retStr clipped, "<br>", 'Distribution'
         end if
      end if

      if( URec.ind_bank >='3' or URec.ind_finan >='3' or URec.ind_ins >='3' )then
         if( retStr = " " )then
            let retStr='Financial Services'
         else
            let retStr=retStr clipped, "<br>", 'Financial Services'
         end if
      end if

      if( URec.ind_auto >='3' or URec.ind_chem >='3' or URec.ind_defense >='3' or URec.ind_elect >='3' or URec.ind_indprod )then
         if( retStr = " " )then
            let retStr='Industrial'
         else
            let retStr=retStr clipped, "<br>", 'Industrial'
         end if
      end if

      if( URec.ind_education >='3' or URec.ind_gov >='3' or URec.ind_hl >='3' or URec.ind_lifesci >='3' )then
         if( retStr = " " )then
            let retStr='Public'
         else
            let retStr=retStr clipped, "<br>", 'Public'
         end if
      end if

      if( URec.eu_ca ='Y' or URec.eu_ca ='H' )then
         if( retStr = " " )then
            let retStr='Canada'
         else
            let retStr=retStr clipped, "<br>", 'Canada'
         end if
      end if

      if( URec.eu_fed ='Y' or URec.eu_fed ='H' )then
         if( retStr = " " )then
            let retStr='Federal'
         else
            let retStr=retStr clipped, "<br>", 'Federal'
         end if
      end if

   return retStr

end function  #getMarket


function getSocial( inCEID )
define
   inCEID like coverage_au.ceid,
   tmkt like market.m_short,
   retStr char(256),
   SQLStr char(512)

   let retStr=""
#   let SQLStr="select unique a.m_short, c.i_col from market a, industry b, _ind_colname c where a.m_name=b.ig_name and b.i_id=c.idx and b.i_brand='", BRec.b_id clipped, "' order by 1"
   let SQLStr="select a.* from ", cov_tab clipped, " a where a.ceid='", inCEID clipped, "'"
   prepare gSID from SQLStr
   execute gSID into URec.*
      if( URec.ind_csi >='3' or URec.ind_eu >='3' or URec.ind_me >='3' or URec.ind_tel >='3' )then
         if( retStr = "" )then
            let retStr='Comms/CSI'
         else
            let retStr=retStr clipped, "<br>", 'Comms/CSI'
         end if
      end if

      if( URec.ind_consume >='3' or URec.ind_ret >='3' or URec.ind_trans >='3' )then
         if( retStr = "" )then
            let retStr='Distribution'
         else
            let retStr=retStr clipped, "<br>", 'Distribution'
         end if
      end if

      if( URec.ind_bank >='3' or URec.ind_finan >='3' or URec.ind_ins >='3' )then
         if( retStr = "" )then
            let retStr='Financial Services'
         else
            let retStr=retStr clipped, "<br>", 'Financial Services'
         end if
      end if

      if( URec.ind_auto >='3' or URec.ind_chem >='3' or URec.ind_defense >='3' or URec.ind_elect >='3' or URec.ind_indprod )then
         if( retStr = "" )then
            let retStr='Industrial'
         else
            let retStr=retStr clipped, "<br>", 'Industrial'
         end if
      end if

      if( URec.ind_education >='3' or URec.ind_gov >='3' or URec.ind_hl >='3' or URec.ind_lifesci >='3' )then
         if( retStr = "" )then
            let retStr='Public'
         else
            let retStr=retStr clipped, "<br>", 'Public'
         end if
      end if

      if( URec.eu_ca ='Y' or URec.eu_ca ='H' )then
         if( retStr = "" )then
            let retStr='Canada'
         else
            let retStr=retStr clipped, "<br>", 'Canada'
         end if
      end if

      if( URec.eu_fed ='Y' or URec.eu_fed ='H' )then
         if( retStr = "" )then
            let retStr='Federal'
         else
            let retStr=retStr clipped, "<br>", 'Federal'
         end if
      end if

   return retStr

end function  #getSocial


{
function getAuth( inCEID )
define
   inCEID like coverage_au.ceid,
   t
   retStr char(256),
   SQLStr char(512)

   let SQLStr="select unique a.prod_grp_desc from svp_info a where a.prod_grp_desc=b.comp_name and b.s_brand='", URec.u_id clipped, "' and a.ceid='", inCEID clipped, "' order by 1"
   prepare gAID from SQLStr
   declare gACurs cursor for gAID
   foreach gACurs into 


   return retStr

end function  #getAuth
}


function ParseName( inStr )
define
   inStr char(1048),
   i,l smallint,
   retStr char(1048)
   let l=length(inStr)

   if( l>10 )then
# nmsearch=
      let retStr=inStr[10,l]
   end if

   return retStr

end function  #ParseName


function ParseSSR( inStr )
define
   inStr char(2048),
   i,l smallint,
   retStr char(2048)
   let l=length(inStr)

   if( l>11 )then
# nmsearch=
      let retStr=inStr[11,l]
   end if

   return retStr

end function  #ParseSSR

