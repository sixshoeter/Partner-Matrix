database partners_na

main
define
   SHRec record like skills_history.*,
   SRec record like skills_em.*,
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

let SQLStr = "select a.* from skills_history a where q_year=2015 and q_qtr=4 and q_brand='EM'"
prepare SC2 from SQLStr
declare SC2Curs cursor for SC2

let cnt = 0
foreach SC2Curs into SHRec.*
   if( SHRec.skill_01 is not NULL)then let cnt = cnt + SHRec.skill_01 end if
   if( SHRec.skill_02 is not NULL)then let cnt = cnt + SHRec.skill_02 end if
   if( SHRec.skill_03 is not NULL)then let cnt = cnt + SHRec.skill_03 end if
   if( SHRec.skill_04 is not NULL)then let cnt = cnt + SHRec.skill_04 end if
   if( SHRec.skill_05 is not NULL)then let cnt = cnt + SHRec.skill_05 end if
   if( SHRec.skill_06 is not NULL)then let cnt = cnt + SHRec.skill_06 end if
   if( SHRec.skill_07 is not NULL)then let cnt = cnt + SHRec.skill_07 end if
   if( SHRec.skill_08 is not NULL)then let cnt = cnt + SHRec.skill_08 end if
   if( SHRec.skill_09 is not NULL)then let cnt = cnt + SHRec.skill_09 end if
   if( SHRec.skill_10 is not NULL)then let cnt = cnt + SHRec.skill_10 end if
   if( SHRec.skill_11 is not NULL)then let cnt = cnt + SHRec.skill_11 end if
   if( SHRec.skill_12 is not NULL)then let cnt = cnt + SHRec.skill_12 end if
   if( SHRec.skill_13 is not NULL)then let cnt = cnt + SHRec.skill_13 end if
   if( SHRec.skill_14 is not NULL)then let cnt = cnt + SHRec.skill_14 end if
   if( SHRec.skill_15 is not NULL)then let cnt = cnt + SHRec.skill_15 end if
   if( SHRec.skill_16 is not NULL)then let cnt = cnt + SHRec.skill_16 end if
   if( SHRec.skill_17 is not NULL)then let cnt = cnt + SHRec.skill_17 end if
   if( SHRec.skill_18 is not NULL)then let cnt = cnt + SHRec.skill_18 end if
   if( SHRec.skill_19 is not NULL)then let cnt = cnt + SHRec.skill_19 end if
   if( SHRec.skill_20 is not NULL)then let cnt = cnt + SHRec.skill_20 end if
   if( SHRec.skill_21 is not NULL)then let cnt = cnt + SHRec.skill_21 end if
   if( SHRec.skill_22 is not NULL)then let cnt = cnt + SHRec.skill_22 end if
   if( SHRec.skill_23 is not NULL)then let cnt = cnt + SHRec.skill_23 end if
   if( SHRec.skill_24 is not NULL)then let cnt = cnt + SHRec.skill_24 end if
   if( SHRec.skill_25 is not NULL)then let cnt = cnt + SHRec.skill_25 end if
   if( SHRec.skill_26 is not NULL)then let cnt = cnt + SHRec.skill_26 end if
   if( SHRec.skill_27 is not NULL)then let cnt = cnt + SHRec.skill_27 end if
   if( SHRec.skill_28 is not NULL)then let cnt = cnt + SHRec.skill_28 end if
   if( SHRec.skill_29 is not NULL)then let cnt = cnt + SHRec.skill_29 end if
   if( SHRec.skill_30 is not NULL)then let cnt = cnt + SHRec.skill_30 end if
end foreach

display "History ECM Skill Summary: ", cnt


let SQLStr = "select a.* from skills_em a "
prepare SC3 from SQLStr
declare SC3Curs cursor for SC3

