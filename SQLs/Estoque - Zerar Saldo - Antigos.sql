-- 1.1) Seleciona Produtos para zerar (INATIVOS)
drop table tmpestoquezerar;
create table tmpestoquezerar as 
select 
	e.codproduto, 
	el.codestoquelocal, 
	pv.codprodutovariacao, 
	elpv.codestoquelocalprodutovariacao, 
	es.codestoquesaldo,
	mes.saldoquantidade, 
	mes.codestoquemes,
	mes.customedio,
	mes.mes,
	p.preco,
	--CASE WHEN coalesce(mes.customedio, 0) > (p.preco * 0.8) THEN p.preco * 0.7
	--   WHEN coalesce(mes.customedio, 0) < (p.preco * 0.4) THEN p.preco * 0.7
	CASE WHEN coalesce(mes.customedio, 0) = 0 THEN p.preco * 0.7
	     ELSE mes.customedio 
	END	as custoutilizar
from mvwestoque2022 e
inner join tblprodutovariacao pv on (pv.codproduto = e.codproduto)
inner join tblproduto p on (p.codproduto = pv.codproduto)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codprodutovariacao = pv.codprodutovariacao)
inner join tblestoquelocal el on (el.codestoquelocal = elpv.codestoquelocal and el.codfilial = e.codfilial)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = true)
inner join tblestoquemes mes on (mes.codestoquemes = (select iq.codestoquemes from tblestoquemes iq where iq.codestoquesaldo = es.codestoquesaldo and iq.mes <= '2022-12-31' order by iq.mes desc limit 1) )
WHERE p.inativo IS NOT null
select * from tmpestoquezerar;


-- 1.2) Seleciona Produtos para zerar (NEGATIVOS)
REFRESH MATERIALIZED VIEW mvwestoque2022 ;
drop table tmpestoquezerar;
create table tmpestoquezerar as 
with zerar as (
	select a.*
	from mvwestoque2022 a
	where a.quant < 0
)
select 
	e.codproduto, 
	el.codestoquelocal, 
	pv.codprodutovariacao, 
	elpv.codestoquelocalprodutovariacao, 
	es.codestoquesaldo,
	mes.saldoquantidade, 
	mes.codestoquemes,
	mes.customedio,
	mes.mes,
	p.preco,
	--CASE WHEN coalesce(mes.customedio, 0) > (p.preco * 0.8) THEN p.preco * 0.7
	--   WHEN coalesce(mes.customedio, 0) < (p.preco * 0.4) THEN p.preco * 0.7
	CASE WHEN coalesce(mes.customedio, 0) = 0 THEN p.preco * 0.7
	     ELSE mes.customedio 
	END	as custoutilizar
from mvwestoque2022 e
inner join tblprodutovariacao pv on (pv.codproduto = e.codproduto)
inner join tblproduto p on (p.codproduto = pv.codproduto)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codprodutovariacao = pv.codprodutovariacao)
inner join tblestoquelocal el on (el.codestoquelocal = elpv.codestoquelocal and el.codfilial = e.codfilial)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = true)
inner join tblestoquemes mes on (mes.codestoquemes = (select iq.codestoquemes from tblestoquemes iq where iq.codestoquesaldo = es.codestoquesaldo and iq.mes <= '2022-12-31' order by iq.mes desc limit 1) )
inner join zerar z on (z.codfilial = el.codfilial and z.codproduto = p.codproduto)
select * from tmpestoquezerar;


-- 1.3) Seleciona Produtos para zerar (2 ANOS SEM MOVIMENTO)
REFRESH MATERIALIZED VIEW mvwestoque2022 ;
refresh materialized view mvwestoque2020;
drop table tmpestoquezerar;
create table tmpestoquezerar as 
with zerar as (
	select a.*
	from mvwestoque2020 a
	inner join mvwestoque2022 b on (b.codproduto = a.codproduto and b.codfilial = a.codfilial) 
	where a.quant = b.quant
	--group by a.codfilial 
)
select 
	e.codproduto, 
	el.codestoquelocal, 
	pv.codprodutovariacao, 
	elpv.codestoquelocalprodutovariacao, 
	es.codestoquesaldo,
	mes.saldoquantidade, 
	mes.codestoquemes,
	mes.customedio,
	mes.mes,
	p.preco,
	--CASE WHEN coalesce(mes.customedio, 0) > (p.preco * 0.8) THEN p.preco * 0.7
	--   WHEN coalesce(mes.customedio, 0) < (p.preco * 0.4) THEN p.preco * 0.7
	CASE WHEN coalesce(mes.customedio, 0) = 0 THEN p.preco * 0.7
	     ELSE mes.customedio 
	END	as custoutilizar
