# June   09, 2015  John M. Shoemaker jshoe@us.ibm.com, created
## PREV QUARTER IS HARD CODED - SEE FUNCTION TO CHANGE

globals "globals.4gl"

MAIN
define
   tpart_name like coverage_au.part_name,
   tctp like coverage_au.ctp1,
   oldRec record like skills_history.*,
   newRec record like skills_ws.*,
   sqlStr char(2014),
   cnt int,
   cnt2 int,
   ttl1, ttl2 smallint,
   pastCtp like coverage_au.ctp1,
   max_dt, max_DtH date,
   qtrDate char(6),
   searchYr, searchQtr smallint,
   DELIMIT char(1)

call ReadCmdLn("home", 4)
call ProcCmdLn("home")
let DELIMIT=","

# determine current quarter based on tbptv dates
let SQLStr="select max(revdt) from tbptv"
prepare GMRDT from SQLStr
execute GMRDT into max_dt
let qtrDate = prevQuarter(max_dt)
let searchYr=qtrDate[1,4]
let searchQtr=qtrDate[6,6]
#display "max_dt: ", max_dt
#display "qtrDate: ", qtrDate
#display "searchYr: ", searchYr
#display "searchQtr:", searchQtr

# determine max revdt based on prev quarter 
let SQLStr="select max(revdt) from tbptv_history where q_year=", searchYr, " and q_qtr= ", searchQtr
prepare GMRDTH from SQLStr
execute GMRDTH into max_dtH
#display "max_dtH: ", max_dtH

case BRec.b_id
   when 'AU'
      let sqlStr = "select a.part_name, a.ctp1, b.*, c.* from coverage_au a, outer skills_history b, skills_im c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='IM' and a.ceid=c.ceid ",
                   " union select a.part_name, a.ctp2, b.*, c.* from coverage_au a, outer skills_history b, skills_em c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='EM' and a.ceid=c.ceid ",
                   " union select a.part_name, a.ctp3, b.*, c.* from coverage_au a, outer skills_history b, skills_ba c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='BA' and a.ceid=c.ceid order by 2,1"

   when 'SU'
      let sqlStr = "select a.part_name, a.ctp1, b.*, c.* from coverage_su a, outer skills_history b, skills_s1 c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='S1' and a.ceid=c.ceid ",
                   " union select a.part_name, a.ctp2, b.*, c.* from coverage_su a, outer skills_history b, skills_s2 c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='S2' and a.ceid=c.ceid ",
                   " union select a.part_name, a.ctp3, b.*, c.* from coverage_su a, outer skills_history b, skills_s3 c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='S3' and a.ceid=c.ceid ",
                   " union select a.part_name, a.ctp4, b.*, c.* from coverage_su a, outer skills_history b, skills_s4 c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='S4' and a.ceid=c.ceid ",
                   " union select a.part_name, a.ctp5, b.*, c.* from coverage_su a, outer skills_history b, skills_s5 c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='S5' and a.ceid=c.ceid order by 2, 1"

   when 'CU'
      let sqlStr = "select a.part_name, a.ctp1, b.*, c.* from coverage_cu a, outer skills_history b, skills_cu c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='C1' and a.ceid=c.ceid order by 1,2 "
   when 'BU'
      let sqlStr = "select a.part_name, a.ctp1, b.*, c.* from coverage_bu a, outer skills_history b, skills_im c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='B1' and a.ceid=c.ceid ",
                   " union select a.part_name, a.ctp2, b.*, c.* from coverage_bu a, outer skills_history b, skills_em c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='B2' and a.ceid=c.ceid ",
                   " union select a.part_name, a.ctp3, b.*, c.* from coverage_bu a, outer skills_history b, skills_ba c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='B3' and a.ceid=c.ceid ",
                   " union select a.part_name, a.ctp4, b.*, c.* from coverage_bu a, outer skills_history b, skills_ba c where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='B4' and a.ceid=c.ceid order by 2,1"

end case

#display SQLStr

prepare ID1 from sqlStr
declare ID1Curs cursor for ID1
   let ttl1 = 0
   let ttl2 = 0
   let pastCtp = "none"

   display 
           "TSS", DELIMIT,
           "SKILLS-", max_dtH, DELIMIT,
           "SKILLS-", max_dt, DELIMIT

