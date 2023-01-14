
with listagem as (
	with totais as (
		select mt.codliquidacaotitulo, mt.codportador, mt.transacao, sum(mt.debito) as debito, sum(mt.credito) as credito
		from tblmovimentotitulo mt
		where mt.codliquidacaotitulo is not null
		and mt.codtipomovimentotitulo = 600
		group by mt.codliquidacaotitulo, mt.codportador, mt.transacao
		order by 3 desc
	)
	select p.codpix, p.horario, p.nome, coalesce(p.cnpj, p.cpf) as cpf, p.valor, por.portador, t.codliquidacaotitulo, adto.codtitulo
	from tblpix p
	left join totais t on (t.codportador = p.codportador and t.transacao = date_trunc('day', p.horario) and t.credito = p.valor)
	left join tbltitulo adto on (adto.codportador = p.codportador and adto.transacao = date_trunc('day', p.horario) and adto.credito = p.valor AND adto.codtipotitulo = 220)
	inner join tblportador por on (por.codportador = p.codportador)
	where p.codpixcob is null
	and p.horario > now() - '15 days'::interval
	order by p.horario desc
)
select * from listagem where codliquidacaotitulo is null and codtitulo is null


-- Corrige Data
update tblliquidacaotitulo set transacao = :transacao  where codliquidacaotitulo = :codliquidacaotitulo

update tblmovimentotitulo set transacao = :transacao  where codliquidacaotitulo = :codliquidacaotitulo

select mt.codliquidacaotitulo, sum(mt.debito) as debito, sum(mt.credito) as credito
from tblmovimentotitulo mt
group by mt.codliquidacaotitulo

select * from tbltitulo where numero ilike 'V00002348%' order by numero desc


select * from tblnegocioformapagamento t where codnegocio = 2946843


select * from tblcest where cest ilike '0600700'


select codfilial, stonecode from tblfilial where codempresa = 1 order by codfilial

select *  from tblformapagamento t  where formapagamento ilike '%PIX%'

select * from tblnegocioformapagamento t where codformapagamento = 5604

--delete from tblformapagamento  where codformapagamento  = 5604


update tblnegocioforma
