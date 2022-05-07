select indmanifestacao, codnfeterceiro, indsituacao, *
from tblnfeterceiro nt 
where nt.valorprodutos is null
and nt.emissao >= now() - '6 months'::interval
and indsituacao != 3 --cancelada
and not ignorada 
order by nt.emissao desc

