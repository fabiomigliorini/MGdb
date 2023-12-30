-- Monta Script para recalcular Mes
select 
	em.codestoquemes, 
	em.entradaquantidade, 
	em.entradavalor, 
	round(coalesce(em.entradaquantidade, 0) * coalesce(mes.customedio, 0), 2) as calculado,
	em.saidaquantidade, 
	em.saidavalor, 
	round(coalesce(em.saidaquantidade  , 0) * coalesce(mes.customedio, 0), 2) as calculado,
	' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || em.codestoquemes --|| ' &'
from tblestoquemovimento em
inner join tblestoquemovimentotipo t on (t.codestoquemovimentotipo = em.codestoquemovimentotipo)
inner join tblestoquemes mes on (mes.codestoquemes = em.codestoquemes)
where t.preco = 2
and coalesce(mes.customedio, 0) != 0
and (
 	abs(round(coalesce(em.entradaquantidade, 0) * coalesce(mes.customedio, 0), 2) - coalesce(em.entradavalor, 0)) > 0.1
 or abs(round(coalesce(em.saidaquantidade  , 0) * coalesce(mes.customedio, 0), 2) - coalesce(em.saidavalor  , 0)) > 0.1
) 
order by em."data", em.codestoquemes, em.codestoquemovimento 
--limit 700
--offset 2100


/*
7357
29239
23598 - 08:47:40
21311 - 08:49:30
17969 - 08:52:28
10506 - 08:59:09
8238 - 09:05:36
7229 - 09:10:43
2803 - 09:44:23
*/

-- Quantidade de Registros
select 
	count(*)
from tblestoquemovimento em
inner join tblestoquemovimentotipo t on (t.codestoquemovimentotipo = em.codestoquemovimentotipo)
inner join tblestoquemes mes on (mes.codestoquemes = em.codestoquemes)
where t.preco = 2
and coalesce(mes.customedio, 0) != 0
and (
 	abs(round(coalesce(em.entradaquantidade, 0) * coalesce(mes.customedio, 0), 2) - coalesce(em.entradavalor, 0)) > 0.02
 or abs(round(coalesce(em.saidaquantidade  , 0) * coalesce(mes.customedio, 0), 2) - coalesce(em.saidavalor  , 0)) > 0.02
) 


with tot as (
  select 
  	mov.codestoquemes,
  	sum(mov.entradaquantidade) as entradaquantidade, 
  	sum(mov.entradavalor) as entradavalor, 
  	sum(mov.saidaquantidade) as saidaquantidade,
  	sum(mov.saidavalor) as saidavalor
  from tblestoquemovimento mov
  group by mov.codestoquemes
)
select 	' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || mes.codestoquemes || '&', *
from tblestoquemes mes
left join tot on (mes.codestoquemes = tot.codestoquemes)
where coalesce(tot.entradaquantidade, 0) != coalesce(mes.entradaquantidade, 0) 
or coalesce(tot.entradavalor, 0) != coalesce(mes.entradavalor, 0)
or coalesce(tot.saidaquantidade, 0) != coalesce(mes.saidaquantidade, 0)
or coalesce(tot.saidavalor, 0) != coalesce(mes.saidavalor, 0)
--and mes.codestoquemes = 3405118
order by mes.codestoquemes 