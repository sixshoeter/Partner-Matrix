database partners_na

main
define
   nRec record like in_st.*,
   cnt smallint,
   SQLStr char(512)

   let cnt = 0
   let SQLstr = "select a.* from in_st a where (a.prog_stat is not null and a.prog_stat != ' ') order by part_name"


   prepare uID from SQLStr
   declare uCurs cursor for uID

   begin work;

   foreach uCurs into nRec.*
      if( nRec.ceid is not null and nRec.ceid != " " )then
         display nRec.ceid, nRec.part_name, nRec.prog_stat
         let cnt = cnt + 1
         update coverage_st set prog_status = nRec.prog_stat where ceid = nRec.ceid
         display sqlca.sqlcode, sqlca.sqlerrd[3]
      end if

   end foreach

   display "Cnt: ", cnt

#  commit work;



end main

