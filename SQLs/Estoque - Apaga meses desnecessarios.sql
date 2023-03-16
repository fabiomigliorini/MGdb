
delete from tblestoquemes
where codestoquemes not in (select distinct mov.codestoquemes from tblestoquemovimento mov where mov.codestoquemes = tblestoquemes.codestoquemes)
--and codestoquemes not in (select min(m2.codestoquemes) from tblestoquemes m2 group by m2.codestoquesaldo having count(m2.*) = 1)

delete from tblestoquesaldo 
where codestoquesaldo not in (select distinct mes.codestoquesaldo from tblestoquemes mes)
and codestoquesaldo not in (select distinct conf.codestoquesaldo from tblestoquesaldoconferencia conf)

delete from tblestoquelocalprodutovariacao 
where codestoquelocalprodutovariacao not in (select distinct sld.codestoquelocalprodutovariacao from tblestoquesaldo sld)

