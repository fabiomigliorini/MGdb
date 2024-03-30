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
	group by n.codnegocio 
),
stone as (
	select ped.codnegocio, sum(ped.valorpagoliquido)  as valorstone
	from tblpagarmepedido ped
	group by ped.codnegocio
),
tit as (
	select nfp.codnegocio, sum(t.debito) as valortitulo
	from tblnegocioformapagamento nfp 
	inner join tbltitulo t on (nfp.codnegocioformapagamento = t.codnegocioformapagamento)
	group by nfp.codnegocio
)
select 
	n.codnegocio, 
	p.fantasia,
	n.valortotal, 
	pix.valorpix, 
	stone.valorstone, 
	tit.valortitulo,
	coalesce(n.valortotal, 0) 
		- coalesce(pix.valorpix, 0)
		- coalesce(stone.valorstone, 0) 
		- coalesce(tit.valortitulo, 0) 
		as valordiferenca
from tblnegocio n
inner join tblnaturezaoperacao nat on (nat.codnaturezaoperacao = n.codnaturezaoperacao)
left join pix on (pix.codnegocio = n.codnegocio)
left join stone on (stone.codnegocio = n.codnegocio)
left join tit on (tit.codnegocio = n.codnegocio)
left join tblpessoa p on (p.codpessoa = n.codpessoa)
where n.lancamento between :dia and :dia + '1 day'::interval - '1 second'::interval
and n.codnegociostatus = 2
and nat.financeiro = true
and n.codpdv = :codpdv 
order by n.valortotal desc


select * from tblpdv
