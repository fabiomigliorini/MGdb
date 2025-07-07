-- CIENCIA
select nt.cnpj, nt.indsituacao, nt.codfilial, nt.codnfeterceiro, nt.emissao, ' time curl ''https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-terceiro/' || nt.codnfeterceiro || '/manifestacao'' --data-raw ''indmanifestacao=210210'' '  
from tblnfeterceiro nt
where nt.indmanifestacao is null
and nt.criacao  > now() - '30 days'::interval 
and coalesce(nt.indsituacao, 1) != 3
order by nt.emissao desc


-- REALIZADO
select nt.cnpj, nt.codfilial, nt.codnfeterceiro, nt.emissao, ' time curl ''https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-terceiro/' || nt.codnfeterceiro || '/manifestacao'' --data-raw ''indmanifestacao=210200'' '  
from tblnotafiscal nf
inner join tblnfeterceiro nt on (nt.codnotafiscal = nf.codnotafiscal)
where nf.emitida = false
and coalesce(nt.indmanifestacao, 210210) = 210210 --ciencia
--and nt.cnpj not in (4576775000160, 4576775000241, 4576775000322, 4576775000403, 4576775000594)
--and nt.codnfeterceiro = 36974
and nf.emissao > now() - '181 days'::interval
--and nt.nfechave not ilike '%04576775%'
--and nt.nfechave ilike '%045767750005%'
order by nt.codnfeterceiro asc
offset 600
limit 200





