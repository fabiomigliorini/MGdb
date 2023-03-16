select nft.numero, nft.emissao, nti.cprod, nti.xprod, nti.cean, nti.ceantrib 
from tblnfeterceiro nft
inner join tblnfeterceiroitem nti on (nti.codnfeterceiro = nft.codnfeterceiro)
where nft.codpessoa = :codpessoa
and cprod ilike :referencia
--and cean = '7896647065983'


insert into tblprodutovariacao (codproduto, referencia, variacao)
select :codproduto, cprod, max(xprod) || ' - ' || max(cean)
from tblnfeterceiro nft
inner join tblnfeterceiroitem nti on (nti.codnfeterceiro = nft.codnfeterceiro)
where nft.codpessoa = :codpessoa
and cprod ilike :referencia 
--and cean = '7897983524820'
group by cprod

with conv as (
	select pb.codprodutobarra, pv.codprodutovariacao 
	from tblprodutobarra pb
	inner join tblprodutovariacao pv on (pv.codproduto = pb.codproduto and pv.referencia ilike pb.referencia)
	where pb.codproduto = :codproduto
)
update tblprodutobarra 
set codprodutovariacao = conv.codprodutovariacao 
from conv 
where tblprodutobarra.codprodutobarra = conv.codprodutobarra

with conv as (
	select pb.codprodutobarra, pv.codprodutovariacao 
	from tblprodutobarra pb
	inner join tblprodutovariacao pv on (pv.codproduto = pb.codproduto and pv.variacao ilike '%' || right(left(pb.barras, -1), -1) || '%')
	where pb.codproduto = :codproduto
)
update tblprodutobarra 
set codprodutovariacao = conv.codprodutovariacao 
from conv 
where tblprodutobarra.codprodutobarra = conv.codprodutobarra


update tblprodutobarra 
set codprodutovariacao = :codprodutovariacaoinativa
where codprodutovariacao = :codprodutovariacaounidade
and codprodutoembalagem is not null

select * from tblprodutobarra where codprodutovariacao = 132237 and codprodutoembalagem is null

update tblprodutobarra 
set codprodutoembalagem = null 
where codprodutoembalagem  = :codprodutoembalagemeliminar


select * 
from tblprodutovariacao pv
where pv.codproduto = :codproduto 
order by variacao 


update tblprodutobarra 
set variacao = null
, referencia = null
where codproduto = 69751


select * from tblprodutobarra where codprodutobarra = 941707


-- Ajusta descricao das variacoes
select codprodutovariacao, variacao, referencia --, INITCAP(variacao)
from tblprodutovariacao v
--where v.codproduto = :codproduto
where v.codproduto = 69750
order by variacao

update tblprodutovariacao
set variacao = replace(variacao, 'SAQ. P/ PRES. 25X35 - 50 UN - ', '')
where codproduto  = :codproduto 

update tblprodutovariacao
set variacao = replace(variacao, 'Saquinho P/ Pres. 25 X 35 - 50 Un. - ', '')
where codproduto  = :codproduto 

update tblprodutovariacao
set variacao = initcap(variacao)
where codproduto  = :codproduto 


-- Passa barras pras variacoes
with novo as (
	select 
		codprodutobarra, 
		barras, 
		left(right(pb.barras, -1), -1),
		(
			select pv.codprodutovariacao
			from tblprodutovariacao pv
			where pv.codproduto = pb.codproduto
			and pv.variacao ilike '%' || left(right(pb.barras, -1), -1) || '%'
			order by 1
			limit 1
		) as codprodutovariacaonovo
	from tblprodutobarra pb
	where pb.codproduto = :codproduto 
)
update tblprodutobarra 
set codprodutovariacao = novo.codprodutovariacaonovo
from novo
where tblprodutobarra.codprodutobarra = novo.codprodutobarra 
and novo.codprodutovariacaonovo is not null

select * from tblnegocio where codnegocio = 3029463