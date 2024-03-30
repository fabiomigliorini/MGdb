truncate table tblpessoaendereco;
truncate table tblpessoatelefone;
truncate table tblpessoaemail;
select setval('tblpessoaendereco_codpessoaendereco_seq', 1, false);
select setval('tblpessoatelefone_codpessoatelefone_seq', 1, false);
select setval('tblpessoaemail_codpessoaemail_seq', 1, false);



/*
create sequence tblpessoaemail_codpessoaemail_seq


drop sequence tblpessoaemail_codpessoatelefone_seq
*/

-- POPULA ENDERECO
INSERT INTO mgsis.tblpessoaendereco
(codpessoa, ordem, nfe, entrega, cobranca, cep, endereco, numero, complemento, bairro, codcidade, apelido, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select 
	p.codpessoa, 
	(select coalesce(max(t2.ordem), 0) + 1 from tblpessoaendereco t2 where t2.codpessoa = p.codpessoa)ordem, 
	true as nfe, 
	true as entrega, 
	true as cobranca, 
	p.cep, 
	p.endereco, 
	p.numero, 
	p.complemento, 
	p.bairro, 
	p.codcidade, 
	null as apelido, 
	p.criacao, 
	p.codusuariocriacao, 
	p.alteracao, 
	p.codusuarioalteracao, 
	null inativo
from tblpessoa p
left join tblpessoaendereco pe on (
	p.codpessoa = pe.codpessoa
	and coalesce(p.cep, '') = coalesce(pe.cep, '')
	and coalesce(p.endereco, '') = coalesce(pe.endereco, '')
	and coalesce(p.numero, '') = coalesce(pe.numero, '')
	and coalesce(p.complemento, '') = coalesce(pe.complemento, '')
	and coalesce(p.bairro, '') = coalesce(pe.bairro, '')
	and p.codcidade = pe.codcidade 
)
where pe.codpessoaendereco is null;

-- POPULA ENDERECO COBRANCA
INSERT INTO mgsis.tblpessoaendereco
(codpessoa, ordem, nfe, entrega, cobranca, cep, endereco, numero, complemento, bairro, codcidade, apelido, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select 
	p.codpessoa, 
	(select coalesce(max(t2.ordem), 0) + 1 from tblpessoaendereco t2 where t2.codpessoa = p.codpessoa) ordem, 
	false as nfe, 
	false as entrega, 
	true as cobranca, 
	p.cepcobranca, 
	p.enderecocobranca, 
	p.numerocobranca, 
	p.complementocobranca, 
	p.bairrocobranca, 
	p.codcidadecobranca, 
	'Cobrança' as apelido, 
	p.criacao, 
	p.codusuariocriacao, 
	p.alteracao, 
	p.codusuarioalteracao, 
	null inativo
from tblpessoa p
left join tblpessoaendereco pe on (
	p.codpessoa = pe.codpessoa
	and coalesce(p.cepcobranca, '') = coalesce(pe.cep, '')
	and coalesce(p.enderecocobranca, '') = coalesce(pe.endereco, '')
	and coalesce(p.numerocobranca, '') = coalesce(pe.numero, '')
	and coalesce(p.complementocobranca, '') = coalesce(pe.complemento, '')
	and coalesce(p.bairrocobranca, '') = coalesce(pe.bairro, '')
	and p.codcidadecobranca = pe.codcidade 
)
where pe.codpessoaendereco is null;

-- MARCA PRIMEIRO ENDERECO COMO NAO COBRANCA PROS CLIENTES QUE FICARAM COM 2 ENDERECOS DE COBRANCA
update tblpessoaendereco 
set cobranca = false
where codpessoaendereco in (
	select min(codpessoaendereco) as codpessoaendereco 
	from tblpessoaendereco pe
	where pe.cobranca = true
	group by pe.codpessoa
	having count(*) > 1
);

-- Email Normal
INSERT INTO mgsis.tblpessoaemail
(codpessoa, ordem, email, nfe, cobranca, apelido, verificacao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select 
	p.codpessoa, 
	(select coalesce(max(t2.ordem), 0) + 1 from tblpessoaemail t2 where t2.codpessoa = p.codpessoa) as ordem, 
	p.email, 
	true as nfe, 
	true as cobranca, 
	null as apelido, 
	null as verificacao, 
	p.criacao, 
	p.codusuariocriacao, 
	p.alteracao, 
	p.codusuarioalteracao, 
	null inativo
from tblpessoa p
left join tblpessoaemail pe on (upper(trim(coalesce(p.email, ''))) = upper(trim(coalesce(pe.email, ''))) and pe.codpessoa = p.codpessoa)
where p.email is not null
and p.email != 'nfe@mgpapelaria.com.br'
and pe.codpessoaemail is null
order by codpessoa 
;


-- Email NFe
INSERT INTO mgsis.tblpessoaemail
(codpessoa, ordem, email, nfe, cobranca, apelido, verificacao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)

select 
	p.codpessoa, 
	(select coalesce(max(t2.ordem), 0) + 1 from tblpessoaemail t2 where t2.codpessoa = p.codpessoa) as ordem, 
	p.emailcobranca , 
	true as nfe, 
	false as cobranca, 
	null as apelido, 
	null as verificacao, 
	p.criacao, 
	p.codusuariocriacao, 
	p.alteracao, 
	p.codusuarioalteracao, 
	null inativo
from tblpessoa p
left join tblpessoaemail pe on (upper(trim(coalesce(p.emailcobranca , ''))) = upper(trim(coalesce(pe.email, ''))) and pe.codpessoa = p.codpessoa)
where p.emailcobranca  is not null
and p.emailcobranca  != 'nfe@mgpapelaria.com.br'
and pe.codpessoaemail is null;

-- MARCA PRIMEIRO EMAIL NFE COMO NAO NFE PROS CLIENTES QUE FICARAM COM 2 ENDERECOS DE NFE
update tblpessoaemail
set nfe = false
where codpessoaemail in (
	select min(codpessoaemail) as codpessoaemail
	from tblpessoaemail pe
	where pe.nfe = true
	group by pe.codpessoa
	having count(*) > 1
);

-- Email cobranca 
INSERT INTO mgsis.tblpessoaemail
(codpessoa, ordem, email, nfe, cobranca, apelido, verificacao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select 
	p.codpessoa, 
	(select coalesce(max(t2.ordem), 0) + 1 from tblpessoaemail t2 where t2.codpessoa = p.codpessoa) as ordem, 
	p.emailcobranca, 
	false as nfe, 
	true as cobranca, 
	null as apelido, 
	null as verificacao, 
	p.criacao, 
	p.codusuariocriacao, 
	p.alteracao, 
	p.codusuarioalteracao, 
	null inativo
from tblpessoa p
left join tblpessoaemail pe on (upper(trim(coalesce(p.emailcobranca, ''))) = upper(trim(coalesce(pe.email, ''))) and pe.codpessoa = p.codpessoa)
where p.emailcobranca is not null
and p.emailcobranca != 'nfe@mgpapelaria.com.br'
and pe.codpessoaemail is null;

-- MARCA PRIMEIRO EMAIL COBRANCA COMO NAO COBRANCA PROS CLIENTES QUE FICARAM COM 2 ENDERECOS DE COBRANCA
update tblpessoaemail
set cobranca = false
where codpessoaemail in (
	select min(codpessoaemail) as codpessoaemail
	from tblpessoaemail pe
	where pe.cobranca = true
	group by pe.codpessoa
	having count(*) > 1
);

-- telefone1
INSERT INTO mgsis.tblpessoatelefone
(codpessoa, ordem, tipo, pais, ddd, telefone, apelido, verificacao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)

select 
	p.codpessoa, 
	0 as ordem, 
	1 as tipo, 
	55 as pais, 
	0 as ddd, 
	regexp_replace(p.telefone1, '[^0-9]', '', 'g')::numeric as telefone,
	null as apelido, 
	null as verificacao, 
	p.criacao, 
	p.codusuariocriacao, 
	p.alteracao, 
	p.codusuarioalteracao, 
	null as inativo
from tblpessoa p
left join tblpessoatelefone pt on (pt.codpessoa = p.codpessoa and pt.telefone = regexp_replace(telefone1, '[^0-9]', '', 'g')::numeric)
where telefone1 is not null
and regexp_replace(telefone1, '[^0-9]', '', 'g')::numeric != 0
and pt.codpessoatelefone is null;

-- telefone2
INSERT INTO mgsis.tblpessoatelefone
(codpessoa, ordem, tipo, pais, ddd, telefone, apelido, verificacao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select 
	p.codpessoa, 
	0 as ordem, 
	1 as tipo, 
	55 as pais, 
	0 as ddd, 
	regexp_replace(p.telefone2, '[^0-9]', '', 'g')::numeric as telefone,
	null as apelido, 
	null as verificacao, 
	p.criacao, 
	p.codusuariocriacao, 
	p.alteracao, 
	p.codusuarioalteracao, 
	null as inativo
from tblpessoa p
left join tblpessoatelefone pt on (pt.codpessoa = p.codpessoa and pt.telefone = regexp_replace(telefone2, '[^0-9]', '', 'g')::numeric)
where telefone2 is not null
and regexp_replace(telefone2, '[^0-9]', '', 'g')::numeric != 0
and pt.codpessoatelefone is null;

-- telefone3
INSERT INTO mgsis.tblpessoatelefone
(codpessoa, ordem, tipo, pais, ddd, telefone, apelido, verificacao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select 
	p.codpessoa, 
	0 as ordem, 
	1 as tipo, 
	55 as pais, 
	0 as ddd, 
	regexp_replace(p.telefone3, '[^0-9]', '', 'g')::numeric as telefone,
	null as apelido, 
	null as verificacao, 
	p.criacao, 
	p.codusuariocriacao, 
	p.alteracao, 
	p.codusuarioalteracao, 
	null as inativo
from tblpessoa p
left join tblpessoatelefone pt on (pt.codpessoa = p.codpessoa and pt.telefone = regexp_replace(telefone3, '[^0-9]', '', 'g')::numeric)
where telefone3 is not null
and regexp_replace(telefone3, '[^0-9]', '', 'g')::numeric != 0
--and length(regexp_replace(telefone3, '[^0-9]', '', 'g')) > 20
and pt.codpessoatelefone is null;

-- apaga telefone 0
delete from tblpessoatelefone where telefone = 0;

-- tenta pegar o ddd 
with ddds as (
	select distinct(substring(cast(telefone as varchar), 1, 2)) as ddd
	from tblpessoatelefone 
	where length(cast(telefone as varchar)) > 9
)
update tblpessoatelefone 
set ddd = cast(ddds.ddd as numeric)
from ddds
where ddds.ddd = substring(cast(tblpessoatelefone.telefone as varchar), 1, 2)
and length(cast(tblpessoatelefone.telefone as varchar)) > 9;

--tira o ddd do numero
update tblpessoatelefone 
set telefone = right(telefone::varchar, -2)::numeric
where ddd != 0;

-- marca como celular os que comecam com 9 e 8
update tblpessoatelefone 
set tipo = 2
where left(telefone::varchar, 1) in ('9', '8');

-- adiciona 9 na frente de celular com 8 digitos
update tblpessoatelefone 
set telefone = ('9' || telefone::varchar)::numeric
where length(telefone::varchar) = 8
and tipo = 2;


/*
-- adiciona ddd pela cidade
create table tmpddd as 
select distinct c.codcidade, c.cidade, e.sigla, null as ddd 
from tblpessoa p
inner join tblpessoatelefone pt on (pt.codpessoa = p.codpessoa)
inner join tblcidade c on (c.codcidade = p.codcidade)
inner join tblestado e on (e.codestado = c.codestado)
where pt.ddd = 0
order by 3, 2;

-- preencher os ddd das cidades
select * from tmpddd

-- altera de acordo com a tabeela de ddd
update tblpessoatelefone
set ddd = d.ddd::numeric
from tblpessoa p
inner join tmpddd d on (d.codcidade = p.codcidade)
where p.codpessoa = tblpessoatelefone.codpessoa 
and tblpessoatelefone.ddd = 0
and d.ddd is not null

-- apaga tabela temporaria
drop table tmpddd
*/

select * from tblnegocio

select * from tblpessoatelefone where criacao <= date_trunc('day', now())

select * from tblpessoa where codpessoa = 15703

select * from tblmercoscliente t 


