-- nossonumero saltado
WITH SequenciaOrdenada AS (
    SELECT
        codportador,
        -- 1. Remove zeros à esquerda ('0') e converte para NUMERIC
        LTRIM(nossonumero, '0')::numeric AS nossonumero_atual, 
        LAG(LTRIM(nossonumero, '0')::numeric) OVER (
            PARTITION BY codportador 
            -- 2. ORDENAÇÃO pelo valor NUMÉRICO, também sem os zeros
            ORDER BY LTRIM(nossonumero, '0')::numeric 
        ) AS nossonumero_anterior
    FROM
        tbltituloboleto
)
SELECT
    codportador,
    nossonumero_anterior AS anterior,
    nossonumero_atual AS proximo,
    (nossonumero_atual - nossonumero_anterior - 1) AS quantidade
FROM
    SequenciaOrdenada
WHERE
    (nossonumero_atual - nossonumero_anterior) > 1 
ORDER BY
    codportador,
    nossonumero_atual;

-- insere na base numeros saltados vinculados a um titulo de teste
with faixa as (
	select min(t.nossonumero)::numeric as min, max(t.nossonumero)::numeric as max
	from tbltituloboleto t 
	where t.codportador = :codportador
	--and t.vencimento >= '2024-01-01'
)
insert into tbltituloboleto (codtitulo, codportador, nossonumero, criacao)
select :codtitulo, :codportador, to_char(seq, 'FM00000000000000000000'), now()
from faixa, generate_series(faixa.min, faixa.max) seq
where not exists (
	select tit.codtitulo 
	from tbltituloboleto tit
	where tit.codportador = :codportador
	and tit.nossonumero::numeric = seq
)

-- consulta os boletos desse titulo de teste
select criacao, nossonumero, codportador, valororiginal,
	' curl https://api-mgspa.mgpapelaria.com.br/api/v1/titulo/' || t.codtitulo || '/boleto-bb/' || t.codtituloboleto || '/consultar -X POST  -H "Accept: text/json" | head -n 5'
from tbltituloboleto t 
where codtitulo  = :codtitulo 
order by criacao desc nulls last

-- apaga boletos que nao conseguiram ser consultados
delete 
from tbltituloboleto
where codtitulo  = :codtitulo 
and vencimento is null


select t.valororiginal is not null as consultou, count(*)
from tbltituloboleto t 
where t.codtitulo  = :codtitulo 
group by (t.valororiginal is not null)


select estadotitulocobranca, codportador, t.nossonumero 
from tbltituloboleto t 
where t.codtitulo  = :codtitulo 
and t.valororiginal is not null
and t.estadotitulocobranca not in (7)
order by codportador, nossonumero

select valororiginal, estadotitulocobranca, * 
from tbltituloboleto
where nossonumero >= '00033097820000011888'
and codportador = 5
order by nossonumero

select * from tbltituloboleto t where nossonumero = '00033097830000013594'


alter table tblnotafiscalprodutobarra add ordem smallint 

    


CREATE OR REPLACE FUNCTION set_ordem_nf_produto()
RETURNS TRIGGER AS $$
BEGIN
    -- Isso consulta a tabela e usa o valor que está sendo inserido (NEW.codnotafiscal)
    SELECT COALESCE(MAX(ordem), 0) + 1
    INTO NEW.ordem
    FROM tblnotafiscalprodutobarra
    WHERE codnotafiscal = NEW.codnotafiscal;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_set_ordem_nf_produto
BEFORE INSERT ON tblnotafiscalprodutobarra
FOR EACH ROW
EXECUTE FUNCTION set_ordem_nf_produto();


UPDATE tblnotafiscalprodutobarra t
SET ordem = sub.nova_ordem
FROM (
    -- 1. Subconsulta para calcular a ordem correta para cada item
    SELECT
        codnotafiscalprodutobarra,
        ROW_NUMBER() OVER (
            -- Recomeça a contagem para cada Nota Fiscal
            PARTITION BY codnotafiscal
            -- Define a ordem baseada na chave primária (codnotafiscalprodutobarra)
            ORDER BY codnotafiscalprodutobarra
        ) AS nova_ordem
    FROM tblnotafiscalprodutobarra
) AS sub
-- 2. Condição para aplicar a nova ordem na linha correta
WHERE t.codnotafiscalprodutobarra = sub.codnotafiscalprodutobarra
-- Opcional: Adicionar um WHERE NOT NULL se você só quer atualizar linhas que ainda não foram preenchidas
-- AND t.ordem IS NULL;
;



-- 2. Desabilita a execução dos gatilhos (Triggers) para ESTA SESSÃO
-- A trigger 'trg_set_ordem_nf_produto' será ignorada.
SET session_replication_role = 'replica';

-- 3. Executa o UPDATE para corrigir os registros antigos
RAISE NOTICE 'Iniciando a atualização dos registros antigos...';
UPDATE tblnotafiscalprodutobarra t
SET ordem = sub.nova_ordem
FROM (
    -- Subconsulta para calcular a ordem correta
    SELECT
        codnotafiscalprodutobarra,
        ROW_NUMBER() OVER (
            PARTITION BY codnotafiscal
            ORDER BY codnotafiscalprodutobarra
        ) AS nova_ordem
    FROM tblnotafiscalprodutobarra
    where tblnotafiscalprodutobarra.codnotafiscal in (
    	
    )
) AS sub
WHERE t.codnotafiscalprodutobarra = sub.codnotafiscalprodutobarra
and t.codnotafiscal in (

)
;

RAISE NOTICE 'Atualização concluída.';

-- 4. Re-Habilita a execução dos gatilhos para ESTA SESSÃO
SET session_replication_role = 'origin';