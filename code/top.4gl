
database partners_na




main
define
   tbrand record like unit_brand.*,
   tcat record like skill_cat.*,
   tname record like skill.*,
   snum smallint,
   tceid like coverage_nc.ceid,
   tpart_name like coverage_nc.part_name,
   SQLStr char(512),
   SQLStr2 char(512)

let snum=4

let SQLStr="select b.*, c.*, a.* from skill a, unit_brand b, skill_cat c where a.b_id=b.b_id and c.c_brand=a.b_id and c.c_id=a.c_id and b.u_id='NC' and s_name != 'NA' order by a.b_id, c.c_id, a.s_num"

prepare TID from SQLStr
declare TCurs cursor for TID
display "Brand", "~", "Category", "~", "Description", "~", "Partner"
foreach TCurs into tbrand.*, tcat.*, tname.*
#   display tbrand.sdesc clipped, " : ", tcat.c_long clipped, " : ", tname.s_desc clipped
   let SQLStr2="select b.ceid, b.part_name from skills_", tbrand.b_id clipped, " a, coverage_nc b where a.ceid=b.ceid and skill_", tname.db_num using "&&", ">=", snum using "&", "  order by part_name"
#   display SQLStr2 clipped
   prepare T2ID from SQLStr2
   declare T2Curs cursor for T2ID
   foreach T2Curs into tceid, tpart_name
      display tbrand.sdesc clipped, "~", tcat.c_long clipped, "~", tname.s_desc clipped, "~", tpart_name clipped

   end foreach

end foreach


end main

