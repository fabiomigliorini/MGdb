﻿select count(codtitulo), sum(debito), extract(year from emissao), extract(month from emissao)
from tbltitulo
where boleto = true 
and estornado is null
group by extract(year from emissao), extract(month from emissao)
order by 3 desc, 4 desc

select count(codtitulo) quantidade, sum(debito) valor, extract(year from emissao) ano, extract(month from emissao) mes
from tbltitulo
where boleto = true 
and estornado is null
group by extract(year from emissao), extract(month from emissao)
order by 3 desc, 4 desc

select count(*), sum(valor), extract(year from emissao), extract(month from emissao) from tblcheque
group by extract(year from emissao), extract(month from emissao) 
order by 3 desc, 4 desc


