database partners_na

main
define
   nRec record like tmp_incom.*,
   cnt smallint,
   SQLStr char(512)

   let cnt = 0
   let SQLstr = "select a.* from tmp_incom a order by part_name"


   prepare uID from SQLStr
   declare uCurs cursor for uID

   begin work;

   foreach uCurs into nRec.*
      if( nRec.ceid is not null and nRec.ceid != " " )then
         display nRec.ceid, nRec.part_name, nRec.ssr, nRec.ctp
         let cnt = cnt + 1
         update coverage_bu set ssr=nRec.ssr, ctp1=nRec.ctp where ceid = nRec.ceid
         display sqlca.sqlcode, sqlca.sqlerrd[3]
      end if

   end foreach

   display "Cnt: ", cnt

#  commit work;



end main

