
globals "globals.4gl"

MAIN
   define
      ARec record like coverage_is.*,
      NRec record like _isnew.*,
      TRec record like coverage_su.*,
      SQLStr char(9000)

   let SQLStr = "select a.*, b.* from coverage_is a, _isnew b where a.ceid = b.ceid "
#display SQLStr
begin work
   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*, NRec.*
      display NRec.part_name
  
      update coverage_is set ssr=NRec.ssr, ctp=NRec.ctp, updtime=current where ceid=NRec.ceid
   end foreach
commit work
END MAIN

