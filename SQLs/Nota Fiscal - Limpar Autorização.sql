UPDATE tblnotafiscal
   set nfeautorizacao = null,
       nfedataautorizacao = null
 where codnotafiscal = :codnotafiscal 


update tblnotafiscalprodutobarra 
set codnegocioprodutobarra = null
where codnotafiscal = :codnotafiscal 

select * from tblcest

select * 
from tblnotafiscal 
where codnotafiscal = :codnotafiscal 
--select * from tblibptcache t where vigenciafim is null


UPDATE tblnotafiscal
set nfeautorizacao = null,
nfedataautorizacao = null
where codfilial = :codfilial
and modelo = :modelo
and serie = :serie
and numero in :numeros
and emitida = true


select * 
from tblnotafiscal
where codfilial = :codfilial
and modelo = :modelo
and serie = :serie
and numero in :numeros
and emitida = true


UPDATE tblnotafiscal
set nfeautorizacao = null,
nfedataautorizacao = null,
nfeinutilizacao = null
where codfilial = :codfilial
and modelo = :modelo
and serie = :serie
and numero in :numero
and emitida = true


INSERT INTO mgsis.tblnotafiscal (
	codnaturezaoperacao, 
	emitida, 
	nfechave, 
	nfeimpressa, 
	serie, 
	numero, 
	emissao, 
	saida, 
	codfilial, 
	codpessoa, 
	codoperacao, 
	modelo, 
	valorprodutos, 
	valortotal, 
	tpemis, 
	codestoquelocal
)
select 
	codnaturezaoperacao, 
	emitida, 
	null as nfechave, 
	nfeimpressa, 
	serie, 
	numero - 1, 
	emissao, 
	saida, 
	codfilial, 
	1 as codpessoa, 
	codoperacao, 
	modelo, 
	0 as valorprodutos, 
	0 as valortotal, 
	tpemis, 
	codestoquelocal 
from tblnotafiscal t 
where codfilial = :codfilial
and modelo = :modelo
and serie = :serie
and numero = (:numero +1)
and emitida = true

