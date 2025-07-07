select 
	nf.codfilial, 
	--nat.codnaturezaoperacao,
	nat.naturezaoperacao,
	nf.emissao, 
	nf.numero,
	coalesce(nfpb.descricaoalternativa, p.produto) as produto,
	nfpb.valortotal
from tblproduto p
inner join tblprodutobarra pb on (pb.codproduto = p.codproduto)
inner join tblnotafiscalprodutobarra nfpb on (nfpb.codprodutobarra = pb.codprodutobarra)
inner join tblnotafiscal nf on (nf.codnotafiscal = nfpb.codnotafiscal)
inner join tblnaturezaoperacao nat on (nat.codnaturezaoperacao = nf.codnaturezaoperacao)
where p.codtipoproduto  = 8
and nat.codoperacao = 2
and nat.codnaturezaoperacao not in (3, 69, 70, 9, 66) 
and nf.codfilial in (401, 402)
order by emissao desc

--select * from tbltipoproduto t 