select f.filial, u.usuario, count(*), sum(n.valortotal), max(n.codnegocio), max(n.lancamento)
from tblpagarmepedido pp 
inner join tblnegocio n on (n.codnegocio = pp.codnegocio)
inner join tblfilial f on (f.codfilial = n.codfilial)
inner join tblusuario u on (u.codusuario = n.codusuario)
where pp.status = 2
and n.codnegociostatus = 1
group by f.filial, u.usuario
order by 1, 2


select f.filial, u.usuario, count(*), sum(n.valortotal), max(n.codnegocio), max(n.lancamento)
from tblpix p
inner join tblpixcob pc on (pc.codpixcob = p.codpixcob)
inner join tblnegocio n on (n.codnegocio = pc.codnegocio)
inner join tblfilial f on (f.codfilial = n.codfilial)
inner join tblusuario u on (u.codusuario = n.codusuario)
where n.codnegociostatus = 1
group by f.filial, u.usuario
order by 1, 2
