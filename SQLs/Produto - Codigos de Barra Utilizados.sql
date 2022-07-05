select pe.quantidade, pb.codprodutovariacao , pb.barras, pb.codprodutobarra, count(*), min(n.lancamento), max(n.lancamento ), min(n.codnegocio)
from tblprodutobarra pb
inner join tblnegocioprodutobarra npb on (npb.codprodutobarra  = pb.codprodutobarra )
inner join tblnegocio n on (n.codnegocio  = npb.codnegocio )
left join tblprodutoembalagem pe on (pe.codprodutoembalagem = pb.codprodutoembalagem )
where pb.codproduto = :codproduto 
and n.lancamento >= '2016-04-01'
and n.codnegociostatus = 2
group by pe.quantidade, pb.codprodutovariacao, pb.barras, pb.codprodutobarra
order by 1 nulls first, 7 desc