﻿--Negocios Fechados Sem Movimentacao de estoque
select n.codfilial, n.codnegocio, n.lancamento, n.alteracao, npb.codnegocioprodutobarra, em.codestoquemovimento, p.codproduto, p.produto, ' curl http://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-negocio-produto-barra/' || cast(npb.codnegocioprodutobarra as varchar)
from tblnegocio n
inner join tblnaturezaoperacao no on (no.codnaturezaoperacao = n.codnaturezaoperacao)
inner join tblnegocioprodutobarra npb on (npb.codnegocio = n.codnegocio)
inner join tblprodutobarra pb on (pb.codprodutobarra = npb.codprodutobarra)
inner join tblproduto p on (p.codproduto = pb.codproduto)
inner join tbltipoproduto tp on (tp.codtipoproduto = p.codtipoproduto)
left join tblestoquemovimento em on (em.codnegocioprodutobarra = npb.codnegocioprodutobarra)
where n.codnegociostatus = 2
and n.lancamento >= '2016-04-01 00:00:00'
--and n.lancamento >= '2020-01-01 00:00:00'
--and n.lancamento >= now() - '360 days'::interval 
--and n.lancamento >= now() - '365 days'::interval
and npb.inativo is null
and tp.estoque = true
and no.estoque = true
and p.estoque = true
and em.codestoquemovimento is null
and n.codfilial in (101, 102, 103, 104, 105)
order by n.lancamento, n.codfilial, n.codnegocio, p.produto

--Negocios NAO Fechados Com Movimentacao de estoque
select n.codfilial, n.codnegocio, npb.codnegocioprodutobarra, em.codestoquemovimento, p.codproduto, p.produto, ' curl http://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-negocio-produto-barra/' || cast(npb.codnegocioprodutobarra as varchar)
from tblnegocio n
inner join tblnaturezaoperacao no on (no.codnaturezaoperacao = n.codnaturezaoperacao)
inner join tblnegocioprodutobarra npb on (npb.codnegocio = n.codnegocio)
inner join tblprodutobarra pb on (pb.codprodutobarra = npb.codprodutobarra)
inner join tblproduto p on (p.codproduto = pb.codproduto)
inner join tbltipoproduto tp on (tp.codtipoproduto = p.codtipoproduto)
left join tblestoquemovimento em on (em.codnegocioprodutobarra = npb.codnegocioprodutobarra)
where (n.codnegociostatus != 2 or npb.inativo is not null)
and n.lancamento >= '2016-04-01 00:00:00'
--and n.lancamento >= now() - '365 days'::interval 
and tp.estoque = true
and no.estoque = true
and p.estoque = true
and em.codestoquemovimento is not null
order by n.codfilial, n.codnegocio, p.produto

--Quantidade Negocio Diferente do Estoque
select n.codfilial, n.codnegocio, pb.codproduto, npb.codnegocioprodutobarra, em.codestoquemovimento, p.codproduto, p.produto, round((coalesce(em.entradaquantidade, 0) + coalesce(em.saidaquantidade, 0)), 1), round((npb.quantidade * coalesce(pe.quantidade, 1)), 1), ' curl http://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-negocio-produto-barra/' || cast(npb.codnegocioprodutobarra as varchar)
from tblnegocio n
inner join tblnaturezaoperacao no on (no.codnaturezaoperacao = n.codnaturezaoperacao)
inner join tblnegocioprodutobarra npb on (npb.codnegocio = n.codnegocio)
inner join tblprodutobarra pb on (pb.codprodutobarra = npb.codprodutobarra)
left join tblprodutoembalagem pe on (pe.codprodutoembalagem = pb.codprodutoembalagem)
inner join tblproduto p on (p.codproduto = pb.codproduto)
inner join tbltipoproduto tp on (tp.codtipoproduto = p.codtipoproduto)
inner join tblestoquemovimento em on (em.codnegocioprodutobarra = npb.codnegocioprodutobarra)
where n.codnegociostatus = 2
and n.lancamento >= '2016-04-01 00:00:00'
--and n.lancamento >= now() - '365 days'::interval 
and tp.estoque = true
and no.estoque = true
and p.estoque = true
--and p.codproduto = 75324
and round((coalesce(em.entradaquantidade, 0) + coalesce(em.saidaquantidade, 0)), 1) != round((npb.quantidade * coalesce(pe.quantidade, 1)), 1)
order by p.codproduto, n.codfilial, n.codnegocio, p.produto

