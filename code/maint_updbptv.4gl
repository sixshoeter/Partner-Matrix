
database partners_na

MAIN
define
   SQLStr char(128),
   BPTVRec record like tbptv.*
 

#let SQLStr = "select * from tbptv order by ceid, rag"
#prepare BID from SQLStr
#declare BCurs cursor for BID

#foreach BCurs into BPTVRec.*

#end foreach
begin work
display "Started transaction"

delete from nbptv
delete from nbptv_parts
display "Deleted nbptv and nbptv_parts rows"

let SQLStr="select unique ceid, iot, imt, country from tbptv into temp _t1"
prepare BID from SQLStr
execute BID
display "Created _t1 temp table"


let SQLStr="select unique b.ceid, b.pw_level, c.ord from tbptv b, pw_level c where b.pw_level=c.level into temp _levels"
prepare LID from SQLSTR
execute LID
display "Created _levels temp table"

insert into nbptv 
   select unique a.ceid, a.iot, a.imt, a.country, c.level 
   from _t1 a, tbptv b, pw_level c 
   where a.ceid = b.ceid and b.pw_level =c.level
      and c.ord = (select max(c.ord) from _levels c where c.ceid=a.ceid)

display "Populated nbptv table"
#   select unique a.ceid, a.iot, a.imt, a.country, b.pw_level 
#      from _t1 a, tbptv b where a.ceid = b.ceid and b.pw_level is not null

insert into nbptv_parts 
   select ceid, rag, max(revdt), max(bptv_01), max(people_01), sum(nlrev_01), sum(vrrev_01)
      from tbptv
      group by 1,2
display "Populated nbptv_parts table"

commit work
display "commit"
END MAIN
