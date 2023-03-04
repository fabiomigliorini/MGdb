-- Email Normal
INSERT INTO mgsis.tblpessoaemail
(codpessoa, ordem, email, nfe, cobranca, apelido, verificacao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select 
	codpessoa, 
	1 as ordem, 
	p.email, 
	false as nfe, 
	false as cobranca, 
	null as apelido, 
	null as verificacao, 
	criacao, 
	codusuariocriacao, 
	alteracao, 
	codusuarioalteracao, 
	null inativo
from tblpessoa p
where p.email is not null

-- Email NFe
INSERT INTO mgsis.tblpessoaemail
(codpessoa, ordem, email, nfe, cobranca, apelido, verificacao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select 
	codpessoa, 
	1 as ordem, 
	p.emailnfe, 
	true as nfe, 
	false as cobranca, 
	null as apelido, 
	null as verificacao, 
	criacao, 
	codusuariocriacao, 
	alteracao, 
	codusuarioalteracao, 
	null inativo
from tblpessoa p
where p.emailnfe is not null

-- Email cobranca 
INSERT INTO mgsis.tblpessoaemail
(codpessoa, ordem, email, nfe, cobranca, apelido, verificacao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select 
	codpessoa, 
	2 as ordem, 
	p.emailcobranca, 
	false as nfe, 
	true as cobranca, 
	null as apelido, 
	null as verificacao, 
	criacao, 
	codusuariocriacao, 
	alteracao, 
	codusuarioalteracao, 
	null inativo
from tblpessoa p
where p.emailcobranca is not null

-- Endereco Principal
INSERT INTO mgsis.tblpessoaendereco
(codpessoa, ordem, nfe, entrega, cobranca, cep, endereco, numero, complemento, bairro, codcidade, apelido, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select
	codpessoa, 
	0 as ordem, 
	true as nfe, 
	true as entrega, 
	false as cobranca, 
	cep, 
	endereco, 
	numero, 
	complemento, 
	bairro, 
	codcidade, 
	null as apelido, 
	criacao, 
	codusuariocriacao, 
	alteracao, 
	codusuarioalteracao, 
	null as inativo
from tblpessoa p

-- Endereco Cobranca
INSERT INTO mgsis.tblpessoaendereco
(codpessoa, ordem, nfe, entrega, cobranca, cep, endereco, numero, complemento, bairro, codcidade, apelido, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select
	codpessoa, 
	1 as ordem, 
	false as nfe, 
	false as entrega, 
	true as cobranca, 
	cepcobranca, 
	enderecocobranca, 
	numerocobranca, 
	complementocobranca, 
	bairrocobranca, 
	codcidadecobranca, 
	null as apelido, 
	criacao, 
	codusuariocriacao, 
	alteracao, 
	codusuarioalteracao, 
	null as inativo
from tblpessoa p


-- telefone1
INSERT INTO mgsis.tblpessoatelefone
(codpessoa, ordem, tipo, pais, ddd, telefone, apelido, verificacao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select 
	codpessoa, 
	0 as ordem, 
	1 as tipo, 
	55 as pais, 
	0 as ddd, 
	--telefone1, 
	regexp_replace(telefone1, '[^0-9]', '', 'g')::numeric as telefone,
	telefone1 as apelido, 
	null as verificacao, 
	criacao, 
	codusuariocriacao, 
	alteracao, 
	codusuarioalteracao, 
	inativo
from tblpessoa
where telefone1 is not null


-- telefone2
INSERT INTO mgsis.tblpessoatelefone
(codpessoa, ordem, tipo, pais, ddd, telefone, apelido, verificacao, criacao, codusuariocriacao, alteracao, codusuarioalteracao, inativo)
select 
	codpessoa, 
	0 as ordem, 
	1 as tipo, 
	55 as pais, 
	0 as ddd, 
	--telefone1, 
	regexp_replace(telefone2, '[^0-9]', '', 'g')::numeric as telefone,
	telefone2 as apelido, 
	null as verificacao, 
	criacao, 
	codusuariocriacao, 
	alteracao, 
	codusuarioalteracao, 
	inativo
from tblpessoa
where telefone2 is not null

-- apaga telefone 0
delete from tblpessoatelefone where telefone = 0

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
and length(cast(tblpessoatelefone.telefone as varchar)) > 9

--tira o ddd do numero
update tblpessoatelefone 
set telefone = right(telefone::varchar, -2)::numeric
where ddd != 0

-- marca como celular os que comecam com 9 e 8
update tblpessoatelefone 
set tipo = 2
where left(telefone::varchar, 1) in ('9', '8')

-- adiciona 9 na frente de celular com 8 digitos
update tblpessoatelefone 
set telefone = ('9' || telefone::varchar)::numeric
where length(telefone::varchar) = 8
and tipo = 2

-- adiciona ddd pela cidade
create table tmpddd as 
select distinct c.codcidade, c.cidade, e.sigla, null as ddd 
from tblpessoa p
inner join tblpessoatelefone pt on (pt.codpessoa = p.codpessoa)
inner join tblcidade c on (c.codcidade = p.codcidade)
inner join tblestado e on (e.codestado = c.codestado)
where pt.ddd = 0
order by 3, 2

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