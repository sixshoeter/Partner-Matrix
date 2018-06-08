
unload to query_241.unl
select 
	country, 
	cert_type, 
	cert_num, 
	cert_desc,
	person_num,
	achieve_dt,
	report_dt,
	sunset_dt,
	prod_group,
	brand 
from
	certs a,
	coverage_au b
where
	a.ceid = b.ceid
	and b.part_name = "Sogeti"
order by
	prod_group