let cnt = 0
foreach SC3Curs into SRec.*
   if( SRec.skill_01 is not NULL)then let cnt = cnt + SRec.skill_01 end if
   if( SRec.skill_02 is not NULL)then let cnt = cnt + SRec.skill_02 end if
   if( SRec.skill_03 is not NULL)then let cnt = cnt + SRec.skill_03 end if
   if( SRec.skill_04 is not NULL)then let cnt = cnt + SRec.skill_04 end if
   if( SRec.skill_05 is not NULL)then let cnt = cnt + SRec.skill_05 end if
   if( SRec.skill_06 is not NULL)then let cnt = cnt + SRec.skill_06 end if
   if( SRec.skill_07 is not NULL)then let cnt = cnt + SRec.skill_07 end if
   if( SRec.skill_08 is not NULL)then let cnt = cnt + SRec.skill_08 end if
   if( SRec.skill_09 is not NULL)then let cnt = cnt + SRec.skill_09 end if
   if( SRec.skill_10 is not NULL)then let cnt = cnt + SRec.skill_10 end if
   if( SRec.skill_11 is not NULL)then let cnt = cnt + SRec.skill_11 end if
   if( SRec.skill_12 is not NULL)then let cnt = cnt + SRec.skill_12 end if
   if( SRec.skill_13 is not NULL)then let cnt = cnt + SRec.skill_13 end if
   if( SRec.skill_14 is not NULL)then let cnt = cnt + SRec.skill_14 end if
   if( SRec.skill_15 is not NULL)then let cnt = cnt + SRec.skill_15 end if
   if( SRec.skill_16 is not NULL)then let cnt = cnt + SRec.skill_16 end if
   if( SRec.skill_17 is not NULL)then let cnt = cnt + SRec.skill_17 end if
   if( SRec.skill_18 is not NULL)then let cnt = cnt + SRec.skill_18 end if
   if( SRec.skill_19 is not NULL)then let cnt = cnt + SRec.skill_19 end if
   if( SRec.skill_20 is not NULL)then let cnt = cnt + SRec.skill_20 end if
   if( SRec.skill_21 is not NULL)then let cnt = cnt + SRec.skill_21 end if
   if( SRec.skill_22 is not NULL)then let cnt = cnt + SRec.skill_22 end if
   if( SRec.skill_23 is not NULL)then let cnt = cnt + SRec.skill_23 end if
   if( SRec.skill_24 is not NULL)then let cnt = cnt + SRec.skill_24 end if
   if( SRec.skill_25 is not NULL)then let cnt = cnt + SRec.skill_25 end if
   if( SRec.skill_26 is not NULL)then let cnt = cnt + SRec.skill_26 end if
   if( SRec.skill_27 is not NULL)then let cnt = cnt + SRec.skill_27 end if
   if( SRec.skill_28 is not NULL)then let cnt = cnt + SRec.skill_28 end if
   if( SRec.skill_29 is not NULL)then let cnt = cnt + SRec.skill_29 end if
   if( SRec.skill_30 is not NULL)then let cnt = cnt + SRec.skill_30 end if
end foreach

display "Current ECM Skill Summary: ", cnt


let SQLStr = "select a.* from skills_history a where q_year=2015 and q_qtr=4 and q_brand='BA'"
prepare SCHba from SQLStr
declare SCHbaCurs cursor for SCHba

