/*
select column_name, column_default, c.is_nullable, c.data_type, c.numeric_precision, c.numeric_scale 
from information_schema."columns" c 
where c.table_name = 'tblnotafiscalprodutobarra'

select column_name, column_default, c.is_nullable, c.data_type, c.numeric_precision, c.numeric_scale 
from information_schema."columns" c 
where c.table_name = 'tblcidade'

select column_name, column_default, c.is_nullable, c.data_type, c.numeric_precision, c.numeric_scale 
from information_schema."columns" c 
where c.table_name = 'tblnaturezaoperacao'



select codnaturezaoperacao, naturezaoperacao, codoperacao, finnfe, venda, compra, vendadevolucao, transferencia from tblnaturezaoperacao

*/

ALTER TABLE tblnotafiscalprodutobarra 
    -- IBS
    ADD COLUMN ibsbase NUMERIC(15,2),
    ADD COLUMN ibspercentual NUMERIC(15,4),
    ADD COLUMN ibsvalor NUMERIC(15,2),
    -- CBS
    ADD COLUMN cbsbase NUMERIC(15,2),
    ADD COLUMN cbspercentual NUMERIC(15,4),
    ADD COLUMN cbsvalor NUMERIC(15,2),
    -- IS (Imposto Seletivo)
    ADD COLUMN isbase NUMERIC(15,2),
    ADD COLUMN ispercentual NUMERIC(15,4),
    ADD COLUMN isvalor NUMERIC(15,2);

ALTER TABLE tblnotafiscalprodutobarra 
    -- IBS
    ADD COLUMN ibscst VARCHAR(3),
    -- CBS
    ADD COLUMN cbscst VARCHAR(3),
    -- IS (Imposto Seletivo)
    ADD COLUMN iscst VARCHAR(3);

    
ALTER TABLE tbltributacaonaturezaoperacao 
    ADD COLUMN ibspercentual NUMERIC(15,4),
    ADD COLUMN ibscst VARCHAR(3),
    ADD COLUMN cbspercentual NUMERIC(15,4),
    ADD COLUMN cbscst VARCHAR(3),
    ADD COLUMN ispercentual NUMERIC(15,4),
    ADD COLUMN iscst VARCHAR(3);

-- 1. Aplicando alíquotas para todas as OPERAÇÕES DE VENDA
-- Inclui: Venda de Mercadoria (1), Venda Consumidor Final (14), Venda Produção Agrícola (46)
UPDATE tbltributacaonaturezaoperacao
SET ibspercentual = 0.1000,
    cbspercentual = 0.9000,
    ispercentual  = 0.0000,
    ibscst = '00', -- Exemplo de CST para Tributada Integralmente
    cbscst = '00'
WHERE codnaturezaoperacao IN (1, 14, 46);

-- 2. Aplicando alíquotas para DEVOLUÇÕES (Saídas)
-- Importante para anular o crédito da entrada original
-- Inclui: Devolucao de Compra p/ Industrializacao (10), Devolucao de Compra p/ Comercializacao (11)
UPDATE tbltributacaonaturezaoperacao
SET ibspercentual = 0.1000,
    cbspercentual = 0.9000,
    ispercentual  = 0.0000,
    ibscst = '20', -- Exemplo de CST para Devolução
    cbscst = '20'
WHERE codnaturezaoperacao IN (10, 11);

-- 3. Aplicando para BONIFICAÇÕES E BRINDES
-- Pela nova regra, saídas a título gratuito também são fatos geradores
UPDATE tbltributacaonaturezaoperacao
SET ibspercentual = 0.1000,
    cbspercentual = 0.9000,
    ispercentual  = 0.0000
WHERE codnaturezaoperacao = 17;

-- 4. Garantindo ALÍQUOTA ZERO para Transferências e Remessas
-- Inclui: Transferencia Saida (15), Remessa em Garantia (12), Outras Saidas (8)
UPDATE tbltributacaonaturezaoperacao
SET ibspercentual = 0.0000,
    cbspercentual = 0.0000,
    ispercentual  = 0.0000,
    ibscst = '90', -- Outras/Isenta
    cbscst = '90'
WHERE codnaturezaoperacao IN (15, 12, 8, 19);



    
alter table     
    

