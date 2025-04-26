with p as (
	select npb.codnegocio, sum(npb.valortotal) as valortotal, sum(npb.valorprodutos) as valorprodutos 
	from tblnegocioprodutobarra npb
	where npb.inativo is null
	group by npb.codnegocio
)
select n.codnegocio, n.lancamento, n.valorprodutos, p.valorprodutos, n.valortotal, p.valortotal, n.valordesconto 
from tblnegocio n
left join p on (p.codnegocio = n.codnegocio)
where n.valorprodutos != coalesce(p.valorprodutos, 0)
order by n.lancamento desc

select inativo, valortotal, * 
from tblnegocioprodutobarra npb 
where codnegocio = 3545014
order by criacao 