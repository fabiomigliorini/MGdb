update tblliquidacaotitulo 
set codportador = (select p.codportador from tblportador p where p.portador ilike '%6147%')
where codliquidacaotitulo = :codliquidacaotitulo;

update tblmovimentotitulo
set codportador = lt.codportador
from tblliquidacaotitulo lt
where lt.codliquidacaotitulo = tblmovimentotitulo.codliquidacaotitulo
and lt.codportador != tblmovimentotitulo.codportador;

commit

update tblliquidacaotitulo
set transacao = :data
where codliquidacaotitulo = :codliquidacaotitulo;


update tblmovimentotitulo
set transacao  = lt.transacao
from tblliquidacaotitulo lt
where lt.codliquidacaotitulo = tblmovimentotitulo.codliquidacaotitulo
and lt.transacao  != tblmovimentotitulo.transacao ;




--update tblnfeterceiroitem  set complemento = 522-257.14-12.86 where codnfeterceiroitem  = 335938

select * from tblmovimentotitulo t where codtitulo = 433896

select * from tblliquidacaotitulo t where codliquidacaotitulo = 112858 


select * from  tblprodutobarra where codproduto = 71201