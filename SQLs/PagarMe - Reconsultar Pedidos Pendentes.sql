select 
	pp.criacao,
	pp.valor,
	pp.codfilial,
	pos.apelido, 
	' curl ''https://api-mgspa.mgpapelaria.com.br/api/v1/pagar-me/pedido/' || pp.codpagarmepedido || '/consultar''  -X POST -H ''Accept: application/json''' as consultar,
	' curl ''https://api-mgspa.mgpapelaria.com.br/api/v1/pagar-me/pedido/' || pp.codpagarmepedido || '''  -X DELETE -H ''Accept: application/json''' as cancelar,
	pp.valorcancelado, 
	pp.valorpagoliquido,
	pp.codpagarmepedido,
	pp.status,
	pp.codnegocio 
from tblpagarmepedido pp
left join tblpagarmepos pos on (pos.codpagarmepos = pp.codpagarmepos)
where pp.status = 1
--and pos.serial ilike '%6416'
--where pp.valor = 4.5
--and pp.codfilial = 102
--and pos.apelido ilike 'Charlie'
--where pp.idpedido = 'or_bJDXo5QuJu2oEzPx'
--where pp.codnegocio = 2916106
order by pp.criacao desc

select * from tblpagarmepedido t2 where codfilial = 103  

insert into tblpagarmepedido  (codfilial, idpedido, valor) values (105, 'or_bJDXo5QuJu2oEzPx', 2.9)

update tblnegocio set codnegociostatus = 1 where codnegocio = 2848563


select pp.codfilial,pos.codpagarmepos , pos.serial, pos.apelido, count(*)
from tblpagarmepedido pp
inner join tblpagarmepos pos on (pos.codpagarmepos = pp.codpagarmepos)
inner join tblnegocio n on (n.codnegocio = pp.codnegocio )
--where pp.status = 1
where n.codusuario  = 302109
and pp.criacao between '2022-12-22' and '2022-12-22 23:59:59'
group by pp.codfilial,pos.codpagarmepos , pos.serial, pos.apelido
order by 1, 3

select t.codpagarmepos, sum(t.valorpago), sum(t.valorcancelado), sum(t.valorpagoliquido) 
from tblpagarmepedido t   
where codpagarmepos = 8
and t.criacao between '2022-12-22' and '2022-12-22 23:59:59'
group by t.codpagarmepos

select 
	--pp.codfilial, 
	--pos.serial, 
	--pos.apelido, 
	count(*) qtd, 
	sum(pp.valorpagoliquido) total, 
	sum(pp.valorpagoliquido) / count(*) media
from tblpagarmepedido pp
left join tblpagarmepos pos on (pos.codpagarmepos = pp.codpagarmepos)
where pp.status = 2
and pp.codnegocio is not null
--group by 
	--pp.codfilial
	--, pos.serial, pos.apelido
--order by 1, 3

select criacao, * 
from tblpagarmepedido ped
where ped.valorpagoliquido = 100.16


select * from tblpix where valor = 218 order by horario desc


select codfilial, pagarmesk, pagarmeid, stonecode  from tblfilial where codempresa = 1 order by codfilial

select codfilial, inativo, * from tblstonefilial t order by codfilial 

select * from tblpagarmepos where codfilial = 105 order by codfilial, apelido 

alter table tblfilial add stonecode numeric (20,0)

select * from tblpagarmepos t where serial ilike '%93665'


select * f

103			

6M493665

insert into pagarme

