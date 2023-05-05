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
	date_trunc('month', nf.emissao)::date,
	sum(case when nf.modelo = 55 then 1 else 0 end) as NFe,
	sum(case when nf.modelo != 55 then 1 else 0 end) as NFCe,
	--sum(nf.valortotal),
	count(*) as total
from tblnotafiscal nf
where nf.nfeautorizacao is not null
and nf.nfeinutilizacao is null 
and nf.nfecancelamento is null
and nf.emitida 
and nf.emissao >= '2014-06-01'
group by
	date_trunc('month', nf.emissao)
	--, nf.modelo
order by 1 desc, 2 asc
