select a.ew, count(*) from ssrtab a, coverage_au b where a.ssr=b.ssr and b.reseller="R" group by 1 order by 1;
{select a.ew, a.ssr, a.ssrtype, count(*) from ssrtab a, coverage_au b where a.ssr=b.ssr and b.reseller="R" group by 1,2,3 order by 1,2,3;}
select a.ew region, a.ssr bpr, a.ssrtype note, b.ctp5 aca, count(*) from ssrtab a, coverage_au b where a.ssr=b.ssr and b.reseller="R" group by 1,2,3,4 order by 1,2,3,4;

select a.ceid, b.part_name, sum(a.revdt) ttl from tbptv a, coverage_au b where a.ceid = b.ceid and rag in (select bptv_name from svp where s_brand='AU') and a.revdt in (select max(revdt) from tbptv) group by 1,2 into temp _ttl;

select a.ew, count(*), sum(ttl) from ssrtab a, coverage_au b, outer _ttl c where a.ssr=b.ssr and b.ceid=c.ceid and b.reseller="R" group by 1 order by 1;

select a.ew region, a.ssr bpr, a.ssrtype note, b.ctp5 aca, count(*), sum(ttl) from ssrtab a, coverage_au b, _ttl c where a.ssr=b.ssr and b.ceid = c.ceid and b.reseller="R" group by 1,2,3,4 order by 1,2,3,4;


