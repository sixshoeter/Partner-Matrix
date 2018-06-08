
database partners_na 

MAIN
   define
      ARec record like coverage_au.*,
      SQLStr char(9000)

   let SQLStr = "select a.* from coverage_au a, coverage_se b where a.ceid = b.ceid "
#display SQLStr
begin work;
   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*
      display ARec.ceid, " - ", ARec.part_name
  
      update coverage_se set vad = ARec.vad where ceid = ARec.ceid and (coverage_se.vad is null or coverage_se.vad = " " or coverage_se.vad="na" )
   end foreach

#commit work;

END MAIN

