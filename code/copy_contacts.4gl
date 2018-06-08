
database partners_na 

MAIN
   define
      ARec record like coverage_st.*,
      SQLStr char(9000)

   let SQLStr = "select a.* from coverage_au a, coverage_wu b where a.ceid = b.ceid and b.p_name is null"
#display SQLStr
begin work;
   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*
      display ARec.ceid, " - ", ARec.part_name
  
      update coverage_wu set p_name = ARec.p_name, p_title=ARec.p_title, p_phone=ARec.p_phone, p_email=ARec.p_email where ceid = ARec.ceid and (coverage_wu.p_name is null or coverage_wu.p_name = " ")
   end foreach

commit work;

END MAIN

