# June   11, 2015  John M. Shoemaker jshoe@us.ibm.com, created


globals "globals.4gl"

MAIN
define
   tceid like coverage_au.ceid,
   tpart_name like coverage_au.part_name,
   tb_ord like brands.b_ord,
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
      let sqlStr = "select a.ceid, a.part_name, d.b_ord, a.ctp1, b.*, c.* from coverage_au a, outer skills_history b, skills_im c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='IM' and a.ceid=c.ceid and d.b_id='IM' ",
                   " union select a.ceid, a.part_name, d.b_ord, a.ctp2, b.*, c.* from coverage_au a, outer skills_history b, skills_em c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='EM' and a.ceid=c.ceid and d.b_id='EM' ",
                   " union select a.ceid, a.part_name, d.b_ord, a.ctp3, b.*, c.* from coverage_au a, outer skills_history b, skills_ba c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='BA' and a.ceid=c.ceid and d.b_id='BA' order by 2,1"

   when 'SU'
      let sqlStr = "select a.ceid, a.part_name, d.b_ord, a.ctp1, b.*, c.* from coverage_su a, outer skills_history b, skills_s1 c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='S1' and a.ceid=c.ceid and d.b_id='S1' ",
                   " union select a.ceid, a.part_name, d.b_ord, a.ctp2, b.*, c.* from coverage_su a, outer skills_history b, skills_s2 c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='S2' and a.ceid=c.ceid and d.b_id='S2' ",
                   " union select a.ceid, a.part_name, d.b_ord, a.ctp3, b.*, c.* from coverage_su a, outer skills_history b, skills_s3 c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='S3' and a.ceid=c.ceid and d.b_id='S3' ",
                   " union select a.ceid, a.part_name, d.b_ord, a.ctp4, b.*, c.* from coverage_su a, outer skills_history b, skills_s4 c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='S4' and a.ceid=c.ceid and d.b_id='S4' ",
                   " union select a.ceid, a.part_name, d.b_ord, a.ctp5, b.*, c.* from coverage_su a, outer skills_history b, skills_s5 c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='S5' and a.ceid=c.ceid and d.b_id='S5' order by 2, 1"

   when 'CU'
      let sqlStr = "select a.ceid, a.part_name, d.b_ord, a.ctp1, b.*, c.* from coverage_cu a, outer skills_history b, skills_cu c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='CU' and a.ceid=c.ceid and d.b_id='C1' order by 1,2 "

   when 'BU'
      let sqlStr = "select a.ceid, a.part_name, d.b_ord, a.ctp1, b.*, c.* from coverage_bu a, outer skills_history b, skills_b1 c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='B1' and a.ceid=c.ceid and d.b_id='B1' ",
                   " union select a.ceid, a.part_name, d.b_ord, a.ctp2, b.*, c.* from coverage_bu a, outer skills_history b, skills_b2 c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='B2' and a.ceid=c.ceid and d.b_id='B2' ",
                   " union select a.ceid, a.part_name, d.b_ord, a.ctp3, b.*, c.* from coverage_bu a, outer skills_history b, skills_b3 c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='B3' and a.ceid=c.ceid and d.b_id='B3' ",
                   " union select a.ceid, a.part_name, d.b_ord, a.ctp4, b.*, c.* from coverage_bu a, outer skills_history b, skills_b4 c, brands d where a.ceid=b.ceid and b.q_year=", searchYr, " and b.q_qtr=", searchQtr, " and b.q_brand='B4' and a.ceid=c.ceid and d.b_id='B4' order by 2, 1"

end case

#display SQLStr clipped

prepare ID1 from sqlStr
declare ID1Curs cursor for ID1
   let ttl1 = 0
   let ttl2 = 0
   let pastCtp = "none"

   display 
           "CEID", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "TSS", DELIMIT,
           "PRODUCT", DELIMIT,
           "SKILLS-", max_dtH, DELIMIT,
           "SKILLS-", max_dt, DELIMIT

foreach ID1Curs into tceid, tpart_name, tb_ord, tctp, oldRec.*, newRec.*
   let cnt = 0
   let cnt2 = 0
