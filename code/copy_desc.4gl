
database partners_na 

MAIN
   define
      ARec record like coverage_st.*,
      SQLStr char(9000)

   let SQLStr = "select a.* from coverage_io a, coverage_wu b where a.ceid = b.ceid and b.desc is null"
#display SQLStr
begin work;
   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*
      display ARec.ceid, " - ", ARec.part_name
  
      update coverage_wu set desc = ARec.desc where ceid = ARec.ceid and (coverage_wu.desc is null or coverage_wu.desc = " ")
   end foreach

commit work;

END MAIN

