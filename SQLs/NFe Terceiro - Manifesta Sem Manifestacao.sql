select * 
from tblnfeterceiro t
where codnfeterceiro = 37596
and indmanifestacao = 210210 --ciencia
and indsituacao  = 1 
and codnegocio is not null

--curl 'https://api.mgspa.mgpapelaria.com.br/api/v1/nfe-terceiro/37597/manifestacao' --data-raw 'indmanifestacao=210200'

select nt.cnpj, nt.codfilial, nt.codnfeterceiro, nt.emissao, ' time curl ''https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-terceiro/' || nt.codnfeterceiro || '/manifestacao'' --data-raw ''indmanifestacao=210200'' '  
from tblnotafiscal nf
inner join tblnfeterceiro nt on (nt.codnotafiscal = nf.codnotafiscal)
where nf.emitida = false
and coalesce(nt.indmanifestacao, 210210) = 210210 --ciencia
--and nt.cnpj not in (4576775000160, 4576775000241, 4576775000322, 4576775000403, 4576775000594)
--and nt.codnfeterceiro = 36974
and nf.emissao > now() - '181 days'::interval 
order by nt.codnfeterceiro desc
--offset 200
--limit 100

select codprodutobarra, * from tblnotafiscalprodutobarra t   where codprodutobarra = 1044790


select * from tblproduto order by criacao desc nulls last