#if( tctp is not NULL and tctp != " ")then
   if( OldRec.skill_01 is NULL )then let OldRec.skill_01 = 0  end if
   if( NewRec.skill_01 is NULL )then let NewRec.skill_01 = 0  end if
#   if( OldRec.skill_01 > 0 OR NewRec.skill_01 > 0 )then
   if( SkillArrU[tb_ord, 1].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 1].s_desc clipped, '"', DELIMIT, OldRec.skill_01 using "#&", DELIMIT, NewRec.skill_01 using "#&", DELIMIT
   end if
   if( OldRec.skill_02 is NULL )then let OldRec.skill_02 = 0  end if
   if( NewRec.skill_02 is NULL )then let NewRec.skill_02 = 0  end if
#   if( OldRec.skill_02 > 0 OR NewRec.skill_02 > 0 )then
   if( SkillArrU[tb_ord, 2].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 2].s_desc clipped, '"', DELIMIT, OldRec.skill_02 using "#&", DELIMIT, NewRec.skill_02 using "#&", DELIMIT
   end if
   if( OldRec.skill_03 is NULL )then let OldRec.skill_03 = 0  end if
   if( NewRec.skill_03 is NULL )then let NewRec.skill_03 = 0  end if
#   if( OldRec.skill_03 > 0 OR NewRec.skill_03 > 0 )then
   if( SkillArrU[tb_ord, 3].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 3].s_desc clipped, '"', DELIMIT, OldRec.skill_03 using "#&", DELIMIT, NewRec.skill_03 using "#&", DELIMIT
   end if
   if( OldRec.skill_04 is NULL )then let OldRec.skill_04 = 0  end if
   if( NewRec.skill_04 is NULL )then let NewRec.skill_04 = 0  end if
#   if( OldRec.skill_04 > 0 OR NewRec.skill_04 > 0 )then
   if( SkillArrU[tb_ord, 4].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 4].s_desc clipped, '"', DELIMIT, OldRec.skill_04 using "#&", DELIMIT, NewRec.skill_04 using "#&", DELIMIT
   end if
   if( OldRec.skill_05 is NULL )then let OldRec.skill_05 = 0  end if
   if( NewRec.skill_05 is NULL )then let NewRec.skill_05 = 0  end if
#   if( OldRec.skill_05 > 0 OR NewRec.skill_05 > 0 )then
   if( SkillArrU[tb_ord, 5].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 5].s_desc clipped, '"', DELIMIT, OldRec.skill_05 using "#&", DELIMIT, NewRec.skill_05 using "#&", DELIMIT
   end if
   if( OldRec.skill_06 is NULL )then let OldRec.skill_06 = 0  end if
   if( NewRec.skill_06 is NULL )then let NewRec.skill_06 = 0  end if
#   if( OldRec.skill_06 > 0 OR NewRec.skill_06 > 0 )then
   if( SkillArrU[tb_ord, 6].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 6].s_desc clipped, '"', DELIMIT, OldRec.skill_06 using "#&", DELIMIT, NewRec.skill_06 using "#&", DELIMIT
   end if
   if( OldRec.skill_07 is NULL )then let OldRec.skill_07 = 0  end if
   if( NewRec.skill_07 is NULL )then let NewRec.skill_07 = 0  end if
#   if( OldRec.skill_07 > 0 OR NewRec.skill_07 > 0 )then
   if( SkillArrU[tb_ord, 7].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 7].s_desc clipped, '"', DELIMIT, OldRec.skill_07 using "#&", DELIMIT, NewRec.skill_07 using "#&", DELIMIT
   end if
   if( OldRec.skill_08 is NULL )then let OldRec.skill_08 = 0  end if
   if( NewRec.skill_08 is NULL )then let NewRec.skill_08 = 0  end if
#   if( OldRec.skill_08 > 0 OR NewRec.skill_08 > 0 )then
   if( SkillArrU[tb_ord, 8].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 8].s_desc clipped, '"', DELIMIT, OldRec.skill_08 using "#&", DELIMIT, NewRec.skill_08 using "#&", DELIMIT
   end if
   if( OldRec.skill_09 is NULL )then let OldRec.skill_09 = 0  end if
   if( NewRec.skill_09 is NULL )then let NewRec.skill_09 = 0  end if
