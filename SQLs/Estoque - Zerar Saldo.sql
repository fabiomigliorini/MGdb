refresh materialized view mvwestoque2024;

-- 1) Seleciona Produtos para zerar (inativos)
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
from mvwestoque2024 e
inner join tblprodutovariacao pv on (pv.codproduto = e.codproduto)
inner join tblproduto p on (p.codproduto = pv.codproduto)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codprodutovariacao = pv.codprodutovariacao)
inner join tblestoquelocal el on (el.codestoquelocal = elpv.codestoquelocal and el.codfilial = e.codfilial)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = true)
inner join tblestoquemes mes on (mes.codestoquemes = (select iq.codestoquemes from tblestoquemes iq where iq.codestoquesaldo = es.codestoquesaldo and iq.mes <= '2024-12-31' order by iq.mes desc limit 1) )
where p.inativo is not null
and mes.saldoquantidade != 0


-- 1) Seleciona Produtos para zerar (negativos)
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
from mvwestoque2024 e
inner join tblprodutovariacao pv on (pv.codproduto = e.codproduto)
inner join tblproduto p on (p.codproduto = pv.codproduto)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codprodutovariacao = pv.codprodutovariacao)
inner join tblestoquelocal el on (el.codestoquelocal = elpv.codestoquelocal and el.codfilial = e.codfilial)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = true)
inner join tblestoquemes mes on (mes.codestoquemes = (select iq.codestoquemes from tblestoquemes iq where iq.codestoquesaldo = es.codestoquesaldo and iq.mes <= '2024-12-31' order by iq.mes desc limit 1) )
where e.quant < 0
and mes.saldoquantidade < 0


-- 1) Seleciona Produtos para zerar saldos positivos de um produto anteriores a 2022 (fisico e fiscal)
drop table tmpestoquezerar ;
create table tmpestoquezerar as 
with sld as (
	select 
		pv.codproduto,
		p.preco,
		elpv.codestoquelocal,
		elpv.codestoquelocalprodutovariacao,
		elpv.codprodutovariacao,
		es.codestoquesaldo,
		es.saldoquantidade,
		(
			select em.codestoquemes 
			from tblestoquemes em 
			where em.codestoquesaldo = es.codestoquesaldo
			and em.mes <= '2024-12-31' -- ano
			order by mes desc 
			limit 1
		)	
	from tblprodutovariacao pv
	inner join tblproduto p on (p.codproduto = pv.codproduto)
	inner join tblestoquelocalprodutovariacao elpv on (elpv.codprodutovariacao = pv.codprodutovariacao)
	inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao)
	where pv.codproduto in (307422, 107438, 30725, 45283, 5090, 7757, 3428)-- produto
	and elpv.codestoquelocal != 101001
--	and es.fiscal = true
)
select 
	sld.codproduto, 
	sld.codestoquelocal, 
	sld.codprodutovariacao, 
	sld.codestoquelocalprodutovariacao, 
	sld.codestoquesaldo,
	(
		select min(iq.saldoquantidade) 
		from tblestoquemes iq 
		where iq.codestoquesaldo  = mes.codestoquesaldo
		and iq.mes >= mes.mes
	) as saldoquantidade,
	mes.codestoquemes,
	mes.customedio,
	mes.mes,
	sld.preco,
	CASE 
		WHEN coalesce(mes.customedio, 0) = 0 
		THEN sld.preco * 0.7
	    ELSE mes.customedio 
	END	as custoutilizar
from sld
inner join tblestoquemes mes on (mes.codestoquemes = sld.codestoquemes)

delete from tblestoquemovimento where manual and observacoes = 'Zeramento automatico dos produtos sem movimento a 2 anos.' and codestoquemes in (
	select codestoquemes from tmpestoquezerar
)


-- 1) zera produtos com mesmo estoque de 2 anos atras
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
	--sum (atu.valor)
from mvwestoque2024 e
inner join mvwestoque2022 pas on (pas.codproduto = e.codproduto and pas.codfilial = e.codfilial)
inner join tblprodutovariacao pv on (pv.codproduto = e.codproduto)
inner join tblproduto p on (p.codproduto = pv.codproduto)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codprodutovariacao = pv.codprodutovariacao)
inner join tblestoquelocal el on (el.codestoquelocal = elpv.codestoquelocal and el.codfilial = e.codfilial)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = true)
inner join tblestoquemes mes on (mes.codestoquemes = (select iq.codestoquemes from tblestoquemes iq where iq.codestoquesaldo = es.codestoquesaldo and iq.mes <= '2024-12-31' order by iq.mes desc limit 1) )
where e.quant = pas.quant 
and e.valor = pas.valor


