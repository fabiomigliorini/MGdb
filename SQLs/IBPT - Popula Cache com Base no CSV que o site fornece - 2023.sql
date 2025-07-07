select table_name, pg_size_pretty(pg_total_relation_size(table_name::varchar)), pg_total_relation_size(table_name::varchar) from information_schema.tables where table_schema = 'mgsis' order by 3 desc

truncate table tblibptaxcsv;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAC24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AC') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAL24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AL') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAM24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AM') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxAP24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'AP') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxBA24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'BA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxCE24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'CE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxDF24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'DF') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxES24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'ES') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxGO24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'GO') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMA24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMG24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MG') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMS24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MS') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxMT24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'MT') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPA24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PA') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPB24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PB') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPE24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPI24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PI') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxPR24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'PR') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRJ24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RJ') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRN24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RN') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRO24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RO') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRR24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RR') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxRS24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'RS') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSC24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SC') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSE24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SE') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxSP24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'SP') where codestado is null;

copy tblibptaxcsv (codigo, ex, tipo, descricao, nacionalfederal, importadosfederal, estadual, municipal, vigenciainicio, vigenciafim, chave, versao, fonte) from '/tmp/host/ibpt/TabelaIBPTaxTO24.1.F.csv' delimiter ';' encoding 'windows-1251' csv header;
update tblibptaxcsv set codestado = (select e.codestado from tblestado e where sigla = 'TO') where codestado is null;


select count(*) from tblibptaxcsv 

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


-- DAQUI PRA BAIXO
-- CRIA OS REGISTROS DE CACHE
-- PARA OS NCMS QUE NAO ESTAO NO CSV FORNECIDO PELO IBPT
drop table tblibptcachefaltando;

create table tblibptcachefaltando as 
select 
	n.ncm, 
	n.codncm, 
	n.descricao, 
	0.01 as nacional, 
	0.01 as importado,
	0.01 as estadual, 
	0.01 as municipal,
	now() as vigenciainicio,
	now() as vigenciafim
from tblncm n
where length(n.ncm) = 8
and n.ncm not in (
	select c.ncm from tblibptcache c where c.ncm = n.ncm
);

update tblibptcachefaltando 
set nacional = null, 
	estadual = null, 
	importado = null, 
	municipal = null, 
	vigenciainicio = null, 
	vigenciafim = null 
where 1 = 1;

with m as (
	select 
		max(c.nacional) as nacional,
		max (c.importado) as importado,
		max (c.estadual) as estadual,
		max (c.municipal) as municipal,
		max(c.vigenciainicio) as vigenciainicio,
		max(c.vigenciafim) as vigenciafim,
		substring(c.ncm, 1, 4) as inicio
	from tblibptcache c
	group by substring(c.ncm, 1, 4)
)
update tblibptcachefaltando
set nacional = m.nacional
, importado = m.importado
, estadual = m.estadual
, municipal = m.municipal
, vigenciainicio  = m.vigenciainicio
, vigenciafim = m.vigenciafim
from m 
where m.inicio = substring(tblibptcachefaltando.ncm, 1, 4);


INSERT INTO mgsis.tblibptcache
	(codfilial, codestado, ncm, extarif, descricao, nacional, estadual, importado, municipal, tipo, vigenciainicio, vigenciafim, chave, versao, fonte, criacao, codusuariocriacao, alteracao, codusuarioalteracao)
SELECT 
	f.codfilial, 
	e.codestado, 
	c.ncm as ncm, 
	 0 as extarif, 
	left(c.descricao, 400) as descricao, 
	c.nacional, 
	c.estadual, 
	c.importado, 
	c.municipal, 
	0 as tipo, 
	c.vigenciainicio, 
	c.vigenciafim, 
	null as chave, 
	null as versao, 
	null as fonte, 
	date_trunc('second', now()) as criacao, 
	null as codusuariocriacao, 
	date_trunc('second', now()) as alteracao, 
	null as codusuarioalteracao
FROM tblibptcachefaltando c
inner join tblestado e on (e.codpais = 1)
inner join tblfilial f on (f.codempresa = 1 and f.emitenfe = true)
where c.ncm != '00000000';


update tblibptcache set vigenciainicio = (select min(c.vigenciainicio) from tblibptcache c where c.vigenciainicio is not null) where vigenciainicio is null;

update tblibptcache set vigenciafim = (select max(c.vigenciafim) from tblibptcache c where c.vigenciafim is not null) where vigenciafim is null;


select count(*), vigenciainicio, vigenciafim from tblibptcache group by vigenciainicio, vigenciafim
