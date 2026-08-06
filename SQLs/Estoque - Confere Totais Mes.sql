-- movimentacao do mes nao bate com totais
with mov as (
	select mov.codestoquemes, sum(saidaquantidade) saidaquantidade, sum(entradaquantidade) entradaquantidade
	from tblestoquemovimento mov
	group by mov.codestoquemes
)
select ' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || mes.codestoquemes, mes.codestoquemes
from tblestoquemes mes 
left join mov on (mes.codestoquemes = mov.codestoquemes)
where mes.codestoquesaldo in (
	select es.codestoquesaldo
	from tblestoquelocalprodutovariacao elpv
	inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao)
	--where elpv.codprodutovariacao = :codprodutovariacao
	)
and coalesce(mes.saidaquantidade, 0) != coalesce(mov.saidaquantidade, 0)
and coalesce(mes.entradaquantidade, 0) != coalesce(mov.entradaquantidade, 0)
--limit 10


-- SALDO INICIAL MES NAO BATE COM FINAL DO MES ANTERIOR
select 
	' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || mes.codestoquemes,
	mes.codestoquemes, 
	mes.mes, 
	mes.inicialquantidade, 
	(select m2.saldoquantidade from tblestoquemes m2 where m2.codestoquesaldo = mes.codestoquesaldo and m2.mes < mes.mes order by m2.mes desc limit 1) as anterior,
	mes.saldoquantidade,
	mes.*
from tblestoquemes mes 
where mes.codestoquesaldo in (
	select es.codestoquesaldo
	from tblestoquelocalprodutovariacao elpv
	inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao)
	--where elpv.codprodutovariacao = :codprodutovariacao
	)
and coalesce(mes.inicialquantidade, 0) != 
	coalesce((select m2.saldoquantidade from tblestoquemes m2 where m2.codestoquesaldo = mes.codestoquesaldo and m2.mes < mes.mes order by m2.mes desc limit 1), 0)


-- Transferencia pro mesmo local
select ', ' || em.codestoquemovimento::varchar || ', ' || em.codestoquemovimentoorigem::varchar, em.codestoquemes, em.entradaquantidade, em.saidaquantidade --* 
from tblestoquemovimento em
inner join tblestoquemovimento emo on (em.codestoquemovimentoorigem = emo.codestoquemovimento)
where em.codestoquemes = emo.codestoquemes
and em.manual

/*
 * 
-- Apaga Transferencias pro mesmo local
Delete from tblestoquemovimento where codestoquemovimento in (
null
, 15072142, 15072141
, 20513009, 20513008
, 15072136, 15072135
, 16194347, 16194346
, 21610436, 21610435
, 24926521, 24926520
, 17608774, 17608773
, 17863827, 17863826
, 20028133, 20028132
, 17863837, 17863836
, 17863840, 17863839
, 20028135, 20028134
, 16342210, 16342209
, 20028137, 20028136
, 20028150, 20028149
, 16342243, 16342242
, 17863845, 17863844
, 17608786, 17608785
, 20028183, 20028182
, 17608782, 17608781
, 16342328, 16342327
, 9525636, 9525635
, 4251324, 4251323
, 8474877, 8474876
, 22829804, 22829803
, 16342341, 16342340
, 17608793, 17608792
, 17608780, 17608779
, 17863842, 17863841
, 26678124, 26678123
, 26678007, 26678006
, 26678017, 26678016
, 26678027, 26678026
, 26677974, 26677973
, 26678020, 26678019
, 26678118, 26678117
, 26678113, 26678112
, 26678115, 26678114
, 26678126, 26678125
, 26678025, 26678024
, 26678120, 26678119
, 26678012, 26678011
, 26670188, 26670187
, 26670180, 26670179
, 21753358, 21753357
, 25937688, 25937687
, 25937657, 25937656
, 25937690, 25937689
, 25937707, 25937706
, 21924035, 21924034
, 22903627, 22903626
, 24926553, 24926552
, 24891355, 24891354
, 21320566, 21320564
, 5645672, 5645671
, 7021782, 7021781
, 24618676, 24618675
, 15684457, 15684456
, 15684478, 15684477
, 17802295, 17802294
, 24534292, 24534291
, 28458545, 28458544
)
  
 * 
 * 
 */

--TODO: CUSTO MEDIO ENTRADA DIFERENTE DA SAIDA

--TODO: QUANTIDADE ENTRADA DIFERENTE SAIDA

--TODO: SAIDA TRANSFERENCIA SEM ENTRADA TRANSFERENCIA

-- DIFERENCA MAIOR QUE 2% ENTRE CUSTO DE ORIGEM E DESTINO
with mov as (
	select 
		em.codestoquemes, 
		emo.codestoquemes as codestoquemes_origem,
		coalesce(em.entradaquantidade, 0) - coalesce(em.saidaquantidade, 0) as quantidade, 
		coalesce(emo.saidaquantidade, 0) - coalesce(emo.entradaquantidade, 0) as quantidade_origem, 
		coalesce(em.entradavalor, 0) - coalesce(em.saidavalor, 0) as valor, 
		coalesce(emo.saidavalor, 0) - coalesce(emo.entradavalor, 0) as valor_origem
	from tblestoquemovimento em
	inner join tblestoquemovimento emo on (em.codestoquemovimentoorigem = emo.codestoquemovimento)
	where em.codestoquemovimentotipo in (4101, 4201)
	and (coalesce(emo.saidavalor, 0) - coalesce(emo.entradavalor, 0)) > 0
)
select 
	*, 
	abs(1-coalesce(mov.valor, 0) / coalesce(mov.valor_origem, 0)) as perc_dif,
	' echo ' || row_number() over (ORDER BY mov.codestoquemes ASC) || ' && curl http://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || mov.codestoquemes::varchar
from mov 
where abs(1-coalesce(mov.valor, 0) / coalesce(mov.valor_origem, 0)) >= 0.1
order by 7 desc
--ORDER BY mov.codestoquemes ASC

-- SAIDAS COM CUSTO MEDIO INCORRETO
with mov as (
	select 
		em.codestoquemes, 
		em.saidaquantidade, 
		em.saidavalor, 
		(coalesce(mes.customedio, 0) * coalesce(em.saidaquantidade, 0))::numeric(14,2) as calculado
	from tblestoquemovimento em
	inner join tblestoquemes mes on (mes.codestoquemes = em.codestoquemes)
	inner join tblestoquemovimentotipo t on (t.codestoquemovimentotipo = em.codestoquemovimentotipo)
	where t.preco = 2
	and (coalesce(mes.customedio, 0) * coalesce(em.saidaquantidade, 0))::numeric(14,2) != 0
)
select * , 	' echo ' || row_number() over (ORDER BY mov.codestoquemes ASC) || ' && curl http://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || mov.codestoquemes::varchar
from mov
where abs(coalesce(mov.saidavalor, 0) - coalesce(mov.calculado, 1)) > 0.02
ORDER BY mov.codestoquemes asc

