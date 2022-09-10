-- Forca reconsultar
select 'curl ''https://api.mgspa.mgpapelaria.com.br/api/v1/pix/cob/' || pc.codpixcob || '/consultar'' -X ''POST'' -H ''Accept: application/json'' --range 0-200', pc.criacao, u.usuario, pc.valororiginal, n.codnegocio
 from tblpixcob pc
left join tblpix p on (p.codpixcob = pc.codpixcob)
left join tblnegocio n on (n.codnegocio = pc.codnegocio)
left join tblusuario u on (u.codusuario = n.codusuario)
where pc.codpixcobstatus != 4 -- Expirado
and p.codpix is null
--and pc.codpixcob = 10032
order by pc.criacao desc

-- PIXCob concluidos
select po.portador, p.horario, p.valor, p.nome, p.txid, n.codnegocio
from tblpixcob t
inner join tblnegocio n on (n.codnegocio = t.codnegocio)
inner join tblusuario u on (u.codusuario = n.codusuario)
inner join tblpix p on (p.codpixcob = t.codpixcob)
inner join tblportador po on (po.codportador = p.codportador)
where t.criacao >= '2021-10-13'
order by p.horario desc, po.portador asc,  p.valor, p.codpix

-- Totais de PIX Movimentado
select
	po.portador,
	--pcs.pixcobstatus,
	count(p.codpix) as quantidade,
	sum(p.valor) as valor,
	sum(p.valor) / count(p.codpix) as media,
	min(p.criacao) as de,
	max(p.criacao) as ate
from tblpixcob t
inner join tblnegocio n on (n.codnegocio = t.codnegocio)
inner join tblusuario u on (u.codusuario = n.codusuario)
left join tblpix p on (p.codpixcob = t.codpixcob)
left join tblportador po on (po.codportador = t.codportador)
inner join tblpixcobstatus pcs on (pcs.codpixcobstatus = t.codpixcobstatus)
group by po.portador --, pcs.pixcobstatus, t.codpixcobstatus
--order by t.codpixcobstatus, 2 DESC
order by 1


-- Totais de PIX Movimentado
select
	to_char( date_trunc('month', p.horario), 'yyyy-mm-dd'),
	--pcs.pixcobstatus,
	count(p.codpix) as quantidade,
	sum(p.valor) as valor,
	sum(p.valor) / count(p.codpix) as media
from tblpixcob t
inner join tblnegocio n on (n.codnegocio = t.codnegocio)
inner join tblusuario u on (u.codusuario = n.codusuario)
left join tblpix p on (p.codpixcob = t.codpixcob)
left join tblportador po on (po.codportador = t.codportador)
inner join tblpixcobstatus pcs on (pcs.codpixcobstatus = t.codpixcobstatus)
group by date_trunc('month', p.horario)
--order by t.codpixcobstatus, 2 DESC
order by 1 desc 

-- Marca PIXCOb com mais de duas horas de EXPIRADO
update tblpixcob
set codpixcobstatus = 4
where codpixcobstatus in (1, 3)
and criacao + (expiracao || ' second')::interval < now() - '1 DAY'::interval

update tblpixcob
set codpixcobstatus = 4
where codpixcob = :codpixcob



select t.valororiginal, pcs.pixcobstatus, t.criacao, t.solicitacaopagador
from tblpixcob t
inner join tblpixcobstatus pcs on (pcs.codpixcobstatus = t.codpixcobstatus)
order by t.criacao desc


select * from tblpixcob where solicitacaopagador ilike '%2603831%'


select * from tblnegocioformapagamento t where codnegocio = :codnegocio

select * from tblnegocio where codnegocio = :codnegocio  