foreach ID1Curs into tpart_name, tctp, oldRec.*, newRec.*
#if( tctp='Ben Mayer' )then
#   display tpart_name, " old: ", oldRec.*, " new: ", newRec.*
#end if
   let cnt = 0
   let cnt2 = 0
   if( tctp != pastCtp )then
#   display "TOTAL: ", pastCtp, ttl1, ttl2
    if( pastCtp is not NULL and pastCtp != 'none' and pastCtp != ' ')then
       display '"', pastCtp clipped, '"', DELIMIT, ttl1, DELIMIT, ttl2, DELIMIT
    end if

    let ttl1 = 0
    let ttl2 = 0
   end if
   if( oldRec.skill_01 is not null )then let cnt = cnt + oldRec.skill_01 end if
   if( oldRec.skill_02 is not null )then let cnt = cnt + oldRec.skill_02 end if
   if( oldRec.skill_03 is not null )then let cnt = cnt + oldRec.skill_03 end if
   if( oldRec.skill_04 is not null )then let cnt = cnt + oldRec.skill_04 end if
   if( oldRec.skill_05 is not null )then let cnt = cnt + oldRec.skill_05 end if
   if( oldRec.skill_06 is not null )then let cnt = cnt + oldRec.skill_06 end if
   if( oldRec.skill_07 is not null )then let cnt = cnt + oldRec.skill_07 end if
   if( oldRec.skill_08 is not null )then let cnt = cnt + oldRec.skill_08 end if
   if( oldRec.skill_09 is not null )then let cnt = cnt + oldRec.skill_09 end if
   if( oldRec.skill_10 is not null )then let cnt = cnt + oldRec.skill_10 end if
   if( oldRec.skill_11 is not null )then let cnt = cnt + oldRec.skill_11 end if
   if( oldRec.skill_12 is not null )then let cnt = cnt + oldRec.skill_12 end if
   if( oldRec.skill_13 is not null )then let cnt = cnt + oldRec.skill_13 end if
   if( oldRec.skill_14 is not null )then let cnt = cnt + oldRec.skill_14 end if
   if( oldRec.skill_15 is not null )then let cnt = cnt + oldRec.skill_15 end if
   if( oldRec.skill_16 is not null )then let cnt = cnt + oldRec.skill_16 end if
   if( oldRec.skill_17 is not null )then let cnt = cnt + oldRec.skill_17 end if
   if( oldRec.skill_18 is not null )then let cnt = cnt + oldRec.skill_18 end if
   if( oldRec.skill_19 is not null )then let cnt = cnt + oldRec.skill_19 end if
   if( oldRec.skill_20 is not null )then let cnt = cnt + oldRec.skill_20 end if
   if( oldRec.skill_21 is not null )then let cnt = cnt + oldRec.skill_21 end if
   if( oldRec.skill_22 is not null )then let cnt = cnt + oldRec.skill_22 end if
   if( oldRec.skill_23 is not null )then let cnt = cnt + oldRec.skill_23 end if
   if( oldRec.skill_24 is not null )then let cnt = cnt + oldRec.skill_24 end if
   if( oldRec.skill_25 is not null )then let cnt = cnt + oldRec.skill_25 end if
   if( oldRec.skill_26 is not null )then let cnt = cnt + oldRec.skill_26 end if
   if( oldRec.skill_27 is not null )then let cnt = cnt + oldRec.skill_27 end if
   if( oldRec.skill_28 is not null )then let cnt = cnt + oldRec.skill_28 end if
   if( oldRec.skill_29 is not null )then let cnt = cnt + oldRec.skill_29 end if
   if( oldRec.skill_30 is not null )then let cnt = cnt + oldRec.skill_30 end if

   if( newRec.skill_01 is not null )then let cnt2 = cnt2 + newRec.skill_01 end if
   if( newRec.skill_02 is not null )then let cnt2 = cnt2 + newRec.skill_02 end if
   if( newRec.skill_03 is not null )then let cnt2 = cnt2 + newRec.skill_03 end if
   if( newRec.skill_04 is not null )then let cnt2 = cnt2 + newRec.skill_04 end if
   if( newRec.skill_05 is not null )then let cnt2 = cnt2 + newRec.skill_05 end if
   if( newRec.skill_06 is not null )then let cnt2 = cnt2 + newRec.skill_06 end if
   if( newRec.skill_07 is not null )then let cnt2 = cnt2 + newRec.skill_07 end if
   if( newRec.skill_08 is not null )then let cnt2 = cnt2 + newRec.skill_08 end if
   if( newRec.skill_09 is not null )then let cnt2 = cnt2 + newRec.skill_09 end if
   if( newRec.skill_10 is not null )then let cnt2 = cnt2 + newRec.skill_10 end if
   if( newRec.skill_11 is not null )then let cnt2 = cnt2 + newRec.skill_11 end if
   if( newRec.skill_12 is not null )then let cnt2 = cnt2 + newRec.skill_12 end if
   if( newRec.skill_13 is not null )then let cnt2 = cnt2 + newRec.skill_13 end if
   if( newRec.skill_14 is not null )then let cnt2 = cnt2 + newRec.skill_14 end if
   if( newRec.skill_15 is not null )then let cnt2 = cnt2 + newRec.skill_15 end if
   if( newRec.skill_16 is not null )then let cnt2 = cnt2 + newRec.skill_16 end if
   if( newRec.skill_17 is not null )then let cnt2 = cnt2 + newRec.skill_17 end if
   if( newRec.skill_18 is not null )then let cnt2 = cnt2 + newRec.skill_18 end if
   if( newRec.skill_19 is not null )then let cnt2 = cnt2 + newRec.skill_19 end if
   if( newRec.skill_20 is not null )then let cnt2 = cnt2 + newRec.skill_20 end if
   if( newRec.skill_21 is not null )then let cnt2 = cnt2 + newRec.skill_21 end if
   if( newRec.skill_22 is not null )then let cnt2 = cnt2 + newRec.skill_22 end if
   if( newRec.skill_23 is not null )then let cnt2 = cnt2 + newRec.skill_23 end if
   if( newRec.skill_24 is not null )then let cnt2 = cnt2 + newRec.skill_24 end if
   if( newRec.skill_25 is not null )then let cnt2 = cnt2 + newRec.skill_25 end if
   if( newRec.skill_26 is not null )then let cnt2 = cnt2 + newRec.skill_26 end if
   if( newRec.skill_27 is not null )then let cnt2 = cnt2 + newRec.skill_27 end if
   if( newRec.skill_28 is not null )then let cnt2 = cnt2 + newRec.skill_28 end if
   if( newRec.skill_29 is not null )then let cnt2 = cnt2 + newRec.skill_29 end if
   if( newRec.skill_30 is not null )then let cnt2 = cnt2 + newRec.skill_30 end if

   let ttl1 = ttl1 + cnt
   let ttl2 = ttl2 + cnt2
   let pastCtp = tctp
#   display tctp, cnt, cnt2, ttl1, ttl2
#   display tctp, ttl1, ttl2
end foreach
#   display "TOTAL: ", pastCtp, ttl1, ttl2
    display 
           '"', pastCtp clipped, '"', DELIMIT,
           ttl1, DELIMIT,
           ttl2, DELIMIT



END MAIN

function prevQuarter( in_date )
define
   in_date date,
   ret_qtr char(6),
   yr, mo, qtr smallint


let mo = month(in_date)
case 
   when mo=1 or mo=2 or mo=3
      let qtr = 4
      let yr = year(in_date)-1
   when mo=4 or mo=5 or mo=6
      let qtr = 1
      let yr = year(in_date)
   when mo=7 or mo=8 or mo=9
      let qtr = 2
      let yr = year(in_date)
   when mo=10 or mo=11 or mo=12
      let qtr = 3
      let yr = year(in_date)
end case
let ret_qtr = yr*100 + qtr
#let ret_qtr = (year(in_date)*100) + 1 + (month(in_date) - 1) / 3

#return ret_qtr

return "201601"

end function  #prevQuarter

