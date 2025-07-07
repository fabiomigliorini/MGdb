-- Inutilizar NF nao autorizada
select 
	nf.codnotafiscal,
	nf.codfilial, 
	nf.emissao, 
	nf.numero, 
	' curl https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-php/' || nf.codnotafiscal || '/inutilizar?justificativa=Falha+de+cominicacao+com+Sefaz%2C+falha+de+rede.+Sera+reemitida. &' as comando
from tblnotafiscal nf
where nf.codfilial in (101, 102, 103, 104, 105)
and nf.emitida
and nf.nfeautorizacao is null
and nf.nfecancelamento is null
and nf.nfeinutilizacao is null
and nf.numero != 0
and nf.modelo = 65
order by 2, 4 desc


-- Gera as notas
with nfs as (
	select nfpb.codnegocioprodutobarra 
	from tblnotafiscal nf
	inner join tblnotafiscalprodutobarra nfpb on (nfpb.codnotafiscal = nf.codnotafiscal)
	where nf.emitida 
	and nf.nfeinutilizacao is null
	and nf.nfecancelamento is null
)
select distinct n.codnegocio, n.lancamento, ' time curl "https://api-mgspa.mgpapelaria.com.br/api/v1/pdv/negocio/' || n.codnegocio || '/nota-fiscal" -H "Authorization: ' || :bearer || '" -H "Accept: application/json, text/plain, */*" -H "Content-Type: application/json" --data-raw ''{"pdv":"' || :pdv || '","modelo":65}'' &'
from tblnegocio n
inner join tblnaturezaoperacao nat on (nat.codnaturezaoperacao = n.codnaturezaoperacao)
inner join tblnegocioprodutobarra npb on (npb.codnegocio = n.codnegocio)
left join nfs on (nfs.codnegocioprodutobarra = npb.codnegocioprodutobarra)
left join tblnegocioformapagamento nfp on (nfp.codnegocio = n.codnegocio)
left join tblnegocioprodutobarra dev on (dev.codnegocioprodutobarradevolucao = npb.codnegocioprodutobarra)
where n.codnegociostatus = 2
and nat.venda = true
and npb.inativo is null
and n.lancamento >= now () - '365 days'::interval
and dev.codnegocioprodutobarra is null
--and n.codnegocio  = 03856154
and nfs.codnegocioprodutobarra is null
and nfp.integracao = true


-- transmite as notas
with pendentes as (
	select 
	codfilial, 
	valortotal,
	nf.codnotafiscal,
	' time curl --max-time 2 "https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-php/' || nf.codnotafiscal || '/criar" -H "Accept: application/json" | head -n 10' ||
	' && curl --max-time 2 "https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-php/' || nf.codnotafiscal || '/enviar-sincrono" -H "Accept: application/json"| head -n 10 ' 
	--' && curl "https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-php/' || nf.codnotafiscal || '/mail?destinatario=centralfarmafinanceiro%40gmail.com" -H "Accept: application/json"'
	from tblnotafiscal nf
	where nf.codnaturezaoperacao = 1 -- venda
	and nf.emitida = true 
	and nf.modelo = 65
	--and nf.modelo = 55
	and nf.numero = 0
	and nf.codpessoa = 1
	--and nf.codpessoa = (select p.codpessoa from tblpessoa p where p.cnpj = 08954952000156)
	and nf.valortotal < 1000
)
select * from pendentes order by codnotafiscal desc --offset 50;

update tblnotafiscal 
set modelo = 55,
codpessoa = (select p.codpessoa from tblpessoa p where p.cnpj = 08954952000156)
where numero = 0
and codpessoa = 1
and modelo = 65
and codnaturezaoperacao = 1


select * from tblferiado order by data desc


select * from tblgrupousuariousuario t 


select * 
from tblusuario u
where u.inativo is null
and u.codusuario not in (
	select guu.codusuario 
	from tblgrupousuariousuario guu 
	where guu.codgrupousuario = 4
)




select t.* 
from tblnegocioprodutobarra t 
inner join tblnegocio n on (n.codnegocio=  t.codnegocio)
inner join tblnaturezaoperacao nat on (nat.codnaturezaoperacao = n.codnaturezaoperacao)
where codprodutobarra = 960418
and nat.venda = true
order by t.codnegocio desc