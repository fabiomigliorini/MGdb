
select em.codestoquemes, es.codproduto, es.codestoquelocal, es.fiscal, em.mes, emov.data, emov.codestoquemovimentotipo, emov.entradaquantidade, emov.entradavalor, emov.saidaquantidade, emov.saidavalor
from tblestoquemes em
left join tblestoquesaldo es on (es.codestoquesaldo = em.codestoquesaldo)
left join tblestoquemovimento emov on (emov.codestoquemes = em.codestoquemes)
where es.codproduto = 76
--where es.codproduto = 105360
--and emov.entradaquantidade > 0
and emov.codnotafiscalprodutobarra is not null
order by data 

select count(*) from tblnotafiscalprodutobarra where codprodutobarra in (select codprodutobarra from tblprodutobarra where codproduto = 76)

select * from tblestoquemovimento where codestoquemes = 20288

select codestoquemes, count(*) from tblestoquemovimento group by codestoquemes having count(*) > 10


﻿select em.codestoquemes, es.codestoquelocal, count(codestoquemovimento)
from tblestoquesaldo es
left join tblestoquemes em on (em.codestoquesaldo = es.codestoquesaldo)
left join tblestoquemovimento emov on (emov.codestoquemes = em.codestoquemes)
where es.codproduto =76
group by em.codestoquemes , es.codestoquelocal
order by 3 desc
--having count(codestoquemovimento) > 1
