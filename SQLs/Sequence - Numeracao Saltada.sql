
with nums as (
	select generate_series(1, 1000) as num
)
select * 
from nums
left join tblproduto p on (p.codproduto = nums.num)
where p.codproduto is null 
order by nums.num asc 

