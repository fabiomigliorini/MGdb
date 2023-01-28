select p.codpessoa, p.fantasia, p.pessoa, p.telefone1, sum(n.valortotal) as valortotal, count(n.codnegocio) as quant
from tblnegocio n
inner join tblpessoa p on (p.codpessoa = n.codpessoa)
where n.codnegociostatus = 2 
and n.codfilial in (101, 102, 103, 104, 105)
--and n.codnaturezaoperacao = 00000004 -- Compra
and n.codnaturezaoperacao = 00000001 -- Venda
and n.lancamento >= '2021-04-01'
and n.codpessoa != 1
and n.codpessoa = :codpessoa 
group by p.codpessoa, p.fantasia, p.pessoa, p.telefone1
order by 5 desc
limit 30


select 
	p.codproduto, 
	p.produto, 
	pv.variacao, 
	sum(npb.quantidade * coalesce(pe.quantidade, 1)) as quantidade, 
	sum(npb.valortotal) as valortotal, 
	count(npb.codnegocioprodutobarra) as negocios
	,
	(
		select count(*) 
		from tblmercosproduto mp 
		where mp.inativo is null
		and mp.codprodutovariacao = pv.codprodutovariacao 
	) as mercos
from tblnegocio n
left join tblnegocioprodutobarra npb on (npb.codnegocio = n.codnegocio)
left join tblprodutobarra pb on (pb.codprodutobarra = npb.codprodutobarra)
left join tblprodutoembalagem pe on (pe.codprodutoembalagem = pb.codprodutoembalagem)
left join tblprodutovariacao pv on (pv.codprodutovariacao = pb.codprodutovariacao)
left join tblproduto p on (p.codproduto = pv.codproduto)
where n.lancamento  >= '2021-04-01'
and n.codnegociostatus = 2
and n.codnaturezaoperacao = 00000001 -- Venda
and n.codfilial in (101, 102, 103, 104, 105)
and n.codpessoa in (
	11385, 108, 313, 1464, 450, 200, 1356, 213, 3673, 7069, 5890, 8745, 1981, 758, 5911, 277, 281, 189, 321, 9694, 10001150, 11777, 30010494, 10000613, 195, 194, 10000431, 201, 199, 202, 68, 88, 76, 69, 80, 207, 197, 860, 224, 6140, 1871, 7073, 869, 4248, 2661, 890, 908, 8954, 4, 12135, 237, 12116, 30010901, 4546, 10743, 11321, 3178, 1320, 12821, 564, 1534, 4375, 12169, 6807
)
group by p.codproduto, p.produto, pv.variacao, pv.codprodutovariacao 
order by 1, 2, 3 asc