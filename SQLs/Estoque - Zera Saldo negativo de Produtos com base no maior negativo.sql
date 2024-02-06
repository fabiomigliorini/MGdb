drop materialized view mvwtmpsaldosiniciais

-- verifica o negativo maximo e o primeiro mes pra jogar como saldo inicial
create materialized view mvwtmpsaldosiniciais as 
with sld as (
	select 
		sld.codestoquesaldo, 
		sld.customedio,
		(select m2.codestoquemes from tblestoquemes m2 where m2.codestoquesaldo = sld.codestoquesaldo order by m2.saldoquantidade asc limit 1) as codestoquemes_negativo,
		(select m2.codestoquemes from tblestoquemes m2 where m2.codestoquesaldo = sld.codestoquesaldo order by m2.mes asc limit 1) as codestoquemes_inicial
	from tblprodutovariacao pv
	inner join tblestoquelocalprodutovariacao elpv on (elpv.codprodutovariacao = pv.codprodutovariacao)
	inner join tblestoquesaldo sld on (sld.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao)
	where pv.codproduto = 69118
)
select
	sld.codestoquesaldo,
	coalesce(
		nullif(neg.customedio, 0),
		nullif(sld.customedio, 0),
		0.86) as customedio,
	neg.saldoquantidade,
	ini.codestoquemes,
	neg.mes as negativo,
	ini.mes as corrigir
from sld
inner join tblestoquemes neg on (neg.codestoquemes = sld.codestoquemes_negativo)
inner join tblestoquemes ini on (ini.codestoquemes = sld.codestoquemes_inicial)
where neg.saldoquantidade < 0


-- 5) Criar o movimento do estoque
insert into tblestoquemovimento 
	(codestoquemes, codestoquemovimentotipo, entradaquantidade, entradavalor, saidaquantidade, saidavalor, manual, data, criacao, codusuariocriacao, alteracao, codusuarioalteracao, observacoes)
select 
	z.codestoquemes, 
	1001 as codestoquemovimentotipo, --saldo inicial
	abs(z.saldoquantidade) as entradaquantidade,
	abs(z.saldoquantidade) * z.customedio as entradavalor,
	null as saidaquantidade,
	null as saidavalor,
	true as manual,
	corrigir as data,
	date_trunc('second', now()) as criacao,
	1 as codusuariocriacao,
	date_trunc('second', now()) as alteracao,
	1 as codusuarioalteracao,
	'Lançamento automático de saldo inicial' as observacoes
from mvwtmpsaldosiniciais z

--recalculou o saldo
select ' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || codestoquemes  || ' & '
from mvwtmpsaldosiniciais 


-- 6) Recalcular movimento mes para o que nao bate com o movimento 
-- Executar 4 Vezes, comparando quantidade e valor da entrada e da saida
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