let cnt = 0
foreach SCHbaCurs into SHRec.*
   if( SHRec.skill_01 is not NULL)then let cnt = cnt + SHRec.skill_01 end if
   if( SHRec.skill_02 is not NULL)then let cnt = cnt + SHRec.skill_02 end if
   if( SHRec.skill_03 is not NULL)then let cnt = cnt + SHRec.skill_03 end if
   if( SHRec.skill_04 is not NULL)then let cnt = cnt + SHRec.skill_04 end if
   if( SHRec.skill_05 is not NULL)then let cnt = cnt + SHRec.skill_05 end if
   if( SHRec.skill_06 is not NULL)then let cnt = cnt + SHRec.skill_06 end if
   if( SHRec.skill_07 is not NULL)then let cnt = cnt + SHRec.skill_07 end if
   if( SHRec.skill_08 is not NULL)then let cnt = cnt + SHRec.skill_08 end if
   if( SHRec.skill_09 is not NULL)then let cnt = cnt + SHRec.skill_09 end if
   if( SHRec.skill_10 is not NULL)then let cnt = cnt + SHRec.skill_10 end if
   if( SHRec.skill_11 is not NULL)then let cnt = cnt + SHRec.skill_11 end if
   if( SHRec.skill_12 is not NULL)then let cnt = cnt + SHRec.skill_12 end if
   if( SHRec.skill_13 is not NULL)then let cnt = cnt + SHRec.skill_13 end if
   if( SHRec.skill_14 is not NULL)then let cnt = cnt + SHRec.skill_14 end if
   if( SHRec.skill_15 is not NULL)then let cnt = cnt + SHRec.skill_15 end if
   if( SHRec.skill_16 is not NULL)then let cnt = cnt + SHRec.skill_16 end if
   if( SHRec.skill_17 is not NULL)then let cnt = cnt + SHRec.skill_17 end if
   if( SHRec.skill_18 is not NULL)then let cnt = cnt + SHRec.skill_18 end if
   if( SHRec.skill_19 is not NULL)then let cnt = cnt + SHRec.skill_19 end if
   if( SHRec.skill_20 is not NULL)then let cnt = cnt + SHRec.skill_20 end if
   if( SHRec.skill_21 is not NULL)then let cnt = cnt + SHRec.skill_21 end if
   if( SHRec.skill_22 is not NULL)then let cnt = cnt + SHRec.skill_22 end if
   if( SHRec.skill_23 is not NULL)then let cnt = cnt + SHRec.skill_23 end if
   if( SHRec.skill_24 is not NULL)then let cnt = cnt + SHRec.skill_24 end if
   if( SHRec.skill_25 is not NULL)then let cnt = cnt + SHRec.skill_25 end if
   if( SHRec.skill_26 is not NULL)then let cnt = cnt + SHRec.skill_26 end if
   if( SHRec.skill_27 is not NULL)then let cnt = cnt + SHRec.skill_27 end if
   if( SHRec.skill_28 is not NULL)then let cnt = cnt + SHRec.skill_28 end if
   if( SHRec.skill_29 is not NULL)then let cnt = cnt + SHRec.skill_29 end if
   if( SHRec.skill_30 is not NULL)then let cnt = cnt + SHRec.skill_30 end if
end foreach

display "History BA Skill Summary: ", cnt


let SQLStr = "select a.* from skills_ba a "
prepare SCba from SQLStr
declare SCbaCurs cursor for SCba

let cnt = 0
foreach SCbaCurs into SRec.*
   if( SRec.skill_01 is not NULL)then let cnt = cnt + SRec.skill_01 end if
   if( SRec.skill_02 is not NULL)then let cnt = cnt + SRec.skill_02 end if
   if( SRec.skill_03 is not NULL)then let cnt = cnt + SRec.skill_03 end if
   if( SRec.skill_04 is not NULL)then let cnt = cnt + SRec.skill_04 end if
   if( SRec.skill_05 is not NULL)then let cnt = cnt + SRec.skill_05 end if
   if( SRec.skill_06 is not NULL)then let cnt = cnt + SRec.skill_06 end if
   if( SRec.skill_07 is not NULL)then let cnt = cnt + SRec.skill_07 end if
   if( SRec.skill_08 is not NULL)then let cnt = cnt + SRec.skill_08 end if
   if( SRec.skill_09 is not NULL)then let cnt = cnt + SRec.skill_09 end if
   if( SRec.skill_10 is not NULL)then let cnt = cnt + SRec.skill_10 end if
   if( SRec.skill_11 is not NULL)then let cnt = cnt + SRec.skill_11 end if
   if( SRec.skill_12 is not NULL)then let cnt = cnt + SRec.skill_12 end if
   if( SRec.skill_13 is not NULL)then let cnt = cnt + SRec.skill_13 end if
   if( SRec.skill_14 is not NULL)then let cnt = cnt + SRec.skill_14 end if
   if( SRec.skill_15 is not NULL)then let cnt = cnt + SRec.skill_15 end if
   if( SRec.skill_16 is not NULL)then let cnt = cnt + SRec.skill_16 end if
   if( SRec.skill_17 is not NULL)then let cnt = cnt + SRec.skill_17 end if
   if( SRec.skill_18 is not NULL)then let cnt = cnt + SRec.skill_18 end if
   if( SRec.skill_19 is not NULL)then let cnt = cnt + SRec.skill_19 end if
   if( SRec.skill_20 is not NULL)then let cnt = cnt + SRec.skill_20 end if
   if( SRec.skill_21 is not NULL)then let cnt = cnt + SRec.skill_21 end if
   if( SRec.skill_22 is not NULL)then let cnt = cnt + SRec.skill_22 end if
   if( SRec.skill_23 is not NULL)then let cnt = cnt + SRec.skill_23 end if
   if( SRec.skill_24 is not NULL)then let cnt = cnt + SRec.skill_24 end if
   if( SRec.skill_25 is not NULL)then let cnt = cnt + SRec.skill_25 end if
   if( SRec.skill_26 is not NULL)then let cnt = cnt + SRec.skill_26 end if
   if( SRec.skill_27 is not NULL)then let cnt = cnt + SRec.skill_27 end if
   if( SRec.skill_28 is not NULL)then let cnt = cnt + SRec.skill_28 end if
   if( SRec.skill_29 is not NULL)then let cnt = cnt + SRec.skill_29 end if
   if( SRec.skill_30 is not NULL)then let cnt = cnt + SRec.skill_30 end if
