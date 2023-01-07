UPDATE tblnotafiscal
set nfeautorizacao = null,
nfedataautorizacao = null
where codnotafiscal = :codnotafiscal 


update tblnotafiscalprodutobarra 
set codnegocioprodutobarra = null
where codnotafiscal = :codnotafiscal 

select * from tblcest