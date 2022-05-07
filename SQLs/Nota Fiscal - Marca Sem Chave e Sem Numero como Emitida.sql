-- Marca Notas sem chave e sem numero como emitida
update tblnotafiscal 
set emitida = true
where not emitida 
and numero = 0
and nfechave is null

-- reprocessa estoque de todas notas sem chave e sem numero
select 'curl https://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-nota-fiscal/' || codnotafiscal 
from tblnotafiscal nf
where numero = 0
and nfechave is null
order by codnotafiscal desc

update tblnotafiscal 
set emitida = true, numero = 0, nfechave = null
where codnotafiscal = :codnotafiscal 