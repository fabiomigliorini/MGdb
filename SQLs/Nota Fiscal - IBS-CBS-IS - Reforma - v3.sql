drop table tbltributacaoregra;
drop table tblnotafiscalitemtributo;
drop table tblentetributante;
drop table tbltributo;


create table tblentetributante (
    codentetributante bigserial primary key,
    tipo varchar(15) not null,          -- UNIAO | ESTADO | MUNICIPIO
    codigo varchar(10) not null,         -- BR | ALL | IBGE
    descricao varchar(100) not null,
    criacao timestamp without time zone default now(),
    codusuariocriacao bigint references tblusuario (codusuario),
    alteracao timestamp without time zone default now(),
    codusuarioalteracao bigint references tblusuario (codusuario)
);

create unique index idxentetributante_tipocodigo
    on tblentetributante (tipo, codigo);


create table tbltributo (
    codtributo bigserial primary key,
    codigo varchar(10) not null,         -- CBS | IBS | IS
    descricao varchar(100) not null,
    criacao timestamp without time zone default now(),
    codusuariocriacao bigint references tblusuario (codusuario),
    alteracao timestamp without time zone default now(),
    codusuarioalteracao bigint references tblusuario (codusuario)
);

create unique index idxtributo_codigo
    on tbltributo (codigo);


create table tbltributacaoregra (
    codtributacaoregra bigserial primary key,

    codtributo bigint not null
        references tbltributo (codtributo),

    codentetributante bigint not null
        references tblentetributante (codentetributante),

    codnaturezaoperacao bigint
        references tblnaturezaoperacao (codnaturezaoperacao),

    ncm varchar(10),
    codtipoproduto bigint,

    codestadodestino bigint,
    codcidadedestino bigint,
    tipocliente char(2),

    basepercentual numeric(7,4) not null default 100,
    aliquota numeric(7,4) not null,

    cst varchar(3) not null,            -- CST-IBS/CBS (3 dígitos oficial)
    cclasstrib varchar(20) not null,     -- cClassTrib (oficial)

    geracredito boolean not null default false,
    beneficiocodigo varchar(20),
    observacoes text,
    vigenciainicio date not null,
    vigenciafim date,
 
    criacao timestamp without time zone default now(),
    codusuariocriacao bigint references tblusuario (codusuario),
    alteracao timestamp without time zone,
    codusuarioalteracao bigint references tblusuario (codusuario)
);

create index idxtributacaoregra_busca
on tbltributacaoregra (
    codtributo,
    codentetributante,
    codnaturezaoperacao,
    ncm,
    codestadodestino,
    codcidadedestino,
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

	basereducaopercentual numeric(7,4),
	basereducao numeric(14,2),

    base numeric(14,2) not null,
    aliquota numeric(7,4) not null,
    valor numeric(14,2) not null,

    cst varchar(3) not null,            -- CST-IBS/CBS
    cclasstrib varchar(20) not null,     -- cClassTrib

    geracredito boolean not null default false,
    valorcredito numeric(14,2),

    beneficiocodigo varchar(20),
    fundamentolegal text,

	criacao timestamp without time zone default now(),
    codusuariocriacao bigint references tblusuario (codusuario),
    alteracao timestamp without time zone,
    codusuarioalteracao bigint references tblusuario (codusuario)
);

comment on column tblnotafiscalitemtributo.base
is 'Base de cálculo tributável (já com redução aplicada)';

comment on column tblnotafiscalitemtributo.basereducao
is 'Valor reduzido da base de cálculo';

create unique index idxitemtributo_unico
on tblnotafiscalitemtributo (
    codnotafiscalprodutobarra,
    codtributo,
    codentetributante
);

create index idxitemtributoitem
    on tblnotafiscalitemtributo (codnotafiscalprodutobarra);

create index idxitemtributotributo
    on tblnotafiscalitemtributo (codtributo, codentetributante);


-- ENTES
insert into tblentetributante (tipo, codigo, descricao) values
('UNIAO', 'BR',  'União Federal'),
('ESTADO', 'ALL','Estados (IBS Estadual)'),
('MUNICIPIO','ALL','Municípios (IBS Municipal)');


-- TRIBUTOS
insert into tbltributo (codigo, descricao, codusuariocriacao)
values
('IBS', 'Imposto sobre Bens e Serviços', 1),
('CBS', 'Contribuição sobre Bens e Serviços', 1),
('IS',  'Imposto Seletivo', 1)
on conflict do nothing;


-- 🔹 1️⃣ VENDA (venda = true)
-- CBS – UNIÃO
insert into tbltributacaoregra (
 codtributo, codentetributante, codnaturezaoperacao,
 ncm, codtipoproduto, codestadodestino, codcidadedestino, tipocliente,
 basepercentual, aliquota,
 cst, cclasstrib,
 geracredito, beneficiocodigo, observacoes,
 vigenciainicio, vigenciafim, criacao, alteracao
)
select
 t.codtributo,
 e.codentetributante,
 n.codnaturezaoperacao,
 null, null, null, null, null,
 100, 0.90,
 '000', '000001',
 true, null, null,
 '2026-01-01', null, now(), now()
from tbltributo t
join tblentetributante e on e.tipo = 'UNIAO'
join tblnaturezaoperacao n on n.venda = true
where t.codigo = 'CBS';

