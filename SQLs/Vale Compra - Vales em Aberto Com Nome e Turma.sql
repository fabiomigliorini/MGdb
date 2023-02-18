
select vc.codvalecompra, vc.criacao, vc.turma, vc.aluno, vc.total, t.saldo 
from tblvalecompra vc
inner join tbltitulo t on (vc.codtitulo = t.codtitulo) 
where vc.inativo is null
and vc.codpessoafavorecido = 108
--and vc.criacao > (now() - '5 months'::interval)
and t.saldo != 0
order by criacao asc
