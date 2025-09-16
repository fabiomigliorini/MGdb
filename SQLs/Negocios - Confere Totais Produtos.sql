with tot as (
	select npb.codnegocio, sum(npb.valorprodutos) as valorprodutos
	from tblnegocioprodutobarra npb
	where npb.inativo is null
	group by npb.codnegocio
) 
select 
	n.codnegocio,
	n.valorprodutos,
	tot.valorprodutos
from tblnegocio n
left join tot on (tot.codnegocio = n.codnegocio)
where n.valorprodutos != coalesce(tot.valorprodutos, 0)
and n.codnegociostatus = 2
--and n.codnegocio = 4029712
ORDER BY lancamento desc
--limit 50

with tot as (
	select 
		npb.codnegocio,
		sum(npb.valorprodutos) as valorprodutos,
		sum(npb.valordesconto) as valordesconto,
		sum(npb.valorfrete ) as valorfrete,
		sum(npb.valoroutras ) as valoroutras,
		sum(npb.valorseguro) as valorseguro,
		sum(npb.valortotal) as valortotal
	from tblnegocioprodutobarra npb
	where npb.codnegocio in (:codnegocios)
	and npb.inativo is null
	group by codnegocio
)
update tblnegocio
set valorprodutos = tot.valorprodutos,
    valordesconto = tot.valordesconto,
    valorfrete = tot.valorfrete,
    valoroutras = tot.valoroutras,
    valorseguro = tot.valorseguro,
    valortotal = tot.valortotal
from tot
where tblnegocio.codnegocio in (:codnegocios)
and tblnegocio.codnegocio = tot.codnegocio


select 
	t.codnegocio, 
	t.codnegocioprodutobarra, 
	t.quantidade, 
	t.valorunitario, 
	t.valorprodutos, 
	t.valordesconto,
	t.valorfrete,
	t.valoroutras,
	t.valorseguro,
	t.valortotal, 
	t.alteracao,
	t.inativo
from tblnegocioprodutobarra t 
where codnegocio = :codnegocio