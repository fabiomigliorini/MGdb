-- Cria titulo no Contas a Receber
INSERT INTO mgsis.tbltitulo
(codtipotitulo, codfilial, codportador, codpessoa, codcontacontabil, numero, fatura, transacao, sistema, emissao, vencimento, vencimentooriginal, debito, credito, gerencial, observacao, boleto, nossonumero, debitototal, creditototal, saldo, debitosaldo, creditosaldo, transacaoliquidacao, codnegocioformapagamento, codtituloagrupamento, remessa, estornado, alteracao, codusuarioalteracao, criacao, codusuariocriacao, codvalecompraformapagamento)
SELECT 
	240 as codtipotitulo,
	vc.codfilial,
	null as codportador,
	vc.codpessoa,
	82 as codcontacontabil,
	'V' || lpad(cast(vc.codvalecompra as varchar), 8, '0') || '-1/1' as numero,
	null as fatura,
	vc.criacao as transacao,
	vc.criacao as sistema,
	vc.criacao as emissao,
	vc.criacao as vencimento,
	vc.criacao as vencimentooriginal,
	vc.total as debito,
	null as credito,
	true as gerencial,
	'Convertido para Entrega a Vista' as observacao,
	false as boleto,
	null as nossonumero,
	vc.total as debitototal,
	0 as creditototal,
	vc.total as saldo,
	vc.total as debitosaldo,
	0 as creditosaldo,
	null as transacaoliquidacao,
	null as codnegocioformapagamento,
	null as codtituloagrupamento,
	null as remessa,
	null as estornado,
	vc.alteracao,
	vc.codusuarioalteracao,
	vc.criacao,
	vc.codusuariocriacao,
	(
		select min(vcfp.codvalecompraformapagamento) 
		from tblvalecompraformapagamento vcfp 
		where vcfp.codvalecompra = vc.codvalecompra 
	) as codvalecompraformapagamento
FROM tblvalecompra vc 
where vc.codvalecompra  = :codvalecompra 
and vc.codvalecompra not in (
	select vcfp.codvalecompra
	from tbltitulo t 
	inner join tblvalecompraformapagamento vcfp on (vcfp.codvalecompraformapagamento = t.codvalecompraformapagamento and vcfp.codvalecompra = vc.codvalecompra)
)
;

-- Altera Forma Pagamento pra "Entrega A Vista"
update tblvalecompraformapagamento set codformapagamento = 1099 where codvalecompra = :codvalecompra and codformapagamento != 1099 

