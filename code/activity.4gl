
# August   02, 2017  John M. Shoemaker, jshoemaker1@cox.net - created, #214

globals "globals.4gl"

define
   ActInitRec record like act_initiative.*,
   ActRec record like activity.*,
   rowcnt smallint,
   c1,c2 char(6)

main
define
   FcastBprRec record like fcast_bpr.*,
   FcastRec record like fcast_au.*,
   SSRname like fcast_au.ssr,
   eVar char(128),
   fcname like fcast_bpr.ssr,
   i,j smallint,
   revArr array[5] of float,
   revttl float,
   cnt,rc smallint,
   kStr, vStr char(128),
   tOrd smallint,
   emailtype, pintype char(10),
   stat_desc char(11),
   type_desc char(30),
   tmp_pname like coverage_st.part_name,
   SQLStr1 char(1536),
   SQLStr2 char(1536)

call ReadCmdLn( "Activity", 4 )
call ProcCmdLn( "Activity" )
call Header(30, IRec.i_id, BRec.b_id, 0)

let SQLStr1 = "select a.*, b.part_name from ", CtlRec.act_init_tab clipped, " a, coverage_st b where a.ceid='", CLRec.CEID clipped, "' and a.ceid=b.ceid "
let SQLStr2 = "select b.* from ", CtlRec.act_tab clipped, " b where b.ceid='", CLRec.CEID clipped, "' ",
              "order by b.act_st_dt "

#display SQLStr
prepare FCID from SQLStr1
declare FCCurs cursor for FCID

display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'> ACTIVITY </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, "</span></em></div>"
display "<p>"

#display "<FORM ID='fcast_upd' ACTION='/cgi-bin/fcastUpd", BRec.b_id clipped, ".ksh' method='post'>"
#display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=950><br>"
#display "This action will update your Forecast.<br>"

## header
display "<h2>Storage Activity Initiatives</h2>"
display "<table>"

let i=1
let rowcnt=0
foreach FCCurs into ActInitRec.*, tmp_pname
   display 
           "<tr>",
           "<th class='leftText'>CEID</th><th class='leftText'>Partner Name</th></tr>"
   display "<tr><td>",ActInitRec.ceid clipped, "</td><td>", tmp_pname clipped, "</td></tr>" 
   display "<tr></tr>"
   display 
           "<tr>",
           "<th class='leftText' style='width: 300'>BP Initiative #1</th>",
           "<th class='leftText' style='width: 300'>BP Initiative #2</th>",
           "<th class='leftText' style='width: 300'>BP Initiative #3</th></tr>"

   display "<tr><td>", ActInitRec.bp_init1 clipped, "</td>",
           "<td>", ActInitRec.bp_init2 clipped, "</td>",
           "<td>", ActInitRec.bp_init3 clipped, "</td></tr>"
   display "<tr></tr>"
   display 
           "<tr>",
           "<th class='leftText' style='width: 300'>Storage Initiative #1</th>",
           "<th class='leftText' style='width: 300'>ST Initiative #2</th>",
           "<th class='leftText' style='width: 300'>ST Initiative #3</th></tr>"
   display "<tr><td>", ActInitRec.st_init1 clipped, "</td>",
           "<td>", ActInitRec.st_init2 clipped, "</td>",
           "<td>", ActInitRec.st_init3 clipped, "</td></tr>"

#display SQLStr2
   prepare FC2ID from SQLStr2
   declare FC2Curs cursor for FC2ID
   display "<tr></tr>"
   display 
           "<tr><table><tr>",
           "<th class='leftText'>Activity Name</th>",
           "<th class='leftText'>Activity Description</th>",
           "<th class='leftText'>Activity Type</th>",
           "<th class='leftText'>Associated Initiative</th>",
           "<th class='leftText'>Status Name</th>",
           "<th class='leftText'>Revenue ($k)</th>",
           "<th class='leftText' style='width: 75'>Start Date</th>",
           "<th class='leftText' style='width: 75'>End Date</th>",
           "<th class='leftText' style='width: 150'>IBM Owner</th>",
           "<th class='leftText' style='width: 150'>BP Owner</th><tr>"

   foreach FC2Curs into ActRec.*
      case ActRec.act_code
         when "D"
            let type_desc="Ecosystem Development"
         when "E"
            let type_desc="Enablement"
         when "M"
            let type_desc="Marketing"
         when "O"
            let type_desc="Opportunity Identification"
         when "P"
            let type_desc="Deal Progression"

      end case

      case ActRec.act_stat
         when "S"
            let stat_desc="Started"
         when "I"
            let stat_desc="In-Process"
         when "C"
            let stat_desc="Completed"
      end case
      display "<tr><td>",ActRec.act_name clipped, "</td>", 
              "<td>",ActRec.act_desc clipped, "</td>", 
              "<td>",type_desc clipped, "</td>", 
              "<td>",ActRec.act_init clipped, "</td>", 
              "<td>",stat_desc clipped, "</td>", 
              "<td>",ActRec.act_rev clipped, "</td>", 
              "<td>",ActRec.act_st_dt clipped, "</td>", 
              "<td>",ActRec.act_ed_dt clipped, "</td>", 
              "<td>",ActRec.act_own_ibm clipped, "</td>", 
              "<td>",ActRec.act_own_bp clipped, "</td></tr>"
   end foreach

   display "</tr></table>"  #inner


end foreach
let cnt = i-1

#call AddRow(SSRname) returning FcastRec.*
#call DispRecV2(FcastRec.*)

display "</table>"  #outer
#display "<INPUT TYPE=submit VALUE='Submit'>"
#display "</FORM>"
display "<p>"
display "<td><FORM ID='st_act' ACTION='/cgi-bin/fcastDetails", BRec.b_id clipped, ".ksh' method='post' target='_blank'>"
display "<INPUT NAME='id' TYPE=hidden READONLY VALUE=0><br>"
display "<INPUT NAME='ssr' TYPE=hidden READONLY VALUE='", fcname clipped, "'><br>"
display "</FORM></td>"
#display "<td><FORM ID='fcast_exp' ACTION='/cgi-bin/fcastExport", BRec.b_id clipped, ".ksh' method='post' target='_blank'>"
#display "<INPUT NAME='ssr' TYPE=hidden READONLY VALUE='", fcname clipped, "'><br>"
#display "<INPUT TYPE=submit VALUE='Export'>"
#display "</FORM></td>"
#display "Summary:<p>"

end main

function DispRecV2(FcastRec)
define
   FcastRec record like fcast_au.*

   if( rowcnt mod 2 = 0 )then
      display "<tr style='background-color:#", c1 clipped, "'>"
   else
      display "<tr style='background-color:#", c2 clipped, "'>"
   end if
   display "</tr>"

end function  #DispRecV2

