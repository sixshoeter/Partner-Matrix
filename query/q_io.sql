#############################
####     IoT
#############################
begin;
delete from curr_revenue where brand='IO';

## INSERT IO base rows
insert into curr_revenue
select a.brand, b.ceid, 'Y' curr_rev_flg, sum(rev_norm_curr_yr) rev_sum, "N" has_sol, "N" has_skill, "N" has_contact
from competency b, brand_bu a, coverage_io d, outer gsd_solutions c
where a.bu=b.bu and a.brand='IO' and b.ceid=c.ceid and b.comp_name=c.comp_name and b.ceid=d.ceid
group by 1,2,3
having sum(rev_norm_curr_yr)>0;

insert into curr_revenue(brand, ceid, curr_rev_flg, rev, has_sol, has_skill, has_contact ) select "IO" brand, a.ceid, "N" curr_rev_flg, 0 rev, "N" has_sol, "N" has_skill, "N" has_contact from coverage_io a where a.ceid not in (select unique ceid from curr_revenue where brand="IO");

## UPDATE IF THEY HAVE SOLUTIONS
update curr_revenue set has_sol="Y" where brand='IO' and ceid in (select unique c.ceid from competency b, brand_bu a, gsd_solutions c where a.bu=b.bu and a.brand='IO' and b.comp_name=c.comp_name);


update curr_revenue set has_skill="Y" where brand="IO" and ceid in (select ceid from skills_io where skill_01>1 or skill_02>1 or skill_03>1  or skill_04>1  or skill_05>1  or skill_06>1  or skill_07>1  or skill_08>1  or skill_09>1  or skill_10>1  or skill_11>1  or skill_12>1  or skill_13>1  or skill_14>1  or skill_15>1  or skill_16>1  or skill_17>1  or skill_18>1  or skill_19>1  or skill_20>1  or skill_21>1  or skill_22>1  or skill_23>1  or skill_24>1  or skill_25>1  or skill_26>1  or skill_27>1  or skill_28>1  or skill_29>1  or skill_30>1 ) and (has_skill != "Y" or has_skill is null or has_skill=" " or has_skill="N" );


### UPDATE IF THEY HAVE CONTACTS
update curr_revenue set has_contact="Y" where brand="IO" and (has_contact != " " or has_contact is null or has_contact = " " or has_contact = "N") and ceid in (select ceid from coverage_io where p_name is not null and p_name != " ");


## UNLOAD TO INSPECT RESULTS
#unload to look.unl
#select a.part_name, cr.* from coverage_io a, curr_revenue cr where cr.brand="IO" and a.ceid=cr.ceid order by cr.curr_rev_flg desc, cr.has_sol desc, cr.has_skill desc, cr.has_contact desc, a.part_name;

commit;
