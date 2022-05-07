/*
select 
	p.inativo
	, (select count(pv.codprodutovariacao) from tblprodutovariacao pv where pv.codproduto = p.codproduto) as qtdvriacoes
	, * 
from tblproduto p
where p.produto ilike '%scrity%11%16%'
order by p.produto asc
*/



update tblnegocioprodutobarra set codprodutobarra = :codprodutobarranovo where codprodutobarra in (:codprodutobarraantigo);

update tblnotafiscalprodutobarra set codprodutobarra = :codprodutobarranovo where codprodutobarra in (:codprodutobarraantigo);

update tblcupomfiscalprodutobarra set codprodutobarra = :codprodutobarranovo where codprodutobarra in (:codprodutobarraantigo);

update tblnfeterceiroitem set codprodutobarra = :codprodutobarranovo where codprodutobarra in (:codprodutobarraantigo);

DELETE FROM tblprodutobarra WHERE codprodutobarra IN (:codprodutobarraantigo);

select * from tblnfeterceiroitem t where codnfeterceiro  = 38377

select * from tblfilial t  where codfilial in (401, 402)


select bit, * from tblncm where ncm = '85235190'

select bit, * from tblncm where ncm = '84717040'


