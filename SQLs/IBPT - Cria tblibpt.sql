-- Tabela do IBPT (De Olho no Imposto) para calculo dos tributos aproximados (Lei 12.741).
--
-- Substitui a tblibptcache, que replicava o mesmo dado para cada filial. Os percentuais
-- so variam por UF de destino e NCM - o CNPJ/token da filial e apenas autenticacao na
-- API deles. Sao ~328 mil linhas no lugar de milhoes.
--
-- A carga e feita pela tela Parametrizacao > Tabela IBPT do app de notas, que recebe os
-- 27 CSVs baixados do site do IBPT. A tblibptcache e a tblibptaxcsv ficam orfas e devem
-- ser removidas so depois de algumas emissoes validadas em producao.

CREATE TABLE mgsis.tblibpt (
    codibpt bigserial NOT NULL,
    codestado bigint NOT NULL,
    ncm character varying(20) NOT NULL,
    extarif smallint NOT NULL DEFAULT 0,
    descricao character varying(400),
    nacional numeric(5,3),
    estadual numeric(5,3),
    importado numeric(5,3),
    municipal numeric(5,3),
    tipo smallint,
    vigenciainicio date,
    vigenciafim date,
    chave character varying(20),
    versao character varying(20),
    fonte character varying(50),
    criacao timestamp(0) without time zone DEFAULT now(),
    codusuariocriacao bigint,
    alteracao timestamp(0) without time zone DEFAULT now(),
    codusuarioalteracao bigint,
    CONSTRAINT pk_tblibpt PRIMARY KEY (codibpt),
    CONSTRAINT tblibpt_uk UNIQUE (codestado, ncm, extarif),
    CONSTRAINT fk_tblibpt_tblestado FOREIGN KEY (codestado)
        REFERENCES mgsis.tblestado (codestado) ON UPDATE CASCADE,
    CONSTRAINT fk_tblibpt_tblusuario FOREIGN KEY (codusuariocriacao)
        REFERENCES mgsis.tblusuario (codusuario) ON UPDATE CASCADE,
    CONSTRAINT fk_tblibpt_tblusuario_0 FOREIGN KEY (codusuarioalteracao)
        REFERENCES mgsis.tblusuario (codusuario) ON UPDATE CASCADE
);

-- Nao precisa de indice proprio em codestado: o tblibpt_uk (codestado, ncm, extarif)
-- ja atende as buscas, e o nome idx_tblibpt_codestado esta ocupado pela tblibptcache.
CREATE INDEX idx_tblibpt_codusuariocriacao ON mgsis.tblibpt (codusuariocriacao);
CREATE INDEX idx_tblibpt_codusuarioalteracao ON mgsis.tblibpt (codusuarioalteracao);



SELECT * from TBLINUTILIZACAO where CODFILIAL = 102  and MODELO = 55 and 74577 >= numeroinicial and 74577 <= NUMEROFINAL

SELECT * from TBLNOTAFISCAL where CODFILIAL = 102  and MODELO = 55 and 74577 = NUMERO 




-- 1) confirma que a 74577 esta mascarada por uma nota de ENTRADA
SELECT codnotafiscal, serie, numero, emitida, emissao, codnaturezaoperacao
FROM tblnotafiscal
WHERE codfilial = 102 AND modelo = 55 AND numero = 74577;

-- 2) confirma que a 74577 esta dentro da janela varrida (min/max de 90 dias)
SELECT min(numero), max(numero)
FROM tblnotafiscal
WHERE codfilial = 102 AND modelo = 55 AND serie = 1
  AND emitida = true AND numero > 0
  AND emissao >= NOW() - INTERVAL '90 days';


-- 3) quantas lacunas a correcao destrava nessa filial/serie
--    (troque :mn e :mx pelo resultado da consulta 2)
SELECT s.numero
FROM generate_series(:mn, :mx) AS s(numero)
LEFT JOIN tblnotafiscal nf
  ON nf.numero = s.numero AND nf.codfilial = 102 AND nf.serie = 1
 AND nf.modelo = 55 AND nf.emitida = true
WHERE nf.codnotafiscal IS NULL
AND NOT EXISTS (
  SELECT 1 FROM tblinutilizacao i
  WHERE i.codfilial = 102 AND i.modelo = 55 AND i.serie = 1
    AND i.protocolo IS NOT NULL
    AND s.numero BETWEEN i.numeroinicial AND i.numerofinal
)
ORDER BY 1;


select * from tblinutilizacao where protocolodata is null


select * from tblinutilizacao t where t.numerofinal = 23480