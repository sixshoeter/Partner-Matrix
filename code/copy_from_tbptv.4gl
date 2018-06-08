
globals "globals.4gl"

MAIN
   define
      ARec record like _auin.*,
      tceid like coverage_au.ceid,
      tpart_name like coverage_au.part_name,
      TRec record like coverage_au.*,
      SQLStr char(9000)

   let SQLStr = "select unique * from _auin a where ",
                " a.ceid not in (select ceid from coverage_au)"
#display SQLStr

   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*
      display Arec.part_name
      initialize TRec.* to NULL
  
      let TRec.ceid = ARec.ceid
      let TRec.part_name = ARec.part_name
      let TRec.vad = ARec.vad
      let TRec.hq = ARec.hq
      let TRec.ssr = ARec.ssr
      let TRec.desc = "fix"
  

      insert into coverage_au values (TRec.*)
   end foreach

END MAIN