-- 1) Zerar produtos com saldo mas valor zerado
drop table tmpestoquezerar ;
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
	--sum (atu.valor)
from mvwestoque2024 e
inner join tblprodutovariacao pv on (pv.codproduto = e.codproduto)
inner join tblproduto p on (p.codproduto = pv.codproduto)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codprodutovariacao = pv.codprodutovariacao)
inner join tblestoquelocal el on (el.codestoquelocal = elpv.codestoquelocal and el.codfilial = e.codfilial)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = true)
inner join tblestoquemes mes on (mes.codestoquemes = (select iq.codestoquemes from tblestoquemes iq where iq.codestoquesaldo = es.codestoquesaldo and iq.mes <= '2024-12-31' order by iq.mes desc limit 1) )
where e.valor = 0 
and e.quant != 0
and e.produto ilike 'Verao %'
-- *****


-- 2) Cria o Mes de dez/2024 caso nao exista
insert into tblestoquemes (codestoquesaldo, mes, codusuariocriacao, codusuarioalteracao, criacao, alteracao)
select 
	codestoquesaldo,
	'2024-12-01' as mes,
	1 as codusuariocriacao,
	1 as codusuarioalteracao,
	date_trunc('second', now()) as criacao,
	date_trunc('second', now()) as alteracao
from tmpestoquezerar 
where mes != '2024-12-01'

-- 3) Calcula o saldo dos meses criados
select 
	codestoquemes, 
	' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || codestoquemes || '&' 
from tblestoquemes 
where saldoquantidade is null order by mes



-- 4) repetir o Passo 1 para pegar o codigo do mes correto
select * from tmpestoquezerar where saldoquantidade != 0 order by 1, 2, 3


-- 5) Criar o movimento do estoque
insert into tblestoquemovimento 
	(codestoquemes, codestoquemovimentotipo, entradaquantidade, entradavalor, saidaquantidade, saidavalor, manual, data, criacao, codusuariocriacao, alteracao, codusuarioalteracao, observacoes)
select 
	z.codestoquemes, 
	1002 as codestoquemovimentotipo,
	case when z.saldoquantidade < 0 then abs(z.saldoquantidade) else null end as entradaquantidade,
	case when z.saldoquantidade < 0 then abs(z.saldoquantidade) * z.custoutilizar else null end as entradavalor,
	case when z.saldoquantidade > 0 then abs(z.saldoquantidade) else null end as saidaquantidade,
	case when z.saldoquantidade > 0 then abs(z.saldoquantidade) * z.custoutilizar else null end as saidavalor,
	true as manual,
	(date_trunc('month', z.mes) + interval '1 month' - interval '1 second') as data,
	date_trunc('second', now()) as criacao,
	1 as codusuariocriacao,
	date_trunc('second', now()) as alteracao,
	1 as codusuarioalteracao,
	'Zeramento automatico dos produtos fechamento estoque fiscal dez/2024.' as observacoes
from tmpestoquezerar z
where z.saldoquantidade != 0


select codestoquemes, ' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || codestoquemes  || ' & '
from tmpestoquezerar 
order by codestoquemes asc
limit 5000
--offset 20000

select ' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || codestoquemes  --|| '& '
from tblestoquemovimento 
where observacoes = 'Zeramento automatico dos produtos sem movimento a 2 anos.'  
order by codestoquemes asc
--limit 1000

/*
delete from tblestoquemovimento
where manual = true
and observacoes = 'Zeramento automatico dos produtos sem movimento a 2 anos.'
and codestoquemes in (select codestoquemes from tmpestoquezerar)
*/

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
select 	'curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || mes.codestoquemes || '&', *
from tblestoquemes mes
left join tot on (mes.codestoquemes = tot.codestoquemes)
where coalesce(tot.entradaquantidade, 0) != coalesce(mes.entradaquantidade, 0)
--where coalesce(tot.entradavalor, 0) != coalesce(mes.entradavalor, 0)
or coalesce(tot.saidaquantidade, 0) != coalesce(mes.saidaquantidade, 0)
--where coalesce(tot.saidavalor, 0) != coalesce(mes.saidavalor, 0)
--and mes.codestoquemes = 3405118
order by mes.codestoquemes  desc

