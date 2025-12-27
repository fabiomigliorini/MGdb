drop table tbltributacaoregra;
drop table tblnotafiscalitemtributo;
drop table tblentetributante;
drop table tbltributo;


create table tblentetributante (
    codentetributante bigserial primary key,
    tipo varchar(15) not null,              -- UNIAO | ESTADO | MUNICIPIO
    codigo varchar(10) not null,             -- BR | MT | codigo IBGE do município
    descricao varchar(100) not null,
    criacao timestamp without time zone default now(),
    codusuariocriacao bigint references tblusuario (codusuario),
    alteracao timestamp without time zone,
    codusuarioalteracao bigint references tblusuario (codusuario)
);

create unique index idxentetributantetipo
    on tblentetributante (tipo, codigo);

create table tbltributo (
    codtributo bigserial primary key,
    codigo varchar(10) not null,          -- IBS | CBS | IS
    descricao varchar(100) not null,
    criacao timestamp without time zone default now(),
    codusuariocriacao bigint references tblusuario (codusuario),
    alteracao timestamp without time zone,
    codusuarioalteracao bigint references tblusuario (codusuario)
);

create unique index idxtributocodigo
    on tbltributo (codigo);

create table tbltributacaoregra (
    codtributacaoregra bigserial primary key,
    codtributo bigint not null
        references tbltributo (codtributo),
    codentetributante bigint not null
        references tblentetributante (codentetributante),
    codnaturezaoperacao bigint
        references tblnaturezaoperacao (codnaturezaoperacao),
    codtipoproduto bigint,
    ncm varchar(10),
    codestadodestino bigint
        references tblestado (codestado),
    codcidadedestino bigint
        references tblcidade (codcidade),
    tipocliente char(2),                   -- PF | PJ
    basepercentual numeric(7,4) not null default 100,
    aliquota numeric(7,4) not null,
    geracredito boolean not null default false,
    beneficiocodigo varchar(20),
    vigenciainicio date not null,
    vigenciafim date,
    observacoes text,
    criacao timestamp without time zone default now(),
    codusuariocriacao bigint references tblusuario (codusuario),
    alteracao timestamp without time zone,
    codusuarioalteracao bigint references tblusuario (codusuario)
);

create index idxtributacaoregrabusca
on tbltributacaoregra (
    codtributo,
    codentetributante,
    codestadodestino,
    codcidadedestino,
    codnaturezaoperacao,
    ncm,
    tipocliente,
    vigenciainicio,
    vigenciafim
);

create table tblnotafiscalitemtributo (
    codnotafiscalitemtributo bigserial primary key,
    codnotafiscalprodutobarra bigint not null
        references tblnotafiscalprodutobarra (codnotafiscalprodutobarra),
    codtributo bigint not null
        references tbltributo (codtributo),
    codentetributante bigint not null
        references tblentetributante (codentetributante),
    base numeric(14,2) not null,
    aliquota numeric(7,4) not null,
    valor numeric(14,2) not null,
    geracredito boolean not null default false,
    valorcredito numeric(14,2),
    beneficiocodigo varchar(20),
    fundamentolegal text,
    criacao timestamp without time zone default now(),
    codusuariocriacao bigint references tblusuario (codusuario),
    alteracao timestamp without time zone,
    codusuarioalteracao bigint references tblusuario (codusuario)
);

create index idxitemtributoitem
    on tblnotafiscalitemtributo (codnotafiscalprodutobarra);

create index idxitemtributotributo
    on tblnotafiscalitemtributo (codtributo, codentetributante);

create unique index idxitemtributounico
on tblnotafiscalitemtributo (
    codnotafiscalprodutobarra,
    codtributo,
    codentetributante
);


-- UNIÃO
insert into tblentetributante (tipo, codigo, descricao, codusuariocriacao)
values ('UNIAO', 'BR', 'União Federal', 1)
on conflict do nothing;

-- ESTADOS (IBS estadual – genérico)
insert into tblentetributante (tipo, codigo, descricao, codusuariocriacao)
values ('ESTADO', 'GEN', 'Estados (IBS estadual)', 1)
on conflict do nothing;

-- MUNICÍPIOS (IBS municipal – genérico)
insert into tblentetributante (tipo, codigo, descricao, codusuariocriacao)
values ('MUNICIPIO', 'GEN', 'Municípios (IBS municipal)', 1)
on conflict do nothing;


-- TRIBUTOS
insert into tbltributo (codigo, descricao, codusuariocriacao)
values
('IBS', 'Imposto sobre Bens e Serviços', 1),
('CBS', 'Contribuição sobre Bens e Serviços', 1),
('IS',  'Imposto Seletivo', 1)
on conflict do nothing;


-- VENDA 

-- IBS ESTADUAL
insert into tbltributacaoregra (
    codtributo, codentetributante, codnaturezaoperacao,
    codestadodestino, codcidadedestino,
    basepercentual, aliquota, geracredito,
    vigenciainicio, codusuariocriacao, observacoes
)
select
    t.codtributo,
    e.codentetributante,
    n.codnaturezaoperacao,
    null, null,
    100,
    0.1000,
    false,
    '2026-01-01',
    1,
    'IBS estadual genérico – venda (0,1%)'
from tbltributo t
join tblentetributante e
  on e.tipo = 'ESTADO' and e.codigo = 'GEN'
join tblnaturezaoperacao n
  on n.venda = true
where t.codigo = 'IBS';

-- IBS MUN
insert into tbltributacaoregra (
    codtributo, codentetributante, codnaturezaoperacao,
    codestadodestino, codcidadedestino,
    basepercentual, aliquota, geracredito,
    vigenciainicio, codusuariocriacao, observacoes
)
select
    t.codtributo,
    e.codentetributante,
    n.codnaturezaoperacao,
    null, null,
    100,
    0.0000,
    false,
    '2026-01-01',
    1,
    'IBS municipal genérico – venda (0%)'
