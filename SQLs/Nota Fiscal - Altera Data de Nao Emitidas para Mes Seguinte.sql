update tblnotafiscal 
set emissao = date_trunc('month', now() + '1 month')  
, saida = date_trunc('month', now() + '1 month')
, emitida = true
where numero = 0