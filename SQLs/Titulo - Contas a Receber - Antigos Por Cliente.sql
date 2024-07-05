select 
--	gc.grupocliente,
--	coalesce(ge.grupoeconomico, pes.fantasia) as cliente, 
	ge.codgrupoeconomico,
	ge.grupoeconomico,
	pes.codpessoa,
	pes.fantasia,
	max(t.vencimento),
--	tt.tipotitulo,
--	por.portador,
--	sum(case when vencimento < (now() - '1 year'::interval) then saldo else null end) as vencido_antigo,
--	sum(case when vencimento between (now() - '1 year'::interval) and (now() - '6 month'::interval) then saldo else null end) as vencido_ano,
--	sum(case when vencimento between (now() - '6 month'::interval) and (now() - '1 month'::interval) then saldo else null end) as vencido_semestre,
--	sum(case when vencimento between (now() - '1 month'::interval) and (now() - '2 day'::interval) then saldo else null end) as vencido_mes,
--	sum(case when vencimento between (now() - '2 day'::interval) and (now() + '30 day'::interval) then saldo else null end) as vencendo_mes,
--	sum(case when vencimento between (now() + '30 day'::interval) and (now() + '60 day'::interval) then saldo else null end) as vencendo_bimestre,
--	sum(case when vencimento between (now() + '60 day'::interval) and (now() + '1 year'::interval) then saldo else null end) as vencendo_ano,
--	sum(case when vencimento > (now() + '1 year'::interval) then saldo else null end) as vencendo_ano,
	sum(t.saldo) as total
from tbltitulo t
inner join tbltipotitulo tt on (tt.codtipotitulo = t.codtipotitulo)
left join tblportador por on (por.codportador = t.codportador)
left join tblpessoa pes on (pes.codpessoa = t.codpessoa)
left join tblgrupocliente gc on (gc.codgrupocliente = pes.codgrupocliente)
left join tblgrupoeconomico ge on (ge.codgrupoeconomico = pes.codgrupoeconomico)
where t.saldo != 0
and tt.receber = true
and coalesce(t.codportador, 0) != 00202035
and t.vencimento <= now() - '1 year'::interval
group by 	
	ge.codgrupoeconomico,
	ge.grupoeconomico,
	pes.codpessoa,
	pes.fantasia,
	coalesce(ge.grupoeconomico, pes.fantasia)
	--tt.tipotitulo,
	--gc.grupocliente,
	--por.portador
order by 	coalesce(ge.grupoeconomico, pes.fantasia)



select 
	tt.pagar,
	tt.receber,
	tt.tipotitulo,
	gc.grupocliente,
	por.portador,
	ge.grupoeconomico, 
	pes.fantasia,
	coalesce(ge.grupoeconomico, pes.fantasia) as grupoeconomicofantasia,
	tt.tipotitulo,
	t.numero,
	t.saldo,
	case 
		when vencimento < (now() - '2 day'::interval) then 'vencido' 
		else 'vencer' 
	end	as vencido,
	case 
		when vencimento < (now() - '1 year'::interval) then 'vencido_antigo'
		when vencimento between (now() - '1 year'::interval) and (now() - '6 month'::interval) then 'vencido_ano'
		when vencimento between (now() - '6 month'::interval) and (now() - '1 month'::interval) then 'vencido_semestre'
		when vencimento between (now() - '1 month'::interval) and (now() - '2 day'::interval) then 'vencido_mes'
		when vencimento between (now() - '2 day'::interval) and (now() + '30 day'::interval) then 'vencendo_mes'
		when vencimento between (now() + '30 day'::interval) and (now() + '60 day'::interval) then 'vencendo_bimestre'
		when vencimento between (now() + '60 day'::interval) and (now() + '1 year'::interval) then 'vencendo_ano'
		else 'vencendo_posterior'
	end as idade,
	t.vencimento
from tbltitulo t
inner join tbltipotitulo tt on (tt.codtipotitulo = t.codtipotitulo)
left join tblportador por on (por.codportador = t.codportador)
left join tblpessoa pes on (pes.codpessoa = t.codpessoa)
left join tblgrupocliente gc on (gc.codgrupocliente = pes.codgrupocliente)
left join tblgrupoeconomico ge on (ge.codgrupoeconomico = pes.codgrupoeconomico)
where t.saldo != 0


select * from tblpix where cpf = 04592750977

update tblnfeterceiroitem set margem = 25 where codprodutobarra  = 1004959 and margem is not null



update tblnotafiscalprodutobarra set codnegocioprodutobarra = null where codnotafiscal  = 2781268





select * from tbltituloagrupamento t order by criacao desc nulls last


select distinct nf.* 
from tblmovimentotitulo mov 
inner join tbltitulo t on (t.codtitulo = mov.codtitulo)
inner join tblnegocioformapagamento nfp on (nfp.codnegocioformapagamento = t.codnegocioformapagamento)
inner join tblnegocioprodutobarra npb on (npb.codnegocio = nfp.codnegocio)
inner join tblnotafiscalprodutobarra nfpb on (nfpb.codnegocioprodutobarra = npb.codnegocioprodutobarra)
inner join tblnotafiscal nf on (nf.codnotafiscal = nfpb.codnotafiscal)
inner join tblnaturezaoperacao nat on (nat.codnaturezaoperacao = nf.codnaturezaoperacao)
where mov.codtituloagrupamento = 35216
and nat.venda = true 
and nf.nfeautorizacao is not null
and nf.nfecancelamento is null
and nf.nfeinutilizacao is null


select distinct neg.* 
from tblmovimentotitulo mov 
inner join tbltitulo t on (t.codtitulo = mov.codtitulo)
inner join tblnegocioformapagamento nfp on (nfp.codnegocioformapagamento = t.codnegocioformapagamento)
inner join tblnegocio neg on (neg.codnegocio = nfp.codnegocio)
where mov.codtituloagrupamento = 35216
and neg.codnegociostatus = 2 



select distinct bol.* 
from tblmovimentotitulo mov 
inner join tbltitulo t on (t.codtitulo = mov.codtitulo)
inner join tbltituloboleto bol on (bol.codtitulo = t.codtitulo)
where mov.codtituloagrupamento = :codtituloagrupamento 
and t.saldo > 0
and bol.estadotitulocobranca = 1
