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
	inner join tblprodutovariacao pv on (pv.codproduto = pb.codproduto and pv.variacao ilike '%' || pb.barras || '%')
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


select * from tblprodutobarra where codprodutobarra = 953551