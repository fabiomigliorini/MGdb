delete from tblestoquemovimento 
where codestoquemovimento in (
	select mov.codestoquemovimento 
	from tblproduto p
	inner join tblprodutovariacao pv on (pv.codproduto = p.codproduto)
	inner join tblestoquelocalprodutovariacao elpv on (elpv.codprodutovariacao = pv.codprodutovariacao)
	inner join tblestoquesaldo sld on (sld.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao)
	inner join tblestoquemes mes on (mes.codestoquesaldo = sld.codestoquesaldo)
	inner join tblestoquemovimento mov on (mov.codestoquemes = mes.codestoquemes)
	where p.estoque = false 
)

-- Apaga Conferencias de Estoque
delete from tblestoquesaldoconferencia
where tblestoquesaldoconferencia.codestoquesaldoconferencia in (
	select esc.codestoquesaldoconferencia 
	from tblestoquesaldoconferencia esc
	inner join tblestoquesaldo es on (es.codestoquesaldo = esc.codestoquesaldo)
	inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocalprodutovariacao = es.codestoquelocalprodutovariacao)
	inner join tblprodutovariacao pv on (pv.codprodutovariacao = elpv.codprodutovariacao )
	inner join tblproduto p on (p.codproduto = pv.codproduto)
	where p.estoque = false 
);
