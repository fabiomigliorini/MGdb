
with i as (
	select npb.codnegocio, sum(npb.valortotal) as valorprodutos
	from tblnegocioprodutobarra npb
	group by npb.codnegocio 
)
select 
	n.lancamento,
	n.codnegocio,
	n.codnegociostatus,
	n.valorprodutos,
	i.valorprodutos
from tblnegocio n
inner join i on (i.codnegocio = n.codnegocio)
where n.valorprodutos != i.valorprodutos
--and n.codnegociostatus = 2
order by n.lancamento desc

/*
select * from vwnegocio order by lancamento desc limit 1000

select * from tblnegocio order by codnegocio ASC

select count(*) from tblnegocio
*/
with tot as (
	select 
		  t.codnegocio
		, coalesce(t.valorprodutos, 0) - coalesce(v.valortotal, 0) as dif_prod
		, coalesce(t.valortotal, 0) - coalesce(v.valortotalfinal, 0) as dif_total
		, coalesce(t.valoraprazo, 0) - coalesce(v.valorpagamentoaprazo, 0) as dif_prazo
		, coalesce(t.valoravista, 0) - coalesce(v.valortotalfinal, 0) + COALESCE(v.valorpagamentoaprazo, 0) as dif_vista
	from tblnegocio t
	inner join vwnegocio v on (v.codnegocio = t.codnegocio)
)
select * from tot where dif_total != 0 
--where t.codnegocio = 59
--where t.codnegocio < 100
--and t.codnegociostatus in (1,2)

--select * from vwnegocio where codnegocio = 9