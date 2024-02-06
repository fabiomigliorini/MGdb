update tblnotafiscal 
set emissao = date_trunc('month', now())  
, saida = date_trunc('month', now())
, emitida = true
where numero = 0
and emissao != date_trunc('month', now())  
--and emitida = true