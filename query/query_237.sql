
unload to export237.csv
select 
	b.ceid, b.part_name, a.hq, a.url, a.p_name, a.p_title, a.p_phone, a.p_email, 
	b.comp_name, b.rev_curr_resale_yr, b.rev_curr_influence_yr, b.rev_curr_xaas_yr
from
	competency b,
	coverage_au a,
	svp c
where
	a.ceid = b.ceid
	and b.comp_name = c.comp_name
	and c.s_brand="AU"
	and (a.ssr is null or a.ssr=" " or a.ssr="" )
	and (b.rev_curr_resale_yr > 0 or b.rev_curr_influence_yr > 0 or b.rev_curr_xaas_yr > 0)

union 
select 
	b.ceid, b.part_name, " " as hq, "NIPM" as url, " " as p_name, " " as p_title, " " as p_phone, " " as p_email, 
	b.comp_name, b.rev_curr_resale_yr, b.rev_curr_influence_yr, b.rev_curr_xaas_yr
from
	competency b,
	svp c
where
	b.comp_name = c.comp_name
	and c.s_brand="AU"
	and (b.rev_curr_resale_yr > 0 or b.rev_curr_influence_yr > 0 or b.rev_curr_xaas_yr > 0)
        and b.ceid not in (select ceid from coverage_au)

