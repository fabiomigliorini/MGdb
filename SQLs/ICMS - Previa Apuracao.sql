-- valor por mes
select 
	date_trunc('month', nf.saida), 
	nf.codfilial,
	sum(case when no.codoperacao = 1 then nfpb.icmsvalor else null end) as entrada,
	sum(case when no.codoperacao != 1 then nfpb.icmsvalor else null end) as saida,
	sum(case when no.codoperacao != 1 then 1 else -1 end * nfpb.icmsvalor) as saldo,
	count(*)
from tblnotafiscal nf
inner join tblnaturezaoperacao no ON (no.codnaturezaoperacao = nf.codnaturezaoperacao)
inner join tblnotafiscalprodutobarra nfpb on (nfpb.codnotafiscal = nf.codnotafiscal)
inner join tblprodutobarra pb on (pb.codprodutobarra = nfpb.codprodutobarra)
inner join tblproduto p on (p.codproduto = pb.codproduto)
where nf.saida between :inicio and :fim
and nf.nfecancelamento is null
and nf.nfeinutilizacao is null
and nf.codfilial between 101 and 105
and p.codtributacao = 1
group by
	date_trunc('month', nf.saida),
	nf.codfilial

-- valor por mes
select 
	date_trunc('month', nf.saida), 
	sum(nfpb.pisvalor) as pis,
	sum(nfpb.cofinsvalor) as cofins,
	count(*)
from tblnotafiscal nf
inner join tblnaturezaoperacao no ON (no.codnaturezaoperacao = nf.codnaturezaoperacao)
inner join tblnotafiscalprodutobarra nfpb on (nfpb.codnotafiscal = nf.codnotafiscal)
inner join tblprodutobarra pb on (pb.codprodutobarra = nfpb.codprodutobarra)
inner join tblproduto p on (p.codproduto = pb.codproduto)
where nf.saida between :inicio and :fim
and nf.nfecancelamento is null
and nf.nfeinutilizacao is null
and nf.codfilial between 101 and 105
group by
	date_trunc('month', nf.saida)

-- valor por mes
select 
	date_trunc('month', nf.saida), 
	sum(nfpb.csllvalor) as csllvalor,
	sum(nfpb.irpjvalor) as irpjvalor,
	count(*)
from tblnotafiscal nf
inner join tblnaturezaoperacao no ON (no.codnaturezaoperacao = nf.codnaturezaoperacao)
inner join tblnotafiscalprodutobarra nfpb on (nfpb.codnotafiscal = nf.codnotafiscal)
inner join tblprodutobarra pb on (pb.codprodutobarra = nfpb.codprodutobarra)
inner join tblproduto p on (p.codproduto = pb.codproduto)
where nf.saida between :inicio and :fim
and nf.nfecancelamento is null
and nf.nfeinutilizacao is null
and nf.codfilial between 101 and 105
group by
	date_trunc('month', nf.saida)
