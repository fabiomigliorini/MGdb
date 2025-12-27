-- 🔴 1️⃣ DROP (ordem segura)
DROP TABLE IF EXISTS tbltributacaoregra;
DROP TABLE IF EXISTS tblnotafiscalitemtributo;
DROP TABLE IF EXISTS tbltributo;
DROP TABLE IF EXISTS tblentetributante;

-- 🟦 2️⃣ TABELA tbltributo (TRIBUTO + ENTE)
CREATE TABLE tbltributo (
    codtributo BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(10) NOT NULL,            -- CBS | IBS | IS
    descricao VARCHAR(100) NOT NULL,
    ente VARCHAR(15) NOT NULL               -- FEDERAL | ESTADUAL | MUNICIPAL
        CHECK (ente IN ('FEDERAL','ESTADUAL','MUNICIPAL')),
    criacao TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    codusuariocriacao BIGINT REFERENCES tblusuario (codusuario),
    alteracao TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    codusuarioalteracao BIGINT REFERENCES tblusuario (codusuario)
);

CREATE UNIQUE INDEX idxtributo_codigo_ente
ON tbltributo (codigo, ente);

-- 🟦 3️⃣ TABELA tbltributacaoregra
CREATE TABLE tbltributacaoregra (
    codtributacaoregra BIGSERIAL PRIMARY KEY,

    codtributo BIGINT NOT NULL
        REFERENCES tbltributo (codtributo),

    codnaturezaoperacao BIGINT
        REFERENCES tblnaturezaoperacao (codnaturezaoperacao),

    ncm VARCHAR(10),
    codtipoproduto BIGINT,

    codestadodestino BIGINT,
    codcidadedestino BIGINT,
    tipocliente CHAR(2),

    basepercentual NUMERIC(7,4) NOT NULL DEFAULT 100,
    aliquota NUMERIC(7,4) NOT NULL,

    cst VARCHAR(3) NOT NULL,
    cclasstrib VARCHAR(20) NOT NULL,

    geracredito BOOLEAN NOT NULL DEFAULT FALSE,
    beneficiocodigo VARCHAR(20),
    observacoes TEXT,

    vigenciainicio DATE NOT NULL,
    vigenciafim DATE,

    criacao TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    codusuariocriacao BIGINT REFERENCES tblusuario (codusuario),
    alteracao TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    codusuarioalteracao BIGINT REFERENCES tblusuario (codusuario)
);

-- 🟦 4️⃣ ÍNDICES DO MOTOR DE REGRAS
CREATE INDEX idxtributacaoregra_busca
ON tbltributacaoregra (
    codtributo,
    codnaturezaoperacao,
    ncm,
    codestadodestino,
    codcidadedestino,
    tipocliente,
    vigenciainicio,
    vigenciafim
);

CREATE INDEX idxtributacaoregra_nxmlength
ON tbltributacaoregra (LENGTH(ncm) DESC)
WHERE ncm IS NOT NULL;

CREATE INDEX idxtributacaoregra_natureza
ON tbltributacaoregra (codnaturezaoperacao);

CREATE INDEX idxtributacaoregra_geo
ON tbltributacaoregra (codestadodestino, codcidadedestino);

-- 🟦 5️⃣ TABELA tblnotafiscalitemtributo
CREATE TABLE tblnotafiscalitemtributo (
    codnotafiscalitemtributo BIGSERIAL PRIMARY KEY,

    codnotafiscalprodutobarra BIGINT NOT NULL
        REFERENCES tblnotafiscalprodutobarra (codnotafiscalprodutobarra),

    codtributo BIGINT NOT NULL
        REFERENCES tbltributo (codtributo),

    basereducaopercentual NUMERIC(7,4),
    basereducao NUMERIC(14,2),

    base NUMERIC(14,2) NOT NULL,
    aliquota NUMERIC(7,4) NOT NULL,
    valor NUMERIC(14,2) NOT NULL,

    cst VARCHAR(3) NOT NULL,
    cclasstrib VARCHAR(20) NOT NULL,

    geracredito BOOLEAN NOT NULL DEFAULT FALSE,
    valorcredito NUMERIC(14,2),

    beneficiocodigo VARCHAR(20),
    fundamentolegal TEXT,

    criacao TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    codusuariocriacao BIGINT REFERENCES tblusuario (codusuario),
    alteracao TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    codusuarioalteracao BIGINT REFERENCES tblusuario (codusuario)
);

-- Comentários
COMMENT ON COLUMN tblnotafiscalitemtributo.base
IS 'Base de cálculo tributável (já com redução aplicada)';

COMMENT ON COLUMN tblnotafiscalitemtributo.basereducao
IS 'Valor reduzido da base de cálculo';

-- 🟦 6️⃣ ÍNDICES DO ITEM TRIBUTO
CREATE UNIQUE INDEX idxitemtributo_unico
ON tblnotafiscalitemtributo (
    codnotafiscalprodutobarra,
    codtributo
);

