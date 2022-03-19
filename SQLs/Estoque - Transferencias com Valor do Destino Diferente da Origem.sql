select distinct
	orig.codestoquemes
	, dest.codestoquemes
	, orig.saidaquantidade
	, orig.saidavalor
	, dest.entradaquantidade
	, dest.entradavalor
	, 'curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || cast(dest.codestoquemes as varchar) as comando
	--, 'curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || cast(orig.codestoquemes as varchar) as comando
	/*
	*/
from tblestoquemovimento dest
inner join tblestoquemovimento orig on (orig.codestoquemovimento = dest.codestoquemovimentoorigem)
where orig.saidavalor != 0 
and abs(coalesce(orig.saidavalor, 0) - coalesce(dest.entradavalor, 0)) / coalesce(orig.saidavalor, dest.entradavalor) > 0.1
and orig.saidaquantidade = dest.entradaquantidade
order by 2 asc
offset 30000


select 
	count(*)
from tblestoquemovimento dest
inner join tblestoquemovimento orig on (orig.codestoquemovimento = dest.codestoquemovimentoorigem)
where orig.saidavalor != 0 
and abs(coalesce(orig.saidavalor, 0) - coalesce(dest.entradavalor, 0)) / coalesce(orig.saidavalor, dest.entradavalor) > 0.1
and orig.saidaquantidade = dest.entradaquantidade
