/*
drop table tblpagarmepagamento;
drop table tblpagarmepedido;
drop table tblpagarmepos ;
drop table tblpagarmebandeira;
*/

select * from tblpagarmepagamento t  --where codpagarmepedido = 2

select * from tblpagarmepedido t

select * from tblpagarmebandeira t 


delete from tblpagarmepagamento ;
delete from tblpagarmepedido;
delete from tblpagarmepos;
delete from tblpagarmebandeira ;



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
select ped.codpagarmepedido, tot.nome, tot.transacoes, tot.valorpagamento, ped.valorpago, tot.valorcancelamento, ped.valorcancelado, ped.valorpagoliquido 
from tblpagarmepedido ped 
left join tot on (tot.codpagarmepedido = ped.codpagarmepedido)
--where coalesce(ped.valorpago, 0) != coalesce(tot.valorpagamento, 0)
--or coalesce(ped.valorcancelado, 0) != coalesce(tot.valorcancelamento, 0)
--where ped.valor = 0.88
order by ped.alteracao desc
--where ped.codpagarmepedido  = 12



select * from tblpagarmepagamento t where codpagarmepedido in (12)

update tblpagarmepagamento set valorpagamento = null, valorcancelamento = null where codpagarmepedido = 12

select * from tblpagarmepedido t where codpagarmepedido in (12)

update tblpagarmepedido set valorpago = null, valorcancelado = null, valorpagoliquido = null where codpagarmepedido = 12


