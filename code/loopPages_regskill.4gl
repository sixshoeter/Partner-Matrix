# August  24, 2015   John M. Shoemaker, create

globals "globals.4gl"

main
define
   qtrStr char(256),
   t_brand like brands.b_id,
   t_id like eus.e_id,
   t_sc like skill_cat.c_id
  
call ReadCmdLn("loopPages_regskill", 4)
call ProcCmdLn("loopPages_regskill")


let qtrStr="select b.b_id, a.e_id, c.c_id from eus a, unit_brand b, skill_cat c, _eucolnamesu d where a.e_brand=b.b_id and b.b_id = c.c_brand and a.e_id = d.idx and b.u_id = '", BRec.b_id clipped, "' order by 1,2,3"

prepare QID from qtrStr
declare ACurs cursor for QID

foreach ACurs into t_brand, t_id, t_sc
   display t_brand clipped, " ", t_id, " ", t_sc
end foreach

end main