--Notas Sem Movimentacao de estoque
select n.codfilial, n.codnotafiscal, n.saida, n.alteracao, npb.codnotafiscalprodutobarra, em.codestoquemovimento, p.codproduto, p.produto, ' curl http://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-nota-fiscal-produto-barra/' || cast(npb.codnotafiscalprodutobarra as varchar)
from tblnotafiscal n
inner join tblnaturezaoperacao no on (no.codnaturezaoperacao = n.codnaturezaoperacao)
inner join tblnotafiscalprodutobarra npb on (npb.codnotafiscal = n.codnotafiscal)
inner join tblprodutobarra pb on (pb.codprodutobarra = npb.codprodutobarra)
inner join tblproduto p on (p.codproduto = pb.codproduto)
inner join tbltipoproduto tp on (tp.codtipoproduto = p.codtipoproduto)
left join tblestoquemovimento em on (em.codnotafiscalprodutobarra = npb.codnotafiscalprodutobarra)
where ((n.emitida = true and n.nfeautorizacao is not null and n.nfeinutilizacao is null and n.nfecancelamento is null) or n.emitida = false)
--and n.saida >= '2016-01-01 00:00:00'
--and n.saida >= '2025-01-01 00:00:00'
and n.saida >= now() - '45 days'::interval 
and tp.estoque = true
and no.estoque = true
and p.estoque = true
and em.codestoquemovimento is null
order by n.saida, n.codfilial, n.codnotafiscal, p.produto
limit 300

--Notas Canceladas/Inutilizadas/Nao Autorizadas Com Movimentacao de estoque
select n.codfilial, n.codnotafiscal, npb.codnotafiscalprodutobarra, n.saida, em.codestoquemovimento, p.codproduto, p.produto, ' curl http://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-nota-fiscal-produto-barra/' || cast(npb.codnotafiscalprodutobarra as varchar)
from tblnotafiscal n
inner join tblnaturezaoperacao no on (no.codnaturezaoperacao = n.codnaturezaoperacao)
inner join tblnotafiscalprodutobarra npb on (npb.codnotafiscal = n.codnotafiscal)
inner join tblprodutobarra pb on (pb.codprodutobarra = npb.codprodutobarra)
inner join tblproduto p on (p.codproduto = pb.codproduto)
inner join tbltipoproduto tp on (tp.codtipoproduto = p.codtipoproduto)
left join tblestoquemovimento em on (em.codnotafiscalprodutobarra = npb.codnotafiscalprodutobarra)
where n.emitida = true
and (n.nfeautorizacao is null or n.nfeinutilizacao is not null or n.nfecancelamento is not null)
and n.saida >= '2016-01-01 00:00:00'
--and n.saida >= '2022-05-01 00:00:00'
--and n.saida >= now() - '180 days'::interval  
and tp.estoque = true
and no.estoque = true
and p.estoque = true
and em.codestoquemovimento is not null
order by n.codfilial, n.codnotafiscal, p.produto

--Quantidade Nota Diferente do Estoque
select n.codfilial, n.codnotafiscal, pb.codproduto, npb.codnotafiscalprodutobarra, em.codestoquemovimento, p.codproduto, p.produto, round((coalesce(em.entradaquantidade, 0) + coalesce(em.saidaquantidade, 0)), 1), round((npb.quantidade * coalesce(pe.quantidade, 1)), 1), ' curl http://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-nota-fiscal-produto-barra/' || cast(npb.codnotafiscalprodutobarra as varchar)
from tblnotafiscal n
inner join tblnaturezaoperacao no on (no.codnaturezaoperacao = n.codnaturezaoperacao)
inner join tblnotafiscalprodutobarra npb on (npb.codnotafiscal = n.codnotafiscal)
inner join tblprodutobarra pb on (pb.codprodutobarra = npb.codprodutobarra)
left join tblprodutoembalagem pe on (pe.codprodutoembalagem = pb.codprodutoembalagem)
inner join tblproduto p on (p.codproduto = pb.codproduto)
inner join tbltipoproduto tp on (tp.codtipoproduto = p.codtipoproduto)
inner join tblestoquemovimento em on (em.codnotafiscalprodutobarra = npb.codnotafiscalprodutobarra)
where n.saida >= '2016-01-01 00:00:00'
--where n.saida >= now() - '60 days'::interval 
and tp.estoque = true
and no.estoque = true
and p.estoque = true
and round((coalesce(em.entradaquantidade, 0) + coalesce(em.saidaquantidade, 0)), 1) != round((npb.quantidade * coalesce(pe.quantidade, 1)), 1)
order by p.codproduto, pb.codprodutobarra, n.codfilial, n.codnotafiscal, p.produto

