
with listagem as (
	with totais as (
		select mt.codliquidacaotitulo, mt.codportador, mt.transacao, sum(mt.debito) as debito, sum(mt.credito) as credito
		from tblmovimentotitulo mt
		where mt.codliquidacaotitulo is not null 
		and mt.codtipomovimentotitulo = 600
		group by mt.codliquidacaotitulo, mt.codportador, mt.transacao
		order by 3 desc
	)
	select p.horario, p.nome, coalesce(p.cnpj, p.cpf) as cpf, p.valor, t.codliquidacaotitulo, por.portador
	from tblpix p 
	left join totais t on (t.codportador = p.codportador and t.transacao = date_trunc('day', p.horario)  and t.credito = p.valor)
	inner join tblportador por on (por.codportador = p.codportador)
	where p.codpixcob is null
	and p.horario > now() - '15 days'::interval 
	order by p.horario desc
)
select * from listagem where codliquidacaotitulo is null

select * from tblpix where valor = 20.35 order by horario desc

select * from tblpixcob where codpixcob = 26022

select * from tblnegocioformapagamento t where codpixcob  = 26022

select * from tbltitulo where saldo < 0 and codpessoa = 1 


-- Corrige Data
update tblliquidacaotitulo set transacao = :transacao  where codliquidacaotitulo = :codliquidacaotitulo 

update tblmovimentotitulo set transacao = :transacao  where codliquidacaotitulo = :codliquidacaotitulo 

select mt.codliquidacaotitulo, sum(mt.debito) as debito, sum(mt.credito) as credito
from tblmovimentotitulo mt
group by mt.codliquidacaotitulo 



select pc.codnegocio, max(criacao), count(*)
from tblpixcob pc
group by pc.codnegocio
having count(*) > 1
order by 1 desc

select * from tblcest where cest ilike '0600700'


select codfilial, stonecode from tblfilial where codempresa = 1 order by codfilial 

select *  from tblformapagamento t  where formapagamento ilike '%PIX%'

select * from tblnegocioformapagamento t where codformapagamento = 5604

--delete from tblformapagamento  where codformapagamento  = 5604


update tblnegocioforma
