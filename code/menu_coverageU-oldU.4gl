
### July 31, 2014 - John M. Shoemaker, create new menu item for coverage
### March 05, 2015 - John M. Shoemaker, migrate to Units
### March 19, 2015 - John M. Shoemaker, change BDR to BPR
### March 31, 2015 - John M. Shoemaker, add optional coverage_map


globals "globals.4gl"

main

define
i smallint

call ReadCmdLn("coverage", 4)
call ProcCmdLn("coverage")
call Header(7, IRec.i_id, BRec.b_id, 1)

display " "

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

display "<div dir='ltr' style='text-align: center'>"
if( EUsFlg )then
   display "<span style='font-size:18px;'><a href='../H/coverage_plan.html'>Coverage Plan </a></span> &nbsp - &nbsp the coverage team for each Region/EU "
   if( CtlRec.cflg5 )then
      display "(see the map <a href='../H/coverage_map.jpg' target='_blank'>here</a>)"
   else
      display "cflg5: ", CtlRec.cflg5
   end if
   display "<p>"
#   display "<span style='font-size:18px;'><a href='../H/coverage_plan.html'>Coverage Plan </a>- </span> &nbsp / &nbsp"
   display "<span style='font-size:18px;'><a href='../H/coverage_eus.html'>Coverage List (by BPR) </a></span> &nbsp - &nbsp listing of partners by IBM Channels BPR (Brand Rep) <p"
   display "<span style='font-size:18px;'><a href='../H/coverage_eus_tss.html'>Coverage List (by TSS)</a></span> &nbsp - &nbsp listing of partners by IBM Channels TSS <p>"
else
   display "<span style='font-size:18px;'><a href='../H/coverage.html'>Coverage List </a></span><br /><p>"
end if

#display "<span style='font-size:18px;'><a href='../H/byStatus.html'>Partner List by Segmentation (C-I-O code) </a></span><br /><br />"
display "</div>"
#display "<span style='font-size:18px;'><a href='../H/hvp.html'>High Value Partner List </a></span><br /><br />"


display "</tbody>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

