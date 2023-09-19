select * 
from tbltituloboleto b
inner join tbltitulo t on (t.codtitulo = b.codtitulo)
where b.estadotitulocobranca = 1
and t.saldo = 0
order by b.criacao desc