truncate table tblibptaxcsv;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAC23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AC') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAL23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AL') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAM23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AM') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAP23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AP') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxBA23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'BA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxCE23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'CE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxDF23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'DF') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxES23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'ES') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxGO23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'GO') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMA23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMG23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MG') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMS23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MS') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMT23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MT') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPA23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPB23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PB') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPE23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPI23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PI') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPR23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PR') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRJ23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RJ') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRN23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RN') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRO23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RO') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRR23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RR') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRS23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RS') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSC23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SC') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSE23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSP23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SP') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxTO23.1.A.csv' delimiter ';' encoding 'windows-1251' csv header;
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
	c.tipo, 
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

/*
select codestado, count(*) from tblibptaxcsv t group by codestado;

select codfilial, codestado, count(*) from tblibptcache t group by codfilial, codestado;

*/