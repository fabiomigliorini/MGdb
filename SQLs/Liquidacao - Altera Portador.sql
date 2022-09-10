﻿update tblliquidacaotitulo 
set codportador = (select p.codportador from tblportador p where p.portador ilike '%folha%') 
where codliquidacaotitulo = :codliquidacaotitulo; 

update tblmovimentotitulo
set codportador = lt.codportador
from tblliquidacaotitulo lt
where lt.codliquidacaotitulo = tblmovimentotitulo.codliquidacaotitulo
and lt.codportador != tblmovimentotitulo.codportador;
	
commit

--update tblnfeterceiroitem  set complemento = 522-257.14-12.86 where codnfeterceiroitem  = 335938

select * from tblmovimentotitulo t where codtitulo = 433896