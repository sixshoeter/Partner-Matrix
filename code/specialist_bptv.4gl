
database partners_na

main
define
   SHRec record like tbptv_history.*,
   SRec record like tbptv.*,
   cnt integer,
   SQLStr char(1024)

let SQLStr = " ",
"select a.ceid, a.ctp1 from coverage_au a where ctp1 is not null and ctp1 != ' ' union ",
"select a.ceid, a.ctp2 from coverage_au a where ctp2 is not null and ctp2 != ' ' union ",
"select a.ceid, a.ctp3 from coverage_au a where ctp3 is not null and ctp3 != ' ' union ",
"select a.ceid, a.ctp4 from coverage_au a where ctp4 is not null and ctp4 != ' ' union ",
"select a.ceid, a.ctp5 from coverage_au a where ctp5 is not null and ctp5 != ' ' ",
"into temp t1;"
prepare SC1 from SQLStr
execute SC1

let SQLStr = "select a.* from tbptv_history a, svp b where q_year=2015 and q_qtr=4 and ",
             "rag=b.bptv_name and b.s_brand='EM'"
prepare SC2 from SQLStr
declare SC2Curs cursor for SC2

let cnt = 0
foreach SC2Curs into SHRec.*
   if( SHRec.bptv_01 is not NULL)then let cnt = cnt + SHRec.bptv_01 end if
end foreach

display "History ECM BPTV Summary: ", cnt


let SQLStr = "select a.* from tbptv a, svp b where rag=b.bptv_name and b.s_brand='EM'"
prepare SC3 from SQLStr
declare SC3Curs cursor for SC3

let cnt = 0
foreach SC3Curs into SRec.*
   if( SRec.bptv_01 is not NULL)then let cnt = cnt + SRec.bptv_01 end if
end foreach

display "Current ECM BPTV Summary: ", cnt

################################################

let SQLStr = "select a.* from tbptv_history a, svp b where q_year=2015 and q_qtr=4 and ",
             "rag=b.bptv_name and b.s_brand='BA'"
prepare SCHba from SQLStr
declare SCHbaCurs cursor for SCHba

let cnt = 0
foreach SCHbaCurs into SHRec.*
   if( SHRec.bptv_01 is not NULL)then let cnt = cnt + SHRec.bptv_01 end if
end foreach

display "History BA BPTV Summary: ", cnt


let SQLStr = "select a.* from tbptv a, svp b where rag=b.bptv_name and b.s_brand='BA'"
prepare SCba from SQLStr
declare SCbaCurs cursor for SCba

let cnt = 0
foreach SCbaCurs into SRec.*
   if( SRec.bptv_01 is not NULL)then let cnt = cnt + SRec.bptv_01 end if
end foreach

display "Current BA BPTV Summary: ", cnt

################################################
let SQLStr = "select a.* from tbptv_history a, svp b where q_year=2015 and q_qtr=4 and ",
             "rag=b.bptv_name and b.s_brand='IM'"
prepare SCHim from SQLStr
declare SCHimCurs cursor for SCHim

let cnt = 0
foreach SCHimCurs into SHRec.*
   if( SHRec.bptv_01 is not NULL)then let cnt = cnt + SHRec.bptv_01 end if
end foreach

display "History IM BPTV Summary: ", cnt


let SQLStr = "select a.* from tbptv a, svp b where rag=b.bptv_name and b.s_brand='IM'"
prepare SCim from SQLStr
declare SCimCurs cursor for SCim

let cnt = 0
foreach SCimCurs into SRec.*
   if( SRec.bptv_01 is not NULL)then let cnt = cnt + SRec.bptv_01 end if
end foreach

display "Current IM BPTV Summary: ", cnt
################################################
end main