-- Transferencia/Devolucao sem registro de origem
select em.codestoquemes, em.data, emt.descricao, EMT.CODESTOQUEMOVIMENTOTIPO, em.entradaquantidade, em.saidaquantidade, nfpb.codnotafiscal, npb.codnegocio, ' curl http://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-nota-fiscal-produto-barra/' || cast(nfpb.codnotafiscalprodutobarra as varchar)
from tblestoquemovimentotipo emt
inner join tblestoquemovimento em on (em.codestoquemovimentotipo = emt.codestoquemovimentotipo)
left join tblnotafiscalprodutobarra nfpb on (nfpb.codnotafiscalprodutobarra = em.codnotafiscalprodutobarra)
left join tblnegocioprodutobarra npb on (npb.codnegocioprodutobarra = em.codnegocioprodutobarra)
where emt.preco = 3
and em.codestoquemovimentoorigem is null 
and em.data >= '2016-01-01'
--and em.codnotafiscalprodutobarra is not null
--and nfpb.codnotafiscal  = 1093394
AND em.codestoquemovimentotipo = 4201 -- Transferencia Entrada
order by em.data, em.codestoquemes

-- Valor entrada diferente da saida nas transferencias
with recalcular as (
	select mov.codestoquemes, mes.codestoquesaldo, mes.mes
	from tblestoquemovimento mov
	inner join tblestoquemovimento orig on (orig.codestoquemovimento = mov.codestoquemovimentoorigem)
	inner join tblestoquemes mes on (mes.codestoquemes = mov.codestoquemes)
	inner join tblestoquesaldo sld on (sld.codestoquesaldo = mes.codestoquesaldo)
	where sld.fiscal = true
	and mov.entradaquantidade > 0
	and (abs(coalesce(mov.entradavalor, 0) - coalesce(orig.saidavalor, 0)) / coalesce(mov.entradaquantidade, 0)) > 0.01
	and coalesce(mov.entradaquantidade, 0) = coalesce(orig.saidaquantidade, 0)
)
select ' curl http://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || min(codestoquemes)::varchar, mes
from recalcular
group by codestoquesaldo, mes
order by 2, 1

--Estoque Negativo
select pv.codproduto, p.produto, coalesce(pv.variacao, '{ Sem Variacao }'), es.saldoquantidade, es.saldovalor, es.ultimaconferencia
from tblestoquesaldo es
inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocalprodutovariacao = es.codestoquelocalprodutovariacao)
inner join tblestoquelocal el on (el.codestoquelocal = elpv.codestoquelocal)
inner join tblprodutovariacao pv on (pv.codprodutovariacao = elpv.codprodutovariacao)
inner join tblproduto p on (p.codproduto = pv.codproduto)
where es.saldoquantidade < 0
and es.fiscal = true
and elpv.codestoquelocal in (101001)
--and p.produto ilike '%natal%'
order by p.produto, pv.variacao nulls first

--Estoque Sem Conferencia
select pv.codproduto, p.produto, coalesce(pv.variacao, '{ Sem Variacao }'), es.saldoquantidade, es.saldovalor, es.ultimaconferencia
from tblestoquesaldo es
inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocalprodutovariacao = es.codestoquelocalprodutovariacao)
inner join tblestoquelocal el on (el.codestoquelocal = elpv.codestoquelocal)
inner join tblprodutovariacao pv on (pv.codprodutovariacao = elpv.codprodutovariacao)
inner join tblproduto p on (p.codproduto = pv.codproduto)
where es.saldoquantidade > 0
and es.fiscal = false
and es.ultimaconferencia is null
and elpv.codestoquelocal in (101001)
order by p.produto, pv.variacao nulls first

-- Movimento da Variacao para quando quiser excluir
select mov.codnegocioprodutobarra, mov.codnotafiscalprodutobarra, mov.codestoquemes, mov.manual
from tblestoquelocalprodutovariacao elpv
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao)
inner join tblestoquemes em on (em.codestoquesaldo = es.codestoquesaldo)
inner join tblestoquemovimento mov on (mov.codestoquemes = em.codestoquemes)
where elpv.codprodutovariacao = 3419
order by 1, 2


update tblnotafiscal set nfeinutilizacao = :protocolo, nfedatainutilizacao = to_timestamp(:data, 'DD/MM/YYYY HH24:MI:SS')  where codnotafiscal = :codnotafiscal 
