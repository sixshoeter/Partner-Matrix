select year(dttm) yr, month(dttm) mo, count(*) cnt from access group by 1,2  into temp t1;
select * from t1 order by 1,2;