#   if( OldRec.skill_09 > 0 OR NewRec.skill_09 > 0 )then
   if( SkillArrU[tb_ord, 9].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 9].s_desc clipped, '"', DELIMIT, OldRec.skill_09 using "#&", DELIMIT, NewRec.skill_09 using "#&", DELIMIT
   end if
   if( OldRec.skill_10 is NULL )then let OldRec.skill_10 = 0  end if
   if( NewRec.skill_10 is NULL )then let NewRec.skill_10 = 0  end if
#   if( OldRec.skill_10 > 0 OR NewRec.skill_10 > 0 )then
   if( SkillArrU[tb_ord, 10].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 10].s_desc clipped, '"', DELIMIT, OldRec.skill_10 using "#&", DELIMIT, NewRec.skill_10 using "#&", DELIMIT
   end if
   if( OldRec.skill_11 is NULL )then let OldRec.skill_11 = 0  end if
   if( NewRec.skill_11 is NULL )then let NewRec.skill_11 = 0  end if
#   if( OldRec.skill_11 > 0 OR NewRec.skill_11 > 0 )then
   if( SkillArrU[tb_ord, 11].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 11].s_desc clipped, '"', DELIMIT, OldRec.skill_11 using "#&", DELIMIT, NewRec.skill_11 using "#&", DELIMIT
   end if
   if( OldRec.skill_12 is NULL )then let OldRec.skill_12 = 0  end if
   if( NewRec.skill_12 is NULL )then let NewRec.skill_12 = 0  end if
#   if( OldRec.skill_12 > 0 OR NewRec.skill_12 > 0 )then
   if( SkillArrU[tb_ord, 12].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 12].s_desc clipped, '"', DELIMIT, OldRec.skill_12 using "#&", DELIMIT, NewRec.skill_12 using "#&", DELIMIT
   end if
   if( OldRec.skill_13 is NULL )then let OldRec.skill_13 = 0  end if
   if( NewRec.skill_13 is NULL )then let NewRec.skill_13 = 0  end if
#   if( OldRec.skill_13 > 0 OR NewRec.skill_13 > 0 )then
   if( SkillArrU[tb_ord, 13].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 13].s_desc clipped, '"', DELIMIT, OldRec.skill_13 using "#&", DELIMIT, NewRec.skill_13 using "#&", DELIMIT
   end if
   if( OldRec.skill_14 is NULL )then let OldRec.skill_14 = 0  end if
   if( NewRec.skill_14 is NULL )then let NewRec.skill_14 = 0  end if
#   if( OldRec.skill_14 > 0 OR NewRec.skill_14 > 0 )then
   if( SkillArrU[tb_ord, 14].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 14].s_desc clipped, '"', DELIMIT, OldRec.skill_14 using "#&", DELIMIT, NewRec.skill_14 using "#&", DELIMIT
   end if
   if( OldRec.skill_15 is NULL )then let OldRec.skill_15 = 0  end if
   if( NewRec.skill_15 is NULL )then let NewRec.skill_15 = 0  end if
#   if( OldRec.skill_15 > 0 OR NewRec.skill_15 > 0 )then
   if( SkillArrU[tb_ord, 15].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 15].s_desc clipped, '"', DELIMIT, OldRec.skill_15 using "#&", DELIMIT, NewRec.skill_15 using "#&", DELIMIT
   end if
   if( OldRec.skill_16 is NULL )then let OldRec.skill_16 = 0  end if
   if( NewRec.skill_16 is NULL )then let NewRec.skill_16 = 0  end if
#   if( OldRec.skill_16 > 0 OR NewRec.skill_16 > 0 )then
   if( SkillArrU[tb_ord, 16].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 16].s_desc clipped, '"', DELIMIT, OldRec.skill_16 using "#&", DELIMIT, NewRec.skill_16 using "#&", DELIMIT
   end if
   if( OldRec.skill_17 is NULL )then let OldRec.skill_17 = 0  end if
   if( NewRec.skill_17 is NULL )then let NewRec.skill_17 = 0  end if
