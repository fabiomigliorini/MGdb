/*
drop table tblpagarmepagamento;
drop table tblpagarmepedido;
drop table tblpagarmepos ;
drop table tblpagarmebandeira;
*/


/*
select * from tblpagarmepagamento t  --where codpagarmepedido = 2

select * from tblpagarmepedido t

select * from tblpagarmebandeira t 

delete from tblpagarmepagamento ;
delete from tblpagarmepedido;
delete from tblpagarmepos;
delete from tblpagarmebandeira ;

*/

with tot as (
	select 
		pg.codpagarmepedido ,
		count(pg.codpagarmepagamento) as transacoes,
		sum(pg.valorpagamento) as valorpagamento,
		sum(pg.valorcancelamento) as valorcancelamento,
		max(pg.nome) as nome
	from tblpagarmepagamento pg 
	group by pg.codpagarmepedido
	--order by 3 desc nulls last
)
select ped.codpagarmepedido, ped.alteracao, tot.nome, tot.transacoes, tot.valorpagamento, ped.valorpago, tot.valorcancelamento, ped.valorcancelado, ped.valorpagoliquido 
from tblpagarmepedido ped 
left join tot on (tot.codpagarmepedido = ped.codpagarmepedido)
--where coalesce(ped.valorpago, 0) != coalesce(tot.valorpagamento, 0)
--or coalesce(ped.valorcancelado, 0) != coalesce(tot.valorcancelamento, 0)
--where ped.valor = 0.88
order by ped.alteracao desc
--where ped.codpagarmepedido  = 12


select 
	pg.codfilial,
	pos.serial,
	date_trunc('day', pg.transacao),
	count(pg.codpagarmepagamento) as transacoes,
	sum(pg.valorpagamento) as valorpagamento,
	sum(pg.valorcancelamento) as valorcancelamento
from tblpagarmepagamento pg
inner join tblpagarmepos pos on (pos.codpagarmepos = pg.codpagarmepos)
group by 	date_trunc('day', pg.transacao),
pg.codfilial,
	pos.serial
	order by 3, 1, 2

	
/*
select * from tblpagarmepagamento t where codpagarmepedido in (12)

update tblpagarmepagamento set valorpagamento = null, valorcancelamento = null where codpagarmepedido = 12

select * from tblpagarmepedido t where codpagarmepedido in (12)

update tblpagarmepedido set valorpago = null, valorcancelado = null, valorpagoliquido = null where codpagarmepedido = 12
*/

select codfilial, pagarmesk, pagarmeid from tblfilial where pagarmeid is not null

select codpagarmepedido, valor, status, fechado, * from tblpagarmepedido order by codpagarmepedido desc

select * from tblpagarmepos t 

select * from information_schema."columns" c where table_name='tblpagarmepedido' order by ordinal_position 

select * from tblpagarmepedido t where idpedido  ilike '%8B9P'

select t2.codnegocio, t.* 
from tblpagarmepagamento t
inner join tblpagarmepedido t2 on (t2.codpagarmepedido = t.codpagarmepedido)
where t.parcelas > 6 



-- Totais da Maquineta
select sum(pag.valorpagamento)
from tblpagarmepos p
inner join tblpagarmepagamento pag on (pag.codpagarmepos = p.codpagarmepos)
where p.codfilial = 104
and p.apelido ilike '%Alfa%'
and pag.transacao >= '2023-12-18 00:00:00'
order by pag.transacao desc

select fp.formapagamento, sum(nfp.valorpagamento), count(n.codnegocio) 
from tblnegocio n
left join tblnegocioformapagamento nfp on (nfp.codnegocio = n.codnegocio)
left join tblformapagamento fp on (fp.codformapagamento = nfp.codformapagamento)
where n.codusuario  = 00302161
and n.lancamento >= '2023-12-18 00:00:00'
and n.codnegociostatus = 2
group by fp.formapagamento


select n.codnegocio, n.valortotal, fp.codformapagamento, fp.formapagamento, nfp.valorpagamento 
from tblnegocio n
left join tblnegocioformapagamento nfp on (nfp.codnegocio = n.codnegocio)
left join tblformapagamento fp on (fp.codformapagamento = nfp.codformapagamento)
where n.codusuario  = 00302161
and n.lancamento >= '2023-12-18 00:00:00'
and n.codnegociostatus = 2
and nfp.codformapagamento =1010
order by n.lancamento desc




select vendedor, * 
from tblpessoa where vendedor  and inativo is null order by fantasia


select * from tblnegocio where codnegocio = 3392417