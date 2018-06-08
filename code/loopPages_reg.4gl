# August   24, 2015   John M. Shoemaker, create

globals "globals.4gl"

main
define
   qtrStr char(128),
   t_id like eus.e_id
  
call ReadCmdLn("loopPages_reg", 4)
call ProcCmdLn("loopPages_reg")


let qtrStr="select a.e_id from eus a, _eucolnamesu b where a.e_id = b.idx and a.e_brand = '", BRec.b_id clipped, "'"

prepare QID from qtrStr
declare ACurs cursor for QID

foreach ACurs into t_id
   display t_id
end foreach

end main

