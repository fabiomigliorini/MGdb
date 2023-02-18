select distinct
	orig.data 
	, orig.codestoquemes
	, dest.codestoquemes
	, orig.saidaquantidade
	, orig.saidavalor
	, dest.entradaquantidade
	, dest.entradavalor
	, abs(coalesce(orig.saidavalor, 0) - coalesce(dest.entradavalor, 0)) as diferença
	, ' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || cast(dest.codestoquemes as varchar) || ' & ' as comando
	--, 'curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || cast(orig.codestoquemes as varchar) as comando
	/*
	*/
from tblestoquemovimento dest
inner join tblestoquemovimento orig on (orig.codestoquemovimento = dest.codestoquemovimentoorigem)
where orig.saidavalor != 0 
and abs(coalesce(orig.saidavalor, 0) - coalesce(dest.entradavalor, 0)) / coalesce(orig.saidavalor, dest.entradavalor) > 0.1
and orig.saidaquantidade = dest.entradaquantidade
and orig.data >= '2018-01-01'
order by 8 desc
limit 5000
--offset 4000


select 
	count(*)
from tblestoquemovimento dest
inner join tblestoquemovimento orig on (orig.codestoquemovimento = dest.codestoquemovimentoorigem)
where orig.saidavalor != 0 
and abs(coalesce(orig.saidavalor, 0) - coalesce(dest.entradavalor, 0)) / coalesce(orig.saidavalor, dest.entradavalor) > 0.1
and orig.saidaquantidade = dest.entradaquantidade
