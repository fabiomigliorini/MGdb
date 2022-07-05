select --distinct
	orig.codestoquemes
	, dest.codestoquemes
	, orig.saidaquantidade
	, dest.entradaquantidade
	, dest.codestoquemovimento
	, orig.codestoquemovimento
	, torig.sigla 
	, tdest.sigla 
	--'wget http://localhost/MGLara/estoque/calcula-custo-medio/' || cast(dest.codestoquemes as varchar) as comando
	--, orig.saidavalor
	--, dest.entradavalor
from tblestoquemovimento dest
inner join tblestoquemovimento orig on (orig.codestoquemovimento = dest.codestoquemovimentoorigem)
inner join tblestoquemovimentotipo torig on (torig.codestoquemovimentotipo = orig.codestoquemovimentotipo)
inner join tblestoquemovimentotipo tdest on (tdest.codestoquemovimentotipo = dest.codestoquemovimentotipo)
inner join tblestoquemes mes on (mes.codestoquemes = orig.codestoquemes)
inner join tblestoquesaldo sld on (sld.codestoquesaldo = mes.codestoquesaldo)
where orig.codestoquemes = dest.codestoquemes
and dest.manual = false
and dest.codestoquemovimentotipo not in (3002, 2002) -- Devolucao de venda, Devolucao de compra
and sld.fiscal = false
--and dest.codestoquemes = 864560
--and abs(coalesce(orig.saidavalor, 0) - coalesce(dest.entradavalor, 0)) > 0.01
order by 1 desc
--limit 500


--select codestoquemovimentotipo from tblestoquemovimento t where codestoquemovimento in (17826112, 17762715)

--select * from tblestoquemovimentotipo t2  where codestoquemovimentotipo in (3001, 3002)

select * from tblestoquemovimentotipo t order by sigla 

select * from tblmovimentotitulo t where codtitulo = :codtitulo  order by codmovimentotitulo 

