
globals "globals.4gl"

MAIN
define
   tpart_name like coverage_au.part_name,
   tctp like coverage_au.ctp1,
   oldRec record like old_sws.*,
   newRec record like skills_au.*,
   bStr char(128),
   sqlStr char(2014),
   cnt int,
   cnt2 int,
   ttl1, ttl2 smallint,
   pastCtp like coverage_au.ctp1,
   tBrand like control.brand

let bStr = "select a.brand from control a where a.production=1 and a.brand in ('AU','SU') order by a.brand"
prepare bID1 from bStr
declare bIDCurs cursor for bID1

foreach bIDCurs into tBrand

   if( tBrand='AU' )then
      let sqlStr = "select a.part_name, a.ctp1, b.*, c.* from coverage_au a, old_sws b, skills_im c where a.ceid=b.ceid and a.ceid=c.ceid UNION ALL ",
                   "select a.part_name, a.ctp2, b.*, c.* from coverage_au a, old_sws b, skills_em c where a.ceid=b.ceid and a.ceid=c.ceid UNION ALL ",
                   "select a.part_name, a.ctp3, b.*, c.* from coverage_au a, old_sws b, skills_ba c where a.ceid=b.ceid and a.ceid=c.ceid order by 2, 1 "
   else
      let sqlStr = "select a.part_name, a.ctp1, b.*, c.* from coverage_su a, outer old_sws b, skills_s1 c where a.ceid=b.ceid and a.ceid=c.ceid UNION ",
                   "select a.part_name, a.ctp2, b.*, c.* from coverage_su a, outer old_sws b, skills_s2 c where a.ceid=b.ceid and a.ceid=c.ceid UNION ",
                   "select a.part_name, a.ctp3, b.*, c.* from coverage_su a, outer old_sws b, skills_s3 c where a.ceid=b.ceid and a.ceid=c.ceid UNION ",
                   "select a.part_name, a.ctp4, b.*, c.* from coverage_su a, outer old_sws b, skills_s4 c where a.ceid=b.ceid and a.ceid=c.ceid UNION ",
                   "select a.part_name, a.ctp5, b.*, c.* from coverage_su a, outer old_sws b, skills_s5 c where a.ceid=b.ceid and a.ceid=c.ceid order by 2, 1 "
   end if
#display sqlStr
   prepare ID1 from sqlStr
   declare ID1Curs cursor for ID1
      let ttl1 = 0
      let ttl2 = 0
      let pastCtp = "none"

   display "Brand Skill Details: ", tBrand

   foreach ID1Curs into tpart_name, tctp, oldRec.*, newRec.*
      let cnt = 0
      let cnt2 = 0
      if( tctp != pastCtp )then
      display "TOTAL: ", pastCtp, ttl1, ttl2
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

   display "TOTAL: ", pastCtp, ttl1, ttl2

end foreach
   
   
   
END MAIN