end foreach

display "Current BA Skill Summary: ", cnt

let SQLStr = "select a.* from skills_history a where q_year=2015 and q_qtr=4 and q_brand='IM'"
prepare SCHim from SQLStr
declare SCHimCurs cursor for SCHim

let cnt = 0
foreach SCHimCurs into SHRec.*
   if( SHRec.skill_01 is not NULL)then let cnt = cnt + SHRec.skill_01 end if
   if( SHRec.skill_02 is not NULL)then let cnt = cnt + SHRec.skill_02 end if
   if( SHRec.skill_03 is not NULL)then let cnt = cnt + SHRec.skill_03 end if
   if( SHRec.skill_04 is not NULL)then let cnt = cnt + SHRec.skill_04 end if
   if( SHRec.skill_05 is not NULL)then let cnt = cnt + SHRec.skill_05 end if
   if( SHRec.skill_06 is not NULL)then let cnt = cnt + SHRec.skill_06 end if
   if( SHRec.skill_07 is not NULL)then let cnt = cnt + SHRec.skill_07 end if
   if( SHRec.skill_08 is not NULL)then let cnt = cnt + SHRec.skill_08 end if
   if( SHRec.skill_09 is not NULL)then let cnt = cnt + SHRec.skill_09 end if
   if( SHRec.skill_10 is not NULL)then let cnt = cnt + SHRec.skill_10 end if
   if( SHRec.skill_11 is not NULL)then let cnt = cnt + SHRec.skill_11 end if
   if( SHRec.skill_12 is not NULL)then let cnt = cnt + SHRec.skill_12 end if
   if( SHRec.skill_13 is not NULL)then let cnt = cnt + SHRec.skill_13 end if
   if( SHRec.skill_14 is not NULL)then let cnt = cnt + SHRec.skill_14 end if
   if( SHRec.skill_15 is not NULL)then let cnt = cnt + SHRec.skill_15 end if
   if( SHRec.skill_16 is not NULL)then let cnt = cnt + SHRec.skill_16 end if
   if( SHRec.skill_17 is not NULL)then let cnt = cnt + SHRec.skill_17 end if
   if( SHRec.skill_18 is not NULL)then let cnt = cnt + SHRec.skill_18 end if
   if( SHRec.skill_19 is not NULL)then let cnt = cnt + SHRec.skill_19 end if
   if( SHRec.skill_20 is not NULL)then let cnt = cnt + SHRec.skill_20 end if
   if( SHRec.skill_21 is not NULL)then let cnt = cnt + SHRec.skill_21 end if
   if( SHRec.skill_22 is not NULL)then let cnt = cnt + SHRec.skill_22 end if
   if( SHRec.skill_23 is not NULL)then let cnt = cnt + SHRec.skill_23 end if
   if( SHRec.skill_24 is not NULL)then let cnt = cnt + SHRec.skill_24 end if
   if( SHRec.skill_25 is not NULL)then let cnt = cnt + SHRec.skill_25 end if
   if( SHRec.skill_26 is not NULL)then let cnt = cnt + SHRec.skill_26 end if
   if( SHRec.skill_27 is not NULL)then let cnt = cnt + SHRec.skill_27 end if
   if( SHRec.skill_28 is not NULL)then let cnt = cnt + SHRec.skill_28 end if
   if( SHRec.skill_29 is not NULL)then let cnt = cnt + SHRec.skill_29 end if
   if( SHRec.skill_30 is not NULL)then let cnt = cnt + SHRec.skill_30 end if
