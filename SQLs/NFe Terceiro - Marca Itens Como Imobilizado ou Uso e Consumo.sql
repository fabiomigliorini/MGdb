
select 
	ncm,
	(
		select min(pb.codprodutobarra)
		from tblncm n
		inner join tblproduto p on (p.codncm = n.codncm)
		inner join tblprodutobarra pb on (pb.codproduto = p.codproduto)
		where n.ncm = tblnfeterceiroitem.ncm
		and p.codtipoproduto = 7 -- USO E CONSUMO
		--and p.codtipoproduto = 8 -- IMOBILIZADO
	) ,
	codprodutobarra, 
	* 
from tblnfeterceiroitem
where tblnfeterceiroitem.codnfeterceiro = :codnfeterceiro 

update tblnfeterceiroitem
set codprodutobarra = (
		select min(pb.codprodutobarra)
		from tblncm n
		inner join tblproduto p on (p.codncm = n.codncm)
		inner join tblprodutobarra pb on (pb.codproduto = p.codproduto)
		where n.ncm = tblnfeterceiroitem.ncm
		and p.codtipoproduto = :codtipoproduto
		--and p.codtipoproduto = 7 -- USO E CONSUMO
		--and p.codtipoproduto = 8 -- IMOBILIZADO
	),
	complemento = null,
	margem = null
where tblnfeterceiroitem.codnfeterceiro = :codnfeterceiro 



select * from tbltipoproduto t order by codtipoproduto 

$nfeTerceiroItem->qcom = $quantidade;
$nfeTerceiroItem->vuncom = $nti->vprod / $quantidade; 


select codnfeterceiro, nsu, nfechave, data, * from tbldistribuicaodfe t where "data" is null

