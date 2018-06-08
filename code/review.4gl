
### June      12, 2017 - John M. Shoemaker, jshoemaker1@cox.net, create file, #235

globals "globals.4gl"

main

define
   i smallint,
   RRec record like review.*,
   kStr, vStr, wStr, cmdStr char(1024),
   inCEID like review.ceid,
   inBRAND like review.brand,
   pName like coverage_au.part_name,
   ccnt,ocnt smallint,
   cavg smallfloat,
   ratingStr char(5),
   brandStr like control.menu_str,
   SQLStr char(256)

call ReadCmdLn("review", 4)
call ProcCmdLn("review")
call Header(7, IRec.i_id, BRec.b_id, 1)
let cmdStr = arg_val(4)

## extract the FORM TYPE
call findIdx( cmdStr ) returning kStr, vStr, wStr
let inCEID=vStr 
call findIdx( wStr ) returning kStr, vStr, wStr
let inBRAND=vStr 

display " "

let SQLStr="select a.part_name from coverage_", inBRAND clipped, " a where a.ceid='", inCEID clipped, "'"
prepare RVPNID from SQLStr
execute RVPNID into pName
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", CtlRec.menu_str  clipped,"</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", "SOCIAL COMMENTS AND REVIEW","</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", "for","</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
if( pName is not NULL )then
   display "<em><span style='font-size: 20px'>", pName clipped, "(", inCEID clipped, ")", "</span></em></div>"
else
   display "<em><span style='font-size: 20px'>", inCEID clipped,"</span></em></div>"
end if
display "<p>"

display "<div dir='ltr' style='text-align: center'>"
display "</div>"
call commentInfo(inCEID) returning ccnt, cavg

let SQLStr="select a.* from review a where a.ceid='", inCEID clipped, "' and a.stat!='S' order by updtime desc"
prepare RVID from SQLStr
declare RVCurs cursor for RVID
let ocnt=0
foreach RVCurs into RRec.*
   if( RRec.stat = "P" )then
      let ratingStr=getRatingStr(RRec.rating)
      let SQLStr="select a.menu_str from control a where a.brand='", RRec.brand clipped, "'"
      prepare RVFE from SQLStr
      execute RVFE into brandStr
      display "<em>", RRec.comment clipped, "</em><br>"
      display ratingStr, " by ", RRec.reviewer clipped, " on ", RRec.updtime, " for ", brandStr, " brand<p>"
   else
      let ocnt=ocnt+1
   end if
end foreach

if( ocnt > 0 )then
   if( ocnt = 1 )then
      display "<br>(", ocnt using '##&', " comment waiting for review)"
   else
      display "<br>(", ocnt using '##&', " comments waiting for review)"
   end if
end if

## allow entry of new rating comment
   display "<p>"
   display "<br><div><span style='font-size: 12pt'> >>> Add New Rating & Social Feedback <<< </span><br>"
   display "<FORM ID='review' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=1001>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", inCEID clipped,">"
   display "<INPUT NAME='brand' TYPE=hidden READONLY VALUE=", BRec.b_id clipped,">"
   display "Rating 1(lowest) - 5(highest): <INPUT NAME='rating' TYPE=text SIZE=1 required><br>" 
   display "Reviewer: <INPUT NAME='rname' TYPE=text SIZE=40 required><br>" 
   display "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbspEmail: <INPUT NAME='remail' TYPE=text SIZE=40 required><br>" 
   display "Comment: <textarea cols=51 rows=5 NAME=newcomment  required></textarea><br>"
   display "<INPUT TYPE=submit VALUE='Add Comment'><br>"
   display "</FORM>"

display "</tbody>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

