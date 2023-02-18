-- valor por mes
select 
	date_trunc('month', nf.saida), 
	no.codoperacao,
	no.naturezaoperacao,
	sum(nf.valortotal)
--	*
from tblnotafiscal nf
inner join tblnaturezaoperacao no ON (no.codnaturezaoperacao = nf.codnaturezaoperacao)
where nf.saida between '2023-02-01' and '2023-02-28 23:59:59'
and nf.nfecancelamento is null
and nf.nfeinutilizacao is null
and nf.emitida 
and nf.codfilial in (101, 102, 103, 104, 105)
group by
	date_trunc('month', nf.saida),
	no.codoperacao,
	no.naturezaoperacao

-- quantidade por mes
select 
	date_trunc('month', nf.emissao), 
	--nf.modelo,
	count(*)
from tblnotafiscal nf
group by
	date_trunc('month', nf.emissao)
	--, nf.modelo
order by 1 desc, 2 asc
