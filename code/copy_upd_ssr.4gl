
globals "globals.4gl"

MAIN
   define
      ARec record like _innc.*,
      TRec record like coverage_nc.*,
      cnt, cnt2 smallint,
      SQLStr char(9000)

   let SQLStr = "select a.* from _innc a order by a.part_name"
   let cnt=0
   let cnt2=0
#display SQLStr
begin work;


   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*
      let cnt=cnt+1
      display ARec.part_name
      initialize TRec.* to NULL

## update ceids to downshift

      let TRec.ceid = downshift(ARec.ceid)
      let TRec.ssr = ARec.ssr

## update ssrs
      if( TRec.ssr!="Uncovered" and TRec.ssr!=" " and TRec.ssr is not null )then
         update coverage_nc set ssr = TRec.ssr, updtime=current where ceid = TRec.ceid 
         if( sqlca.sqlcode = 0 )then
            let cnt2=cnt2+1
         end if
      end if
   end foreach


display "Total: ", cnt
display "Total Success: ", cnt2
#commit work;
END MAIN

