
with nums as (
	select generate_series(1, 10000000) as num
)
select * 
from nums
left join tblnotafiscalprodutobarra p on (p.codnotafiscalprodutobarra  = nums.num)
where p.codnotafiscalprodutobarra is null 
order by nums.num asc 