end foreach

display "History IM Skill Summary: ", cnt


let SQLStr = "select a.* from skills_im a "
prepare SCim from SQLStr
declare SCimCurs cursor for SCim

let cnt = 0
foreach SCimCurs into SRec.*
   if( SRec.skill_01 is not NULL)then let cnt = cnt + SRec.skill_01 end if
   if( SRec.skill_02 is not NULL)then let cnt = cnt + SRec.skill_02 end if
   if( SRec.skill_03 is not NULL)then let cnt = cnt + SRec.skill_03 end if
   if( SRec.skill_04 is not NULL)then let cnt = cnt + SRec.skill_04 end if
   if( SRec.skill_05 is not NULL)then let cnt = cnt + SRec.skill_05 end if
   if( SRec.skill_06 is not NULL)then let cnt = cnt + SRec.skill_06 end if
   if( SRec.skill_07 is not NULL)then let cnt = cnt + SRec.skill_07 end if
   if( SRec.skill_08 is not NULL)then let cnt = cnt + SRec.skill_08 end if
   if( SRec.skill_09 is not NULL)then let cnt = cnt + SRec.skill_09 end if
   if( SRec.skill_10 is not NULL)then let cnt = cnt + SRec.skill_10 end if
   if( SRec.skill_11 is not NULL)then let cnt = cnt + SRec.skill_11 end if
   if( SRec.skill_12 is not NULL)then let cnt = cnt + SRec.skill_12 end if
   if( SRec.skill_13 is not NULL)then let cnt = cnt + SRec.skill_13 end if
   if( SRec.skill_14 is not NULL)then let cnt = cnt + SRec.skill_14 end if
   if( SRec.skill_15 is not NULL)then let cnt = cnt + SRec.skill_15 end if
   if( SRec.skill_16 is not NULL)then let cnt = cnt + SRec.skill_16 end if
   if( SRec.skill_17 is not NULL)then let cnt = cnt + SRec.skill_17 end if
   if( SRec.skill_18 is not NULL)then let cnt = cnt + SRec.skill_18 end if
   if( SRec.skill_19 is not NULL)then let cnt = cnt + SRec.skill_19 end if
   if( SRec.skill_20 is not NULL)then let cnt = cnt + SRec.skill_20 end if
   if( SRec.skill_21 is not NULL)then let cnt = cnt + SRec.skill_21 end if
   if( SRec.skill_22 is not NULL)then let cnt = cnt + SRec.skill_22 end if
   if( SRec.skill_23 is not NULL)then let cnt = cnt + SRec.skill_23 end if
   if( SRec.skill_24 is not NULL)then let cnt = cnt + SRec.skill_24 end if
   if( SRec.skill_25 is not NULL)then let cnt = cnt + SRec.skill_25 end if
   if( SRec.skill_26 is not NULL)then let cnt = cnt + SRec.skill_26 end if
   if( SRec.skill_27 is not NULL)then let cnt = cnt + SRec.skill_27 end if
   if( SRec.skill_28 is not NULL)then let cnt = cnt + SRec.skill_28 end if
   if( SRec.skill_29 is not NULL)then let cnt = cnt + SRec.skill_29 end if
   if( SRec.skill_30 is not NULL)then let cnt = cnt + SRec.skill_30 end if
end foreach

display "Current IM Skill Summary: ", cnt

end main


