
### August 19, 2015 - John M. Shoemaker, create, task #120

globals "globals.4gl"

define
   TasksRec record like tasks.*

main

define
   i, cnt smallint,
   statusStr char(20),
   SQLStr char(512),
   tmpStatus like tasks.task_status,
   TaskOrdRec record like task_ord.*

call ReadCmdLn("tasks", 2)
#call ProcCmdLn("tasks")
call Header(8, IRec.i_id, BRec.b_id, 0)

display " "

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", "Partner Matrix Change Control Board Requests", "</span></em></div>"
display "<p>"


display "<table align='center' border='1' dir='ltr' height='376'>"
display "<tbody>"


let SQLStr = "select unique a.* from task_ord a order by a.task_ord, a.task_status"
prepare TRUSID from SQLStr
declare TRUSCurs cursor for TRUSID
foreach TRUSCurs into TaskOrdRec.*

let SQLStr = "select count(*) from tasks a where a.task_status = '", TaskOrdRec.task_status clipped, "' "
prepare TRCID from SQLStr
execute TRCID into cnt

let SQLStr = "select a.* from tasks a where a.task_status = '", TaskOrdRec.task_status clipped, "' order by a.task_status, a.task_num"
prepare TRID from SQLStr
declare TRCurs cursor for TRID

   case TaskOrdRec.task_status
      when "C"
         let statusStr = "Closed"
      when "D"
         let statusStr = "Denied"
      when "H"
         let statusStr = "Hold"
      when "O"
         let statusStr = "Open"
      when "R"
         let statusStr = "For-Review"
      when "N"
         let statusStr = "Review-NEXT"
      when "X"
         let statusStr = "Cancelled"
   end case

display "<tr><td colspan='100' style='text-align: center; background-color: 12A0A0; width: 421px; vertical-align: middle'><a href='javascript:;' onClick=togglerows('", statusStr clipped, "');>", "<span style='font-size: 22px'>", statusStr clipped, "</span></a><span style='font-size: 12px'>  ", cnt using "##&", " records (Click to expand)</span>"
display "<tr id='", statusStr clipped, "' style='display:none'>"
display "<td><table border='1'>"

display "<tr>",
      "<th>", "Task #", "</th>",
      "<th>", "Status", "</th>",
      "<th>", "Created", "</th>",
      "<th>", "Closed", "</th>",
      "<th>", "Requestor", "</th>",
      "<th>", "Title", "</th>",
      "<th>", "Description", "</th>",
      "<th>", "Results", "</th>",
      "</tr>"
display "<tr><td>"

foreach TRCurs into TasksRec.*
#display TasksRec.task_num, "<br/>"

   display "<tr>",
      "<td>", TasksRec.task_num, "</td>",
      "<td>", statusStr clipped, "</td>",
      "<td>", TasksRec.task_odt, "</td>",
      "<td>", TasksRec.task_cdt, "</td>",
      "<td>", TasksRec.task_requestor clipped, "</td>",
      "<td>", TasksRec.task_title clipped, "</td>",
      "<td>", TasksRec.task_desc clipped, "</td>",
      "<td>", TasksRec.task_result clipped, "</td>",
      "</tr>"

end foreach
display "</td></tr>"
display "</table>"


end foreach
display "</tbody>"
display "</table>"

display "</div>"

display "</tbody>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