#   if( OldRec.skill_17 > 0 OR NewRec.skill_17 > 0 )then
   if( SkillArrU[tb_ord, 17].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 17].s_desc clipped, '"', DELIMIT, OldRec.skill_17 using "#&", DELIMIT, NewRec.skill_17 using "#&", DELIMIT
   end if
   if( OldRec.skill_18 is NULL )then let OldRec.skill_18 = 0  end if
   if( NewRec.skill_18 is NULL )then let NewRec.skill_18 = 0  end if
#   if( OldRec.skill_18 > 0 OR NewRec.skill_18 > 0 )then
   if( SkillArrU[tb_ord, 18].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 18].s_desc clipped, '"', DELIMIT, OldRec.skill_18 using "#&", DELIMIT, NewRec.skill_18 using "#&", DELIMIT
   end if
   if( OldRec.skill_19 is NULL )then let OldRec.skill_19 = 0  end if
   if( NewRec.skill_19 is NULL )then let NewRec.skill_19 = 0  end if
#   if( OldRec.skill_19 > 0 OR NewRec.skill_19 > 0 )then
   if( SkillArrU[tb_ord, 19].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 19].s_desc clipped, '"', DELIMIT, OldRec.skill_19 using "#&", DELIMIT, NewRec.skill_19 using "#&", DELIMIT
   end if
   if( OldRec.skill_20 is NULL )then let OldRec.skill_20 = 0  end if
   if( NewRec.skill_20 is NULL )then let NewRec.skill_20 = 0  end if
#   if( OldRec.skill_20 > 0 OR NewRec.skill_20 > 0 )then
   if( SkillArrU[tb_ord, 20].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 20].s_desc clipped, '"', DELIMIT, OldRec.skill_20 using "#&", DELIMIT, NewRec.skill_20 using "#&", DELIMIT
   end if
   if( OldRec.skill_21 is NULL )then let OldRec.skill_21 = 0  end if
   if( NewRec.skill_21 is NULL )then let NewRec.skill_21 = 0  end if
#   if( OldRec.skill_21 > 0 OR NewRec.skill_21 > 0 )then
   if( SkillArrU[tb_ord, 21].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 21].s_desc clipped, '"', DELIMIT, OldRec.skill_21 using "#&", DELIMIT, NewRec.skill_21 using "#&", DELIMIT
   end if
   if( OldRec.skill_22 is NULL )then let OldRec.skill_22 = 0  end if
   if( NewRec.skill_22 is NULL )then let NewRec.skill_22 = 0  end if
#   if( OldRec.skill_22 > 0 OR NewRec.skill_22 > 0 )then
   if( SkillArrU[tb_ord, 22].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 22].s_desc clipped, '"', DELIMIT, OldRec.skill_22 using "#&", DELIMIT, NewRec.skill_22 using "#&", DELIMIT
   end if
   if( OldRec.skill_23 is NULL )then let OldRec.skill_23 = 0  end if
   if( NewRec.skill_23 is NULL )then let NewRec.skill_23 = 0  end if
#   if( OldRec.skill_23 > 0 OR NewRec.skill_23 > 0 )then
   if( SkillArrU[tb_ord, 23].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 23].s_desc clipped, '"', DELIMIT, OldRec.skill_23 using "#&", DELIMIT, NewRec.skill_23 using "#&", DELIMIT
   end if
   if( OldRec.skill_24 is NULL )then let OldRec.skill_24 = 0  end if
   if( NewRec.skill_24 is NULL )then let NewRec.skill_24 = 0  end if
#   if( OldRec.skill_24 > 0 OR NewRec.skill_24 > 0 )then
   if( SkillArrU[tb_ord, 24].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 24].s_desc clipped, '"', DELIMIT, OldRec.skill_24 using "#&", DELIMIT, NewRec.skill_24 using "#&", DELIMIT
   end if
   if( OldRec.skill_25 is NULL )then let OldRec.skill_25 = 0  end if
   if( NewRec.skill_25 is NULL )then let NewRec.skill_25 = 0  end if
