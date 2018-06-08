
database partners_na 

MAIN
   define
      ARec record like coverage_st.*,
      SQLStr char(9000)

   let SQLStr = "select a.* from coverage_st a, coverage_se b where a.ceid = b.ceid and (b.part_type is null or b.part_type = ' ')"
#display SQLStr
begin work;
   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*
      display ARec.ceid, " - ", ARec.part_name
  
      update coverage_se set part_type = ARec.part_type where ceid = ARec.ceid and (coverage_se.part_type is null or coverage_se.part_type = " ")
   end foreach

#commit work;

END MAIN

