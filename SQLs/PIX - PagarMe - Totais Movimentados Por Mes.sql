-- Totais de PIX Movimentado
select
	to_char( date_trunc('month', p.horario), 'yyyy-mm-dd'),
	--pcs.pixcobstatus,
	count(p.codpix) as quantidade,
	sum(p.valor) as valor,
	round(sum(p.valor) / count(p.codpix), 2) as media
from tblpixcob t
inner join tblnegocio n on (n.codnegocio = t.codnegocio)
inner join tblusuario u on (u.codusuario = n.codusuario)
left join tblpix p on (p.codpixcob = t.codpixcob)
left join tblportador po on (po.codportador = t.codportador)
inner join tblpixcobstatus pcs on (pcs.codpixcobstatus = t.codpixcobstatus)
--where t.valororiginal >= 80
group by date_trunc('month', p.horario)
--order by t.codpixcobstatus, 2 DESC
order by 1 desc 


select 
	date_trunc('month', pag.transacao) as mes, 
	sum(valorpagamento) - sum(valorcancelamento) as valor, 
	count(pag.codpagarmepagamento) as quantidade,
	round((sum(valorpagamento) - sum(valorcancelamento)) / count(pag.codpagarmepagamento), 2) as media
from tblpagarmepagamento pag
group by date_trunc('month', pag.transacao)
order by 1 desc