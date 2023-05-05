select p.codpessoa, p.fantasia, p.pessoa, p.telefone1, sum(n.valortotal) as valortotal, count(n.codnegocio) as quant
from tblnegocio n
inner join tblpessoa p on (p.codpessoa = n.codpessoa)
where n.codnegociostatus = 2 
and n.codfilial in (101, 102, 103, 104, 105)
--and n.codnaturezaoperacao = 00000004 -- Compra
and n.codnaturezaoperacao = 00000001 -- Venda
and n.lancamento >= '2021-04-01'
and n.codpessoa != 1
--and n.codpessoa = :codpessoa 
group by p.codpessoa, p.fantasia, p.pessoa, p.telefone1
order by 5 desc
limit 100


with cli as (
	select p.codpessoa, p.fantasia, p.pessoa, p.telefone1, sum(n.valortotal) as valortotal, count(n.codnegocio) as quant
	from tblnegocio n
	inner join tblpessoa p on (p.codpessoa = n.codpessoa)
	where n.codnegociostatus = 2 
	and n.codfilial in (101, 102, 103, 104, 105)
	--and n.codnaturezaoperacao = 00000004 -- Compra
	and n.codnaturezaoperacao = 00000001 -- Venda
	and n.lancamento >= now() - '2 years'::interval
	and n.codpessoa != 1
	--and n.codpessoa = :codpessoa 
	group by p.codpessoa, p.fantasia, p.pessoa, p.telefone1
	order by 5 desc
	limit 100
)
select 
	p.codproduto, 
	p.produto, 
	pv.variacao, 
	sum(npb.quantidade * coalesce(pe.quantidade, 1)) as quantidade, 
	--p.preco,
	sum(npb.valortotal) / 	sum(npb.quantidade * coalesce(pe.quantidade, 1)) as precovenda, 
	sum(npb.valortotal) as valortotal, 
	count(npb.codnegocioprodutobarra) as negocios
	,
	(
		select count(*) 
		from tblmercosproduto mp 
		where mp.inativo is null
		and mp.codprodutovariacao = pv.codprodutovariacao 
	) as mercos,
	p.abc
from tblnegocio n
left join tblnegocioprodutobarra npb on (npb.codnegocio = n.codnegocio)
left join tblprodutobarra pb on (pb.codprodutobarra = npb.codprodutobarra)
left join tblprodutoembalagem pe on (pe.codprodutoembalagem = pb.codprodutoembalagem)
left join tblprodutovariacao pv on (pv.codprodutovariacao = pb.codprodutovariacao)
left join tblproduto p on (p.codproduto = pv.codproduto)
inner join cli on (cli.codpessoa = n.codpessoa)
where n.lancamento >= now() - '2 years'::interval
and n.codnegociostatus = 2
and n.codnaturezaoperacao = 00000001 -- Venda
and n.codfilial in (101, 102, 103, 104, 105)
group by p.codproduto, p.produto, pv.variacao, pv.codprodutovariacao
--order by 1, 2, 3 asc
order by 7 desc --quantidade de negocios
limit 500
