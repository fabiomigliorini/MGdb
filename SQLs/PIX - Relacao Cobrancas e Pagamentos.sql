-- Forca reconsultar
select ' curl ''https://api.mgspa.mgpapelaria.com.br/api/v1/pix/cob/' || pc.codpixcob || '/consultar'' -X ''POST'' -H ''Accept: application/json'' --range 0-200', pc.criacao, u.usuario, pc.valororiginal, n.codnegocio
 from tblpixcob pc
left join tblpix p on (p.codpixcob = pc.codpixcob)
left join tblnegocio n on (n.codnegocio = pc.codnegocio)
left join tblusuario u on (u.codusuario = n.codusuario)
where pc.codpixcobstatus != 4 -- Expirado
and p.codpix is null
--and pc.codpixcob = 10032
--order by pc.criacao desc
order by pc.criacao desc
offset 400
limit 100

-- Forca reconsultar
select count(*)
 from tblpixcob pc
left join tblpix p on (p.codpixcob = pc.codpixcob)
left join tblnegocio n on (n.codnegocio = pc.codnegocio)
left join tblusuario u on (u.codusuario = n.codusuario)
where pc.codpixcobstatus != 4 -- Expirado
and p.codpix is null

select * from tblpixcob where codnegocio = 2873244

select * from tblnegocio where codnegocio = 2873244


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

select pc.codnegocio, p.valor  
from tblpix p
inner join tblpixcob pc on (pc.codpixcob = p.codpixcob)


-- fechado a vista e a prazo
with c as (
	select pc.codnegocio, sum(p.valor) as valor
	from tblpix p
	inner join tblpixcob pc on (pc.codpixcob = p.codpixcob)
	group by pc.codnegocio
),
p as (
	select nfp.codnegocio, sum(nfp.valorpagamento) as valorpagamento 
	from tblnegocioformapagamento nfp 
	where nfp.codformapagamento not in (00001010, 00005605, 00002010, 00001030, 5604) --Dinheiro, Stone, Cartao, vale, PIX
	group by nfp.codnegocio
)
select coalesce(c.valor, 0), coalesce(p.valorpagamento, 0), coalesce(n.valortotal, 0), * 
from tblnegocio n
inner join p on (p.codnegocio = n.codnegocio)
inner join c on (c.codnegocio = n.codnegocio)
where n.codnegociostatus = 2
and coalesce(c.valor, 0) + coalesce(p.valorpagamento, 0) > coalesce(n.valortotal, 0)
order by n.lancamento desc
--and n.codnegocio = 2381383


select valorpagamento, * from tblnegocioformapagamento t 
where codusuariocriacao is not null
and codnegocio = 2857690


select codpessoa
from tblpessoa p
where p.cnpj = :cnpj 
and regexp_replace(p.ie, '[^0-9]+', '', 'g')::numeric = :ie

select * from tblstonefilial t 



select * from tblstonepos t where serialnumber  = '6M493665'


select * from tblproduto order by criacao desc nulls last 

delete from tblmercospedido

select * from tblnegocio where codnegocio = 2848205