from mvwestoque2022 e
inner join tblprodutovariacao pv on (pv.codproduto = e.codproduto)
inner join tblproduto p on (p.codproduto = pv.codproduto)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codprodutovariacao = pv.codprodutovariacao)
inner join tblestoquelocal el on (el.codestoquelocal = elpv.codestoquelocal and el.codfilial = e.codfilial)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = true)
inner join tblestoquemes mes on (mes.codestoquemes = (select iq.codestoquemes from tblestoquemes iq where iq.codestoquesaldo = es.codestoquesaldo and iq.mes <= '2022-12-31' order by iq.mes desc limit 1) )
inner join zerar z on (z.codfilial = el.codfilial and z.codproduto = p.codproduto)
--WHERE p.inativo IS NOT null
--where mes.mes <= '2018-12-31'
where mes.saldoquantidade != 0
limit 100000;
select * from tmpestoquezerar t order by 1, 2, 3


-- adiciona mes para zerar
alter table tmpestoquezerar add codestoquemeszerar bigint

-- seta valor pra coluna
update tmpestoquezerar set codestoquemeszerar = nextval('tblestoquemes_codestoquemes_seq') where mes != '2022-12-01'

update tmpestoquezerar set codestoquemeszerar = codestoquemes where mes = '2022-12-01'

-- 2) Cria o Mes de dez/2022 caso nao exista
insert into tblestoquemes (codestoquemes, codestoquesaldo, mes, codusuariocriacao, codusuarioalteracao, criacao, alteracao)
select 
    codestoquemeszerar,
	codestoquesaldo,
	'2022-12-01' as mes,
	1 as codusuariocriacao,
	1 as codusuarioalteracao,
	date_trunc('second', now()) as criacao,
	date_trunc('second', now()) as alteracao
from tmpestoquezerar 
where mes != '2022-12-01'


-- 5) Criar o movimento do estoque
insert into tblestoquemovimento 
	(codestoquemes, codestoquemovimentotipo, entradaquantidade, entradavalor, saidaquantidade, saidavalor, manual, data, criacao, codusuariocriacao, alteracao, codusuarioalteracao, observacoes)
select 
	z.codestoquemeszerar, 
	1002 as codestoquemovimentotipo,
	case when z.saldoquantidade < 0 then abs(z.saldoquantidade) else null end as entradaquantidade,
	case when z.saldoquantidade < 0 then abs(z.saldoquantidade) * z.custoutilizar else null end as entradavalor,
	case when z.saldoquantidade > 0 then abs(z.saldoquantidade) else null end as saidaquantidade,
	case when z.saldoquantidade > 0 then abs(z.saldoquantidade) * z.custoutilizar else null end as saidavalor,
	true as manual,
	'2022-12-31 23:59:59' as data,
	date_trunc('second', now()) as criacao,
	1 as codusuariocriacao,
	date_trunc('second', now()) as alteracao,
	1 as codusuarioalteracao,
	'Zeramento automatico dos produtos inativos do estoque fiscal de dezembro de 2022.' as observacoes
from tmpestoquezerar z

select ' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || codestoquemes  || ' & '
from tblestoquemovimento 
where observacoes = 'Zeramento automatico dos produtos inativos do estoque fiscal de dezembro de 2022.' 
order by codestoquemes desc

--delete from tblestoquemovimento where observacoes = 'Zeramento automatico dos produtos inativos do estoque fiscal de dezembro de 2022.';

select saldoquantidade * custoutilizar, codestoquemeszerar, * from tmpestoquezerar order by saldoquantidade * custoutilizar desc

-- 3) Calcula o saldo dos meses criados
select 
	codestoquemes, 
	' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || codestoquemes || ' & '
from tblestoquemes 
where saldoquantidade is null order by codestoquemes asc


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
where coalesce(tot.entradaquantidade, 0) != coalesce(mes.entradaquantidade, 0) or coalesce(tot.saidaquantidade, 0) != coalesce(mes.saidaquantidade, 0)
--where coalesce(tot.entradaquantidade, 0) != coalesce(mes.entradaquantidade, 0)
--where coalesce(tot.entradavalor, 0) != coalesce(mes.entradavalor, 0)
--where coalesce(tot.saidaquantidade, 0) != coalesce(mes.saidaquantidade, 0)
--where coalesce(tot.saidavalor, 0) != coalesce(mes.saidavalor, 0)
--and mes.codestoquemes = 3405118
order by mes.codestoquemes 

