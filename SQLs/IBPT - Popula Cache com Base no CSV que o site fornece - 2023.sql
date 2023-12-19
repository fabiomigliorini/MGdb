truncate table tblibptaxcsv;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAC23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AC') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAL23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AL') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAM23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AM') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAP23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AP') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxBA23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'BA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxCE23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'CE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxDF23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'DF') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxES23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'ES') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxGO23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'GO') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMA23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMG23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MG') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMS23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MS') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMT23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MT') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPA23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPB23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PB') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPE23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPI23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PI') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPR23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PR') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRJ23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RJ') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRN23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RN') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRO23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RO') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRR23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RR') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRS23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RS') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSC23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SC') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSE23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSP23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SP') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxTO23.2.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'TO') where codestado is null;

truncate table tblibptcache ;

select setval('tblibptcache_codibptcache_seq', 1);

select * from tblibptaxcsv t

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
where c.codigo != '00000000'

select min(vigenciainicio), max(vigenciafim) from tblibptcache

/*
select codestado, count(*) from tblibptaxcsv t group by codestado;

select codfilial, codestado, count(*) from tblibptcache t group by codfilial, codestado;

*/


update tblpagarmepedido set codnegocio = 3367227 where codnegocio  = 3367166;

update tblnegocioformapagamento  set codnegocio = 3367227 where codnegocio  = 3367166;

update tblnegocio set codnegociostatus  = 1 where codnegocio = 3367166;

