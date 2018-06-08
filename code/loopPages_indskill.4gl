# May  20, 2015   John M. Shoemaker, create

globals "globals.4gl"

main
define
   qtrStr char(256),
   t_brand like brands.b_id,
   t_short like industry.i_short,
   t_sc like skill_cat.c_id
  
call ReadCmdLn("loopPages_indskill", 4)
call ProcCmdLn("loopPages_indskill")


let qtrStr="select b.b_id, a.i_short, c.c_id from industry a, unit_brand b, skill_cat c where a.i_brand=b.b_id and b.b_id = c.c_brand and b.u_id = '", BRec.b_id clipped, "' order by 1,2,3"

prepare QID from qtrStr
declare ACurs cursor for QID

foreach ACurs into t_brand, t_short, t_sc
   display t_brand clipped, " ", t_short clipped, " ", t_sc
end foreach

end main

