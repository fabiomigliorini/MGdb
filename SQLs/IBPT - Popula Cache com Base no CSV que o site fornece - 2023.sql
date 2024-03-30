select table_name, pg_size_pretty(pg_total_relation_size(table_name::varchar)), pg_total_relation_size(table_name::varchar) from information_schema.tables where table_schema = 'mgsis' order by 3 desc

truncate table tblibptaxcsv;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAC24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AC') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAL24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AL') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAM24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AM') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAP24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AP') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxBA24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'BA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxCE24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'CE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxDF24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'DF') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxES24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'ES') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxGO24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'GO') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMA24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMG24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MG') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMS24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MS') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMT24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MT') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPA24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPB24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PB') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPE24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPI24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PI') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPR24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PR') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRJ24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RJ') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRN24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RN') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRO24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RO') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRR24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RR') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRS24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RS') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSC24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SC') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSE24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSP24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SP') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxTO24.1.B.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'TO') where codestado is null;

truncate table tblibptcache ;

select setval('tblibptcache_codibptcache_seq', 1);

INSERT INTO mgsis.tblibptcache
	(codfilial, codestado, ncm, extarif, descricao, nacional, estadual, importado, municipal, tipo, vigenciainicio, vigenciafim, chave, versao, fonte, criacao, codusuariocriacao, alteracao, codusuarioalteracao)
SELECT 
	f.codfilial, 
	c.codestado, 
	c.codigo as ncm, 
	coalesce(cast(c.ex as int), 0) as extarif, 
	left(c.descricao, 400) as descricao, 
	c.nacionalfederal as nacional, 
	c.estadual, 
	c.importadosfederal as importado, 
	c.municipal, 
	cast(c.tipo as smallint), 
	to_date(c.vigenciainicio, 'DD/MM/YYYY') as vigenciainicio, 
	to_date(c.vigenciafim, 'DD/MM/YYYY') as vigenciafim, 
	c.chave, 
	c.versao, 
	c.fonte, 
	date_trunc('second', now()) as criacao, 
	null as codusuariocriacao, 
	date_trunc('second', now()) as alteracao, 
	null as codusuarioalteracao
FROM tblibptaxcsv c
inner join tblfilial f on (f.codempresa = 1 and f.emitenfe = true)
where c.codigo != '00000000';

select min(vigenciainicio), max(vigenciafim), count(*) from tblibptcache;

/*
select codestado, count(*) from tblibptaxcsv t group by codestado;

select codfilial, codestado, count(*) from tblibptcache t group by codfilial, codestado;


update tblpagarmepedido set codnegocio = 3367227 where codnegocio  = 3367166;

update tblnegocioformapagamento  set codnegocio = 3367227 where codnegocio  = 3367166;

update tblnegocio set codnegociostatus  = 1 where codnegocio = 3367166;



select * from tblibptcache

select vigenciafim, count(*) from tblibptcache group by vigenciafim


update tblibptcache set vigenciafim = '2024-02-29' where vigenciafim ='2024-01-31'


select count(*) from tblibptaxcsv

select count(*) from tblnegocio 

select count(*) from tblnegocioprodutobarra

select count(*) from tblnegocioformapagamento


SELECT pg_size_pretty( pg_total_relation_size('tblibptaxcsv'))
*/


