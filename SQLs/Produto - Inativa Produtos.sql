-- Marca como inativos produtos que não sao movimentados a mais de 3 anos
update tblproduto
set inativo = date_trunc('second', now())
where tblproduto.codtipoproduto  = 0 --Mercadoria
and tblproduto.inativo is null
and tblproduto.criacao < (now() - '2 month'::interval)
and tblproduto.codproduto not in (
	select distinct pb.codproduto
	from tblnotafiscal nf 
	inner join tblnotafiscalprodutobarra nfpb on (nf.codnotafiscal = nfpb.codnotafiscal)
	inner join tblprodutobarra pb on (nfpb.codprodutobarra = pb.codprodutobarra)
	where nf.saida >= date_trunc('month', now() - '3 years'::interval)
	union 
	select distinct pb.codproduto
	from tblnegocio n 
	inner join tblnegocioprodutobarra npb on (n.codnegocio = npb.codnegocio)
	inner join tblprodutobarra pb on (npb.codprodutobarra = pb.codprodutobarra)
	where n.lancamento >= date_trunc('month', now() - '3 years'::interval)
)
returning tblproduto.codproduto, tblproduto.inativo
