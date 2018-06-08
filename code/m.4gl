
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
delete from nbptv
delete from nbptv_parts

let SQLStr="select unique ceid, iot, imt, country from tbptv into temp _t1"
prepare BID from SQLStr
execute BID

#insert into nbptv 
#   select unique a.ceid, a.iot, a.imt, a.country, b.pw_level 
#      from _t1 a, tbptv b where a.ceid = b.ceid and b.pw_level is not null

select min(revdt) min_dt from tbptv into temp _td1;
select max(revdt) max_dt from tbptv into temp _td2;

insert into ntest
   select a.ceid, a.rag, max(a.revdt), max(a.bptv_01), max(a.people_01),
          sum(b.nlrev_01), 
          sum(c.nlrev_01), 
          sum(c.vrrev_01)
      from tbptv a, outer tbptv b, outer tbptv c, _td1 d, _td2 e
      where a.ceid = b.ceid and b.revdt = d.min_dt
      and a.ceid = c.ceid and c.revdt = e.max_dt
      group by 1,2
commit work
END MAIN