CREATE INDEX idxitemtributo_item
ON tblnotafiscalitemtributo (codnotafiscalprodutobarra);

CREATE INDEX idxitemtributo_tributo
ON tblnotafiscalitemtributo (codtributo);

-- 🟩 7️⃣ CARGA INICIAL – TRIBUTOS
INSERT INTO tbltributo (codigo, descricao, ente, codusuariocriacao)
VALUES
('CBS','Contribuição sobre Bens e Serviços','FEDERAL',1),
('IBS','Imposto sobre Bens e Serviços','ESTADUAL',1),
('IBS','Imposto sobre Bens e Serviços','MUNICIPAL',1),
('IS','Imposto Seletivo','FEDERAL',1)
ON CONFLICT DO NOTHING;

-- 🟨 8️⃣ CARGA INICIAL – REGRAS TRIBUTÁRIAS
-- 🔹 1️⃣ VENDA
-- CBS FEDERAL
INSERT INTO tbltributacaoregra
SELECT nextval('tbltributacaoregra_codtributacaoregra_seq'),
 t.codtributo, n.codnaturezaoperacao,
 null,null,null,null,null,
 100,0.90,'000','000001',
 true,null,null,
 '2026-01-01',null,now(),1,now(),1
FROM tbltributo t
JOIN tblnaturezaoperacao n ON n.venda = true
WHERE t.codigo='CBS' AND t.ente='FEDERAL';

-- IBS ESTADUAL
INSERT INTO tbltributacaoregra
SELECT nextval('tbltributacaoregra_codtributacaoregra_seq'),
 t.codtributo, n.codnaturezaoperacao,
 null,null,null,null,null,
 100,0.10,'000','000001',
 true,null,null,
 '2026-01-01',null,now(),1,now(),1
FROM tbltributo t
JOIN tblnaturezaoperacao n ON n.venda = true
WHERE t.codigo='IBS' AND t.ente='ESTADUAL';

-- IBS MUNICIPAL
INSERT INTO tbltributacaoregra
SELECT nextval('tbltributacaoregra_codtributacaoregra_seq'),
 t.codtributo, n.codnaturezaoperacao,
 null,null,null,null,null,
 100,0.00,'000','000001',
 true,null,null,
 '2026-01-01',null,now(),1,now(),1
FROM tbltributo t
JOIN tblnaturezaoperacao n ON n.venda = true
WHERE t.codigo='IBS' AND t.ente='MUNICIPAL';

-- 🔹 2️⃣ COMPRA
INSERT INTO tbltributacaoregra
SELECT nextval('tbltributacaoregra_codtributacaoregra_seq'),
 t.codtributo, n.codnaturezaoperacao,
 null,null,null,null,null,
 100,
 CASE WHEN t.codigo='CBS' THEN 0.90 ELSE 0.10 END,
 '000','000001',
 true,null,null,
 '2026-01-01',null,now(),1,now(),1
FROM tbltributo t
JOIN tblnaturezaoperacao n ON n.compra = true
WHERE t.codigo IN ('CBS','IBS');

-- 🔹 3️⃣ TRANSFERÊNCIA
INSERT INTO tbltributacaoregra
SELECT nextval('tbltributacaoregra_codtributacaoregra_seq'),
 t.codtributo, n.codnaturezaoperacao,
 null,null,null,null,null,
 100,0.00,'090','090000',
 false,null,null,
 '2026-01-01',null,now(),1,now(),1
FROM tbltributo t
JOIN tblnaturezaoperacao n ON n.transferencia = true
WHERE t.codigo IN ('CBS','IBS');

-- 🔹 4️⃣ DEVOLUÇÃO
INSERT INTO tbltributacaoregra
SELECT nextval('tbltributacaoregra_codtributacaoregra_seq'),
 t.codtributo, n.codnaturezaoperacao,
 null,null,null,null,null,
 100,
 CASE WHEN t.codigo='CBS' THEN 0.90 ELSE 0.10 END,
 '000','000001',
 true,null,null,
 '2026-01-01',null,now(),1,now(),1
FROM tbltributo t
JOIN tblnaturezaoperacao n
 ON (n.vendadevolucao=true OR n.codnaturezaoperacao=3)
WHERE t.codigo IN ('CBS','IBS');

-- 🔹 5️⃣ DOAÇÃO / BONIFICAÇÃO / BRINDE
INSERT INTO tbltributacaoregra
SELECT nextval('tbltributacaoregra_codtributacaoregra_seq'),
 t.codtributo, n.codnaturezaoperacao,
 null,null,null,null,null,
 0,0.00,'040','040000',
 false,null,null,
 '2026-01-01',null,now(),1,now(),1
FROM tbltributo t
JOIN tblnaturezaoperacao n
 ON n.codnaturezaoperacao IN (8,17)
WHERE t.codigo IN ('CBS','IBS','IS');

