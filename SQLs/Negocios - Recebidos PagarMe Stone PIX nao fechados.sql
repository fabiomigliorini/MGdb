select f.filial, u.usuario, 'PagarMe', count(*), sum(n.valortotal), min(n.codnegocio), min(n.lancamento), max(n.codnegocio), max(n.lancamento)
from tblpagarmepedido pp 
inner join tblnegocio n on (n.codnegocio = pp.codnegocio)
inner join tblfilial f on (f.codfilial = n.codfilial)
inner join tblusuario u on (u.codusuario = n.codusuario)
where pp.status = 2
and n.codnegociostatus = 1
group by f.filial, u.usuario
union all
select f.filial, u.usuario, 'PIX', count(*), sum(n.valortotal), min(n.codnegocio), min(n.lancamento), max(n.codnegocio), max(n.lancamento)
from tblpix p
inner join tblpixcob pc on (pc.codpixcob = p.codpixcob)
inner join tblnegocio n on (n.codnegocio = pc.codnegocio)
inner join tblfilial f on (f.codfilial = n.codfilial)
inner join tblusuario u on (u.codusuario = n.codusuario)
where n.codnegociostatus = 1
group by f.filial, u.usuario
order by 1, 2, 3


select date_trunc('month', n.lancamento), 'PagarMe', count(*), sum(n.valortotal), max(n.codnegocio), max(n.lancamento)
from tblpagarmepedido pp 
inner join tblnegocio n on (n.codnegocio = pp.codnegocio)
inner join tblfilial f on (f.codfilial = n.codfilial)
inner join tblusuario u on (u.codusuario = n.codusuario)
where pp.status = 2
and n.codnegociostatus = 1
group by date_trunc('month', n.lancamento), f.filial, u.usuario



select 
	date_trunc('month', pp.transacao), 
	pp.tipo, 
	sum(pp.valorpagamento), 
	count(PP.codpagarmepagamento)
from tblpagarmepagamento pp
group by date_trunc('month', pp.transacao), PP.tipo 
order by 1 DESC, 2 DESC



select 
	date_trunc('month', P.horario),
	SUM(P.valor),
	COUNT(P.codpix)
from tblpix p
group by 	date_trunc('month', P.horario) order by 1 DESC



select * from tbldistribuicaodfe t where codfilial = 501 order by nsu desc