
### July 31, 2014 - John M. Shoemaker, create new menu item for coverage
### March 19, 2015 - John M. Shoemaker, change BDR to BPR
### March 31, 2015 - John M. Shoemaker, add coverage_map
### April 08, 2015 - John M. Shoemaker, add segment leaders
### May   08, 2015 - John M. Shoemaker, add master coverage
### June  17, 2015 - John M. Shoemaker, add segment report
### February  29, 2016 - John M. Shoemaker, remove some coverage links #138
### May       20, 2016 - John M. Shoemaker, include showing other coverage (showextend_st)
### May       23, 2016 - John M. Shoemaker, hide Master Coverage List for now
### August    22, 2016 - John M. Shoemaker, provide more options, #184 #185
### January   31, 2017 - John M. Shoemaker, make coverage by geo an option, #202
### February  15, 2017 - John M. Shoemaker, replace TSS term, #209
### February  15, 2017  John M. Shoemaker, change title menu variable, #207
### November  06, 2017  John M. Shoemaker, repurpose showgeo so remove from here, #287

globals "globals.4gl"

main

define
   i smallint

call ReadCmdLn("coverage", 4)
call ProcCmdLn("coverage")
call Header(7, IRec.i_id, BRec.b_id, 1)

display " "

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", CtlRec.menu_str  clipped,"</span></em></div>"
display "<p>"

display "<div dir='ltr' style='text-align: center'>"
if( EUsFlg )then
#   display "<span style='font-size:18px;'><a href='../H/coverage_plan.html'>Coverage Plan </a>- </span> &nbsp / &nbsp"
   if( UnitModeYN() )then
      if( NOT CtlRec.altercover )then
#######################################
## remove showgeo from this context
{
         if( CtlRec.showgeo )then
            display "<span style='font-size:18px;'><a href='../H/coverage_planU.html'>Coverage Plan (by Geography) </a></span> &nbsp - &nbsp the ", CtlRec.bpr_stext clipped, " and PCR coverage team for each Region"
            if( CtlRec.cflg5 )then
               display "(see the map <a href='../H/coverage_map.jpg' target='_blank'>here</a>)"
            end if  #cflg5
            display "<p>"
         end if  #showgeo
}
#######################################
      end if  #altercover

      display "<span style='font-size:18px;'><a href='../H/coverage_eusU.html'>Coverage List "
      if( CtlRec.ctppairflg )then
         display "(by Coverage Team)"
      else
         display "(by ", CtlRec.bpr_stext clipped, ")"
      end if
      display "</a></span> &nbsp - &nbsp listing of partners by "
      if( CtlRec.ctppairflg )then
         display "Coverage Team <p>"
      else
         display CtlRec.bpr_ltext clipped, "<p>"
      end if

##    show other coverage
      if( CtlRec.showextend_st )then
         display "<span style='font-size:18px;'><a href='../H/coverage_eus_otherU.html'>Coverage List (by SISS SPR)"
         display "</a></span> &nbsp - &nbsp listing of partners by IBM SISS Specialty Partner Rep<p>"
      end if  #CtlRec.showextend_st

      if( NOT CtlRec.altercover )then
         display "<span style='font-size:18px;'><a href='../H/coverage_eus_tssU.html'>Coverage List (by ", CtlRec.tss_ltext clipped, ")</a></span> &nbsp - &nbsp listing of partners by IBM Channels ", CtlRec.tss_Str clipped, "<p>"
      end if  #altercover

      if( CtlRec.seg )then
         display "<span style='font-size:18px;'><a href='../H/segment_leadersU.html'>Segment Leaders</a></span> &nbsp - &nbsp listing of Segment Leaders and their Segments <p>"
      end if  #CtlRec.seg - show segment leaders
   else  #not UnitmodeYN
   display "<span style='font-size:18px;'><a href='../H/coverage_plan.html'>Coverage Plan </a></span> &nbsp - &nbsp the coverage team for each Region/EU <p>"
      display "<span style='font-size:18px;'><a href='../H/coverage_eus.html'>Coverage List (by BPR) </a></span> &nbsp - &nbsp listing of partners by IBM Channels BPR (Brand Rep) <p"
      display "<span style='font-size:18px;'><a href='../H/coverage_eus_tss.html'>Coverage List (by ", CtlRec.tss_ltext clipped, ")</a></span> &nbsp - &nbsp listing of partners by IBM Channels ", CtlRec.tss_ltext clipped, " <p>"
   end if  #UnitModeYN
else
   display "<span style='font-size:18px;'><a href='../H/coverage.html'>Coverage List </a></span><br /><p>"
end if  #EUsFlg

   if( CtlRec.show_cio )then
      display "<span style='font-size:18px;'><a href='../H/byStatus.html'>List by Software Segmentation </a></span> &nbsp - &nbsp listing of partners by Segmentation <br /><br />"
   end if

## show POD coverage
   display "<span style='font-size:18px;'><a href='../H/coverage_pod.html'>POD Coverage List </a></span> &nbsp - &nbsp listing of partners by POD (all IBM Software/Systems Units) <br /><br />"

#display "<span style='font-size:18px;'><a href='../../all/H/master_coverage.html'>Master Coverage List</a></span> &nbsp - &nbsp listing of BPR/TSS Coverage for Analytics, Systems & Commerce <p>"

display "</div>"
#display "<span style='font-size:18px;'><a href='../H/hvp.html'>High Value Partner List </a></span><br /><br />"


display "</tbody>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

