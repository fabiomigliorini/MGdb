UPDATE tblnotafiscal
set nfeautorizacao = null,
nfedataautorizacao = null
where codnotafiscal = :codnotafiscal 


update tblnotafiscalprodutobarra 
set codnegocioprodutobarra = null
where codnotafiscal = :codnotafiscal 

select * from tblcest

select * from tblnotafiscal where codnotafiscal = :codnotafiscal 
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
and numero in :numero
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


