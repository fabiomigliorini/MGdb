﻿select * from tblnfeterceiroitem where codnfeterceiro = 20214

-- ISSAM - Material de Natal, Valor Pedido / 0.35
update tblnfeterceiroitem set complemento = (vprod / 0.245) - vprod, margem = 90 where codnfeterceiro = 20214

select sum(vprod) as prod, sum(ipivipi) as ipi, sum(complemento) as comlemento from tblnfeterceiroitem where codnfeterceiro = 20214


update tblnfeterceiroitem set complemento = (vprod / 0.245) - vprod, margem = 90 where codnfeterceiro = 20214

update tblnfeterceiroitem set MARGEM = 25 where codnfeterceiro = 42712

select margem, * from tblnfeterceiroitem t where codnfeterceiro = 42712 order by nitem 


UPDATE tblnegocio SET codnaturezaoperacao = (select codnaturezaoperacao from tblnaturezaoperacao where naturezaoperacao ilike 'transf%saida') where codnegocio = :codnegocio 


select nf.codnotafiscal, nf.codfilial, nf.numero, nf.emissao, p.produto, nfpb.quantidade, nfpb.valortotal 
from tblnotafiscalprodutobarra nfpb
inner join tblnotafiscal nf on (nf.codnotafiscal = nfpb.codnotafiscal)
inner join tblprodutobarra pb on (pb.codprodutobarra = nfpb.codprodutobarra)
inner join tblproduto p on (p.codproduto = pb.codproduto)
where nfpb.alteracao !=  nfpb.criacao 
and  nfpb.alteracao between '2022-03-04 00:00:00' and '2022-03-04 23:59:59'  
and nf.codnaturezaoperacao = 00000016
order by codfilial, emissao, numero, produto


SELECT * FROM tblnegocio WHERE codnegocio = 2607671


select * from tblestoqueverao t  where codbar ilike '%241942%' or codbar ilike '7897256222064' 


update tblnfeterceiroitem set margem = 37 where codnfeterceiro = 42678