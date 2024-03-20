select p.valor, p.nome, p.horario, n.codnegocio 
from tblpix p
inner join tblpixcob pc on (pc.codpixcob = p.codpixcob)
inner join tblnegocio n on (n.codnegocio = pc.codnegocio)
where p.horario between '2024-02-15 00:00:00' and '2024-02-15 23:59:59'
and n.codusuario = 302145


with pix as (
	select n.codnegocio, sum(p.valor) as valorpix 
	from tblpix p
	inner join tblpixcob pc on (pc.codpixcob = p.codpixcob)
	inner join tblnegocio n on (n.codnegocio = pc.codnegocio)
	--where p.horario between '2024-02-15 00:00:00' and '2024-02-15 23:59:59'
	--and n.codusuario = 302145
	group by n.codnegocio 
),
stone as (
	select ped.codnegocio, sum(ped.valorpagoliquido)  as valorstone
	from tblpagarmepedido ped
	group by ped.codnegocio
)
select 
	n.codnegocio, 
	p.fantasia,
	n.valoraprazo, 
	n.valoravista, 
	pix.valorpix, 
	stone.valorstone, 
	coalesce(n.valoravista, 0) 
		- coalesce(pix.valorpix, 0)
		- coalesce(stone.valorstone, 0) as diferenca
from tblnegocio n
left join pix on (pix.codnegocio = n.codnegocio)
left join stone on (stone.codnegocio = n.codnegocio)
left join tblpessoa p on (p.codpessoa = n.codpessoa)
where n.lancamento between '2024-02-15 00:00:00' and '2024-02-15 23:59:59'
and n.codnegociostatus = 2
and n.codusuario = 302145
order by n.valortotal desc


