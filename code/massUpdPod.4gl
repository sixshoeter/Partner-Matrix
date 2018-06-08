##
## June     08, 2016  John M. Shoemaker, jshoe@us.ibm.com - created #171
## January  17, 2017  John M. Shoemaker, remove dependancy on tbptv, #193


globals "globals.4gl"

main
define
   SQLStr char(512),
   uSQLStr char(512),
   tceid like coverage_au.ceid,
   tpart_name like coverage_au.part_name,
   tp_id like pod.pod

call ReadCmdLn("massUpdPod", 3)
call ProcCmdLn("massUpdPod")

let SQLStr = "select unique a.ceid, a.part_name, b.pod from ", cov_tab clipped, " a, pod b where a.ceid = b.ceid and (a.pod != b.pod or a.pod is null) order by a.part_name"
prepare MUV1 from SQLStr
declare MUV1Curs cursor for MUV1

begin work;
foreach MUV1Curs into tceid, tpart_name, tp_id
   display tceid, tpart_name, tp_id
   let uSQLStr = "update ", cov_tab clipped, " set pod='", tp_id clipped, "', updtime=current where ceid='", tceid clipped, "'"
   prepare MUV2 from uSQLStr
   execute MUV2

#   display uSQLStr clipped
end foreach

commit work;


end main
