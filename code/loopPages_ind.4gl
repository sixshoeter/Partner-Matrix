# May  08, 2015   John M. Shoemaker, create

globals "globals.4gl"

main
define
   qtrStr char(128),
   t_short like industry.i_short
  
call ReadCmdLn("loopPages_ind", 4)
call ProcCmdLn("loopPages_ind")


let qtrStr="select a.i_short from industry a where a.i_brand = '", BRec.b_id clipped, "'"

prepare QID from qtrStr
declare ACurs cursor for QID

foreach ACurs into t_short
   display t_short clipped
end foreach

end main

