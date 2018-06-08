
globals "globals.4gl"

MAIN
   define
      ARec record like _iness.*,
      SQLStr char(9000)

##first make sure all ceids are downshifted
let SQLStr = "select a.* from _iness a order by a.part_name ;"
#display SQLStr
begin work;

update coverage_es set p_name=" ", p_title=" ", p_email=" ", p_phone=" " where ceid in (select ceid from _iness);

   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*
      display ARec.part_name
  
## update coverage
         update coverage_es set 
            p_name = ARec.p_name,
            p_title = " ",
            p_email = ARec.p_email,
            p_phone = ARec.p_phone,
            updtime=current
         where ceid = ARec.ceid 

   end foreach

#commit work;
END MAIN

