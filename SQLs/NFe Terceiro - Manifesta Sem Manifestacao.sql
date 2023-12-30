-- CIENCIA
select nt.cnpj, nt.codfilial, nt.codnfeterceiro, nt.emissao, ' time curl ''https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-terceiro/' || nt.codnfeterceiro || '/manifestacao'' --data-raw ''indmanifestacao=210210'' '  
from tblnfeterceiro nt
where nt.indmanifestacao is null
and nt.criacao  > now() - '181 days'::interval 

-- REALIZADO
select nt.cnpj, nt.codfilial, nt.codnfeterceiro, nt.emissao, ' time curl ''https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-terceiro/' || nt.codnfeterceiro || '/manifestacao'' --data-raw ''indmanifestacao=210200'' '  
from tblnotafiscal nf
inner join tblnfeterceiro nt on (nt.codnotafiscal = nf.codnotafiscal)
where nf.emitida = false
and coalesce(nt.indmanifestacao, 210210) = 210210 --ciencia
--and nt.cnpj not in (4576775000160, 4576775000241, 4576775000322, 4576775000403, 4576775000594)
--and nt.codnfeterceiro = 36974
and nf.emissao > now() - '365 days'::interval 
order by nt.codnfeterceiro asc
--offset 200
--limit 100