#   if( OldRec.skill_25 > 0 OR NewRec.skill_25 > 0 )then
   if( SkillArrU[tb_ord, 25].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 25].s_desc clipped, '"', DELIMIT, OldRec.skill_25 using "#&", DELIMIT, NewRec.skill_25 using "#&", DELIMIT
   end if
   if( OldRec.skill_26 is NULL )then let OldRec.skill_26 = 0  end if
   if( NewRec.skill_26 is NULL )then let NewRec.skill_26 = 0  end if
#   if( OldRec.skill_26 > 0 OR NewRec.skill_26 > 0 )then
   if( SkillArrU[tb_ord, 26].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 26].s_desc clipped, '"', DELIMIT, OldRec.skill_26 using "#&", DELIMIT, NewRec.skill_26 using "#&", DELIMIT
   end if
   if( OldRec.skill_27 is NULL )then let OldRec.skill_27 = 0  end if
   if( NewRec.skill_27 is NULL )then let NewRec.skill_27 = 0  end if
#   if( OldRec.skill_27 > 0 OR NewRec.skill_27 > 0 )then
   if( SkillArrU[tb_ord, 27].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 27].s_desc clipped, '"', DELIMIT, OldRec.skill_27 using "#&", DELIMIT, NewRec.skill_27 using "#&", DELIMIT
   end if
   if( OldRec.skill_28 is NULL )then let OldRec.skill_28 = 0  end if
   if( NewRec.skill_28 is NULL )then let NewRec.skill_28 = 0  end if
#   if( OldRec.skill_28 > 0 OR NewRec.skill_28 > 0 )then
   if( SkillArrU[tb_ord, 28].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 28].s_desc clipped, '"', DELIMIT, OldRec.skill_28 using "#&", DELIMIT, NewRec.skill_28 using "#&", DELIMIT
   end if
   if( OldRec.skill_29 is NULL )then let OldRec.skill_29 = 0  end if
   if( NewRec.skill_29 is NULL )then let NewRec.skill_29 = 0  end if
#   if( OldRec.skill_29 > 0 OR NewRec.skill_29 > 0 )then
   if( SkillArrU[tb_ord, 29].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 29].s_desc clipped, '"', DELIMIT, OldRec.skill_29 using "#&", DELIMIT, NewRec.skill_29 using "#&", DELIMIT
   end if
   if( OldRec.skill_30 is NULL )then let OldRec.skill_30 = 0  end if
   if( NewRec.skill_30 is NULL )then let NewRec.skill_30 = 0  end if
#   if( OldRec.skill_30 > 0 OR NewRec.skill_30 > 0 )then
   if( SkillArrU[tb_ord, 30].s_desc != 'Not Used' )then
      display tceid clipped, DELIMIT, '"', tpart_name clipped, '"', DELIMIT, '"', tctp clipped, '"', DELIMIT, '"', SkillArrU[tb_ord, 30].s_desc clipped, '"', DELIMIT, OldRec.skill_30 using "#&", DELIMIT, NewRec.skill_30 using "#&", DELIMIT
   end if
#end if

   if( tctp != pastCtp )then
#   display "TOTAL: ", pastCtp, ttl1, ttl2
{REAL
    if( pastCtp is not NULL and pastCtp != 'none' and pastCtp != ' ')then
       display '"', pastCtp clipped, '"', DELIMIT, ttl1, DELIMIT, ttl2, DELIMIT
    end if
REAL}

#      let ttl1 = 0
#      let ttl2 = 0
   end if
   let pastCtp = tctp
#   display tctp, cnt, cnt2, ttl1, ttl2
#   display tctp, ttl1, ttl2
end foreach
#   display "TOTAL: ", pastCtp, ttl1, ttl2
{REAL
    display 
           '"', pastCtp clipped, '"', DELIMIT,
           ttl1, DELIMIT,
           ttl2, DELIMIT
REAL}



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

