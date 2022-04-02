select n.codnegocio, no.naturezaoperacao, f.filial, fd.filial, n.valortotal, n.lancamento, n.codpessoa
from tblnegocio n 
inner join tblnaturezaoperacao no on (no.codnaturezaoperacao = n.codnaturezaoperacao)
inner join tblfilial f on (f.codfilial = n.codfilial)
inner join tblfilial fd on (fd.codpessoa = n.codpessoa)
where n.codnegociostatus = 2 -- fechado
and n.codnaturezaoperacao not in (15, 19, 18, 17) -- transferencia de saida - uso consumo - perda - bonificacao
--and n.codnaturezaoperacao  = 1
and f.codempresa = 1
and f.codempresa = fd.codempresa
--and f.codfilial = fd.codfilial
and n.lancamento >= '2016-04-01'
--and n.lancamento > current_date - 300
--limit 100
order by n.lancamento desc, n.codnegocio desc;
--order by n.codnaturezaoperacao 

-- TRANSFERENCIA DE SAIDA
update tblnegocio set codnaturezaoperacao = 15 where codnegocio = :codnegocio;

update tbltitulo 
set codtipotitulo = 00000922, codcontacontabil = 00000014
where tbltitulo.codnegocioformapagamento in (select nfp.codnegocioformapagamento from tblnegocioformapagamento nfp where nfp.codnegocio = :codnegocio);

select 'curl http://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-negocio/' || :codnegocio;


-- SAIDA BONIFICACAO
update tblnegocio set codnaturezaoperacao = 17 
--where codnegocio = :codnegocio;
where codnegocio in ( 
1526796,
1510036,
1407336,
1358007,
799521,
742971,
704379
)

update tbltitulo 
set codtipotitulo = 924, codcontacontabil = 15
--where tbltitulo.codnegocioformapagamento in (select nfp.codnegocioformapagamento from tblnegocioformapagamento nfp where nfp.codnegocio = :codnegocio);
where tbltitulo.codnegocioformapagamento in (select nfp.codnegocioformapagamento from tblnegocioformapagamento nfp where nfp.codnegocio in (
1526796,
1510036,
1407336,
1358007,
799521,
742971,
704379
));

select 'curl http://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-negocio/' || :codnegocio;


-- USO E CONSUMO
update tblnegocio set codnaturezaoperacao = 19 
--where codnegocio = :codnegocio;
where codnegocio in ( 
2388681
,2249122
,817321
,743076
,685454
,657305
,642807
,604120
,592212
,582739
,581762
,574331
,558209
,547042
,536210
,521398
,515760
,516473
,495314
,432824
,409249
)

update tbltitulo 
set codtipotitulo = 00000926, codcontacontabil = 17
--where tbltitulo.codnegocioformapagamento in (select nfp.codnegocioformapagamento from tblnegocioformapagamento nfp where nfp.codnegocio = :codnegocio);
where tbltitulo.codnegocioformapagamento in (select nfp.codnegocioformapagamento from tblnegocioformapagamento nfp where nfp.codnegocio in (
2388681
,2249122
,817321
,743076
,685454
,657305
,642807
,604120
,592212
,582739
,581762
,574331
,558209
,547042
,536210
,521398
,515760
,516473
,495314
,432824
,409249
));

select 'curl http://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-negocio/' || :codnegocio;
