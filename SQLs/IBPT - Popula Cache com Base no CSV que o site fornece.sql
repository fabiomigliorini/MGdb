
update tabelaibptaxmt22 set ex = null where ex = ''

delete from tblibptcache

select setval('tblibptcache_codibptcache_seq', 1, false)

insert into tblncm (ncm, descricao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, bit, fecep, inicio)
select i.codigo, i.descricao, now(), 1, now(), 1, false, false, now()
from tabelaibptaxmt22 i
left join tblncm n on (n.ncm = i.codigo)
where i.tipo = '0' 
and n.codncm is null

INSERT INTO mgsis.tblibptcache
(codfilial, codestado, ncm, extarif, descricao, nacional, estadual, importado, municipal, tipo, vigenciainicio, vigenciafim, chave, versao, fonte, criacao, codusuariocriacao, alteracao, codusuarioalteracao)
select
	f.codfilial,
	8956 as codestado, 
	i.codigo, 
	coalesce(cast(i.ex as smallint), 0) as extarif, 
	LEFT(i.descricao, 400) as descricao, 
	cast(i.nacionalfederal as numeric) as nacional, 
	cast(i.estadual as numeric), 
	cast(i.importadosfederal as numeric) as importado, 
	cast(i.municipal as numeric), 
	cast(i.tipo as smallint) as tipo, 
	to_date(i.vigenciainicio, 'DD/MM/YYYY'), 
	to_date(i.vigenciafim, 'DD/MM/YYYY'), 
	i.chave, 
	i.versao, 
	i.fonte,
	date_trunc('second', now()) criacao, 
	1 as codusuariocriacao,
	date_trunc('second', now()) alteracao,
	1 as codusuarioalteracao 
from tabelaibptaxmt22 i
left join tblncm n on (i.codigo = n.ncm)
left join tblfilial f on (f.codfilial in (101, 102, 103, 104, 105)) 
where i.tipo = '0' 

select count(*) from tblibptcache t 
