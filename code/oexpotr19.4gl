# January 14, 2016  John M. Shoemaker jshoe@us.ibm.com, created


globals "globals.4gl"

MAIN
define
   tceid like coverage_au.ceid,
   tpart_name like coverage_au.part_name,
   tbrand char(3),
   tctp like coverage_au.ctp1,
   tupd like coverage_au.updtime,
   supd like skills_im.updtime,
   sqlStr char(2014),
   DELIMIT char(1),
   updstr1, updstr2 char(20)

call ReadCmdLn("home", 4)
call ProcCmdLn("home")
let DELIMIT=","

case BRec.b_id
   when 'AU'
      let sqlStr = "select a.ceid, a.part_name, a.updtime, 'IM', a.ctp1, c.updtime from coverage_au a, outer skills_im c where a.ceid=c.ceid and (a.ctp1 != ' ' and a.ctp1 is not null ) ",
                   "union select a.ceid, a.part_name, a.updtime, 'ECM', a.ctp2, c.updtime from coverage_au a, outer skills_em c where a.ceid=c.ceid and (a.ctp2 != ' ' and a.ctp2 is not null) ",
                   "union select a.ceid, a.part_name, a.updtime, 'BA', a.ctp3, c.updtime from coverage_au a, outer skills_ba c where a.ceid=c.ceid and (a.ctp3 != ' ' and a.ctp3 is not null) ",
                   "union select a.ceid, a.part_name, a.updtime, 'IoT', a.ctp4, c.updtime from coverage_au a, outer skills_io c where a.ceid=c.ceid and (a.ctp4 != ' ' and a.ctp4 is not null) ",
                   "order by 2,1"

   when 'SU'
      let sqlStr = "select a.ceid, a.part_name, a.updtime, 'S1', a.ctp1, c.updtime from coverage_su a, outer skills_s1 c where a.ceid=c.ceid and (a.ctp1 != ' ' and a.ctp1 is not null )",
                   "union select a.ceid, a.part_name, a.updtime, 'S2', a.ctp2, c.updtime from coverage_su a, outer skills_s2 c where a.ceid=c.ceid and (a.ctp2 != ' ' and a.ctp2 is not null )",
                   "union select a.ceid, a.part_name, a.updtime, 'S3', a.ctp3, c.updtime from coverage_su a, outer skills_s3 c where a.ceid=c.ceid and (a.ctp3 != ' ' and a.ctp3 is not null )",
                   "union select a.ceid, a.part_name, a.updtime, 'S4', a.ctp4, c.updtime from coverage_su a, outer skills_s4 c where a.ceid=c.ceid and (a.ctp4 != ' ' and a.ctp4 is not null )",
                   "union select a.ceid, a.part_name, a.updtime, 'S5', a.ctp5, c.updtime from coverage_su a, outer skills_s5 c where a.ceid=c.ceid and (a.ctp5 != ' ' and a.ctp5 is not null )",
                   "order by 2,1"

   when 'BU'
      let sqlStr = "select a.ceid, a.part_name, a.updtime, 'BU', a.ctp1, c.updtime from coverage_bu a, outer skills_co c where a.ceid=c.ceid and (a.ctp1 != ' ' and a.ctp1 is not null )order by 2, 1"

end case

#display SQLStr

prepare ID1 from sqlStr
declare ID1Curs cursor for ID1

   display 
           "CEID", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "LAST UPD", DELIMIT,
           "STALE", DELIMIT,
           "BRAND", DELIMIT,
           "TSS", DELIMIT,
           "LAST SKILL UPD", DELIMIT,
           "STALE"

foreach ID1Curs into tceid, tpart_name, tupd, tbrand, tctp, supd
   if( tupd < (today-100) )then
      let updstr1 = "STALE PROFILE DATA"
   else
      let updstr1 = " "
   end if
   if( supd < (today-100) )then
      let updstr2 = "STALE SKILL DATA"
   else
      let updstr2 = " "
   end if

   display 
	tceid clipped, DELIMIT,
	'"', tpart_name clipped, '"', DELIMIT,
	tupd, DELIMIT,
	updstr1, DELIMIT,
	tbrand clipped, DELIMIT,
	'"', tctp clipped, '"', DELIMIT,
	supd, DELIMIT,
	updstr2
  
end foreach


END MAIN

