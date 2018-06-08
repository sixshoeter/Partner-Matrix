
database partners_na 

MAIN
   define
      ARec record like coverage_au.*,
      SQLStr char(9000)

   let SQLStr = "select a.* from coverage_au a, coverage_wu b where a.ceid = b.ceid and b.hq is null"
#display SQLStr
begin work;
   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*
      display ARec.ceid, " - ", ARec.part_name
  
      update coverage_wu set hq = ARec.hq where ceid = ARec.ceid and (coverage_wu.hq is null or coverage_wu.hq = " ")
   end foreach

#commit work;

END MAIN