-- IBS – ESTADO
insert into tbltributacaoregra (
 codtributo, codentetributante, codnaturezaoperacao,
 ncm, codtipoproduto, codestadodestino, codcidadedestino, tipocliente,
 basepercentual, aliquota,
 cst, cclasstrib,
 geracredito, beneficiocodigo, observacoes,
 vigenciainicio, vigenciafim, criacao, alteracao
)
select
 t.codtributo,
 e.codentetributante,
 n.codnaturezaoperacao,
 null, null, null, null, null,
 100, 0.10,
 '000', '000001',
 true, null, null,
 '2026-01-01', null, now(), now()
from tbltributo t
join tblentetributante e on e.tipo = 'ESTADO'
join tblnaturezaoperacao n on n.venda = true
where t.codigo = 'IBS';

-- IBS – MUNICÍPIO
insert into tbltributacaoregra (
 codtributo, codentetributante, codnaturezaoperacao,
 ncm, codtipoproduto, codestadodestino, codcidadedestino, tipocliente,
 basepercentual, aliquota,
 cst, cclasstrib,
 geracredito, beneficiocodigo, observacoes,
 vigenciainicio, vigenciafim, criacao, alteracao
)
select
 t.codtributo,
 e.codentetributante,
 n.codnaturezaoperacao,
 null, null, null, null, null,
 100, 0.00,
 '000', '000001',
 true, null, null,
 '2026-01-01', null, now(), now()
from tbltributo t
join tblentetributante e on e.tipo = 'MUNICIPIO'
join tblnaturezaoperacao n on n.venda = true
where t.codigo = 'IBS';

-- 🔹 2️⃣ COMPRA (compra = true)
insert into tbltributacaoregra (
 codtributo, codentetributante, codnaturezaoperacao,
 ncm, codtipoproduto, codestadodestino, codcidadedestino, tipocliente,
 basepercentual, aliquota,
 cst, cclasstrib,
 geracredito, beneficiocodigo, observacoes,
 vigenciainicio, vigenciafim, criacao, alteracao
)
select
 t.codtributo,
 e.codentetributante,
 n.codnaturezaoperacao,
 null, null, null, null, null,
 100,
 case when t.codigo = 'CBS' then 0.90 else 0.10 end,
 '000', '000001',
 true, null, null,
 '2026-01-01', null, now(), now()
from tbltributo t
join tblentetributante e on e.tipo in ('UNIAO','ESTADO','MUNICIPIO')
join tblnaturezaoperacao n on n.compra = true
where t.codigo in ('CBS','IBS');

-- 🔹 3️⃣ TRANSFERÊNCIA (transferencia = true)
insert into tbltributacaoregra (
 codtributo, codentetributante, codnaturezaoperacao,
 ncm, codtipoproduto, codestadodestino, codcidadedestino, tipocliente,
 basepercentual, aliquota,
 cst, cclasstrib,
 geracredito, beneficiocodigo, observacoes,
 vigenciainicio, vigenciafim, criacao, alteracao
)
select
 t.codtributo,
 e.codentetributante,
 n.codnaturezaoperacao,
 null, null, null, null, null,
 100, 0.00,
 '090', '090000',
 false, null, null,
 '2026-01-01', null, now(), now()
from tbltributo t
join tblentetributante e on e.tipo in ('UNIAO','ESTADO','MUNICIPIO')
join tblnaturezaoperacao n on n.transferencia = true
where t.codigo in ('CBS','IBS');

-- 🔹 4️⃣ DEVOLUÇÃO (vendadevolucao / compradevolucao)
insert into tbltributacaoregra (
 codtributo, codentetributante, codnaturezaoperacao,
 ncm, codtipoproduto, codestadodestino, codcidadedestino, tipocliente,
 basepercentual, aliquota,
 cst, cclasstrib,
 geracredito, beneficiocodigo, observacoes,
 vigenciainicio, vigenciafim, criacao, alteracao
)
select
 t.codtributo,
 e.codentetributante,
 n.codnaturezaoperacao,
 null, null, null, null, null,
 100,
 case when t.codigo = 'CBS' then 0.90 else 0.10 end,
 '000', '000001',
 true, null, null,
 '2026-01-01', null, now(), now()
from tbltributo t
join tblentetributante e on e.tipo in ('UNIAO','ESTADO','MUNICIPIO')
join tblnaturezaoperacao n
 on (n.vendadevolucao = true or n.codnaturezaoperacao = 3 )
where t.codigo in ('CBS','IBS');

--  5️⃣ DOAÇÃO / BONIFICAÇÃO / BRINDE
insert into tbltributacaoregra (
 codtributo, codentetributante, codnaturezaoperacao,
 ncm, codtipoproduto, codestadodestino, codcidadedestino, tipocliente,
 basepercentual, aliquota,
 cst, cclasstrib,
 geracredito, beneficiocodigo, observacoes,
 vigenciainicio, vigenciafim, criacao, alteracao
)
select
 t.codtributo,
 e.codentetributante,
 n.codnaturezaoperacao,
 null, null, null, null, null,
 0, 0.00,
 '040', '040000',
 false, null, null,
 '2026-01-01', null, now(), now()
from tbltributo t
join tblentetributante e on e.tipo in ('UNIAO','ESTADO','MUNICIPIO')
join tblnaturezaoperacao n
 on (n.codnaturezaoperacao in (8, 17))
where t.codigo in ('CBS','IBS','IS');


/*
update tbltributacaoregra set vigenciainicio = '2025-01-01'

select vigenciainicio from tbltributacaoregra

select * from tblnotafiscalitemtributo
*/