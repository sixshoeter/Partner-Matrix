
database partners_na 

main

define
   i smallint,
   Aarr array[1000] of record
      ceid char(100),
      idx smallint
   end record,
   SQLStr char(128)

   let SQLStr = "select ceid, 0 idx from coverage_ws"
   prepare a1id from SQLStr
   declare a1curs cursor for a1id
   let i = 0
   foreach a1curs into Aarr[i+1].*
      let Aarr[i+1].idx = i
      let i = i + 1
   end foreach

   display i

end main