from tbltributo t
join tblentetributante e
  on e.tipo = 'MUNICIPIO' and e.codigo = 'GEN'
join tblnaturezaoperacao n
  on n.venda = true
where t.codigo = 'IBS';

-- CBS UNIAO
insert into tbltributacaoregra (
    codtributo, codentetributante, codnaturezaoperacao,
    codestadodestino, codcidadedestino,
    basepercentual, aliquota, geracredito,
    vigenciainicio, codusuariocriacao, observacoes
)
select
    t.codtributo,
    e.codentetributante,
    n.codnaturezaoperacao,
    null, null,
    100,
    0.9000,
    false,
    '2026-01-01',
    1,
    'CBS genérica nacional – venda (0,9%)'
from tbltributo t
join tblentetributante e
  on e.tipo = 'UNIAO'
join tblnaturezaoperacao n
  on n.venda = true
where t.codigo = 'CBS';


-- COMPRA

-- IBS ESTADUAL
insert into tbltributacaoregra (
    codtributo, codentetributante, codnaturezaoperacao,
    codestadodestino, codcidadedestino,
    basepercentual, aliquota, geracredito,
    vigenciainicio, codusuariocriacao, observacoes
)
select
    t.codtributo,
    e.codentetributante,
    n.codnaturezaoperacao,
    null, null,
    100,
    0.1000,
    true,
    '2026-01-01',
    1,
    'IBS estadual – crédito na compra (0,1%)'
from tbltributo t
join tblentetributante e
  on e.tipo = 'ESTADO' and e.codigo = 'GEN'
join tblnaturezaoperacao n
  on n.compra = true
where t.codigo = 'IBS';


-- IBS MUN
insert into tbltributacaoregra (
    codtributo, codentetributante, codnaturezaoperacao,
    codestadodestino, codcidadedestino,
    basepercentual, aliquota, geracredito,
    vigenciainicio, codusuariocriacao, observacoes
)
select
    t.codtributo,
    e.codentetributante,
    n.codnaturezaoperacao,
    null, null,
    100,
    0.0000,
    true,
    '2026-01-01',
    1,
    'IBS municipal – crédito na compra (0%)'
from tbltributo t
join tblentetributante e
  on e.tipo = 'MUNICIPIO' and e.codigo = 'GEN'
join tblnaturezaoperacao n
  on n.compra = true
where t.codigo = 'IBS';

-- CBS
insert into tbltributacaoregra (
    codtributo, codentetributante, codnaturezaoperacao,
    codestadodestino, codcidadedestino,
    basepercentual, aliquota, geracredito,
    vigenciainicio, codusuariocriacao, observacoes
)
select
    t.codtributo,
    e.codentetributante,
    n.codnaturezaoperacao,
    null, null,
    100,
    0.9000,
    true,
    '2026-01-01',
    1,
    'CBS – crédito na compra (0,9%)'
from tbltributo t
join tblentetributante e
  on e.tipo = 'UNIAO'
join tblnaturezaoperacao n
  on n.compra = true
where t.codigo = 'CBS';


-- DEVOLUCAO

-- IBS ESTORNO
insert into tbltributacaoregra (
    codtributo, codentetributante, codnaturezaoperacao,
    codestadodestino, codcidadedestino,
    basepercentual, aliquota, geracredito,
    vigenciainicio, codusuariocriacao, observacoes
)
select
    r.codtributo,
    r.codentetributante,
    n.codnaturezaoperacao,
    null, null,
    100,
    -1 * r.aliquota,
    false,
    '2026-01-01',
    1,
    'Devolução de venda – estorno IBS'
from tbltributacaoregra r
join tbltributo t
  on t.codtributo = r.codtributo
join tblnaturezaoperacao n
  on n.vendadevolucao = true
where r.codnaturezaoperacao in (
    select codnaturezaoperacao
    from tblnaturezaoperacao
    where venda = true
)
and t.codigo = 'IBS';


-- CBS ESTORNO
insert into tbltributacaoregra (
    codtributo, codentetributante, codnaturezaoperacao,
    codestadodestino, codcidadedestino,
    basepercentual, aliquota, geracredito,
    vigenciainicio, codusuariocriacao, observacoes
)
select
    r.codtributo,
    r.codentetributante,
    n.codnaturezaoperacao,
    null, null,
    100,
    -1 * r.aliquota,
    false,
    '2026-01-01',
    1,
    'Devolução de venda – estorno CBS'
from tbltributacaoregra r
join tbltributo t
  on t.codtributo = r.codtributo
join tblnaturezaoperacao n
  on n.vendadevolucao = true
where r.codnaturezaoperacao in (
    select codnaturezaoperacao
    from tblnaturezaoperacao
    where venda = true
)
and t.codigo = 'CBS';


-- TRANSFERENCIA (NAO INCIDE)
insert into tbltributacaoregra (
    codtributo, codentetributante, codnaturezaoperacao,
    codestadodestino, codcidadedestino,
    basepercentual, aliquota, geracredito,
    vigenciainicio, codusuariocriacao, observacoes
)
select
    t.codtributo,
    e.codentetributante,
    n.codnaturezaoperacao,
    null, null,
    0,
    0,
    false,
    '2026-01-01',
    1,
    'Transferência entre filiais – não incidência'
from tbltributo t
join tblentetributante e
  on e.codigo = 'GEN'
join tblnaturezaoperacao n
  on n.transferencia = true
where t.codigo in ('IBS','CBS');



select * from TBLENTETRIBUTANTE