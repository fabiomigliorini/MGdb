﻿select * 
from mvwestoque2019  e
where e.quant < 0 
and e.codproduto in (
	select e2.codproduto 
	from mvwestoque2019 e2
	where e2.quant > 0
	and e2.codfilial in (101, 102, 103, 104)
)
and e.codfilial  in (101, 102, 103, 104)


--select * from mvwestoque2019 where codproduto = 107232

/*
drop MATERIALIZED VIEW mvwestoque2019 ;

REFRESH MATERIALIZED VIEW mvwestoque2019 ;

create materialized view mvwestoque2019  as 
    select
	p.codproduto
	, p.produto
	, p.inativo
	, p.preco
	, fiscal.codfilial
	, fiscal.saldoquantidade as quant
	, fiscal.customedio as custo
	, fiscal.saldovalor as valor
	, p.preco / case when fiscal.customedio != 0 then fiscal.customedio else null end as markup
	--, fisico.saldovalor as fisico_saldovalor
	--, fisico.customedio as fisico_customedio
	--, m.codmarca
	--, m.marca
	--, sp.codsecaoproduto
	--, sp.secaoproduto
	--, fp.codfamiliaproduto
	--, fp.familiaproduto
	--, gp.codgrupoproduto
	--, gp.grupoproduto
	--, sgp.codsubgrupoproduto
	--, sgp.subgrupoproduto
    from tblproduto p
    left join tblmarca m on (m.codmarca = p.codmarca)
    left join tblsubgrupoproduto sgp on (sgp.codsubgrupoproduto = p.codsubgrupoproduto)
    left join tblgrupoproduto gp on (gp.codgrupoproduto = sgp.codgrupoproduto)
    left join tblfamiliaproduto fp on (fp.codfamiliaproduto = gp.codfamiliaproduto)
    left join tblsecaoproduto sp on (sp.codsecaoproduto = fp.codsecaoproduto)
    left join (
	select 
		el.codfilial
		, pv.codproduto
		, sum(em.saldoquantidade) as saldoquantidade
		, sum(em.saldovalor) as saldovalor
		, sum(em.saldovalor) / case when sum(em.saldoquantidade) !=0 then sum(em.saldoquantidade) else null end as customedio
	from tblestoquelocalprodutovariacao elpv
	inner join tblprodutovariacao pv on (pv.codprodutovariacao = elpv.codprodutovariacao)
	inner join tblestoquelocal el on (el.codestoquelocal = elpv.codestoquelocal)
	inner join tblfilial f on (f.codfilial = el.codfilial)
	inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = true)
	inner join tblestoquemes em on (em.codestoquemes = (select em2.codestoquemes from tblestoquemes em2 where em2.codestoquesaldo = es.codestoquesaldo and em2.mes <= '2019-12-31' order by mes desc limit 1))
	where f.codfilial  in (101, 102, 103, 104)
	--where f.codfilial = 104
      group by el.codfilial, pv.codproduto
	) fiscal on (fiscal.codproduto = p.codproduto)
    left join tblncm n on (n.codncm = p.codncm)
    where p.codtipoproduto = 0
    --and n.ncm ilike '4901%'
    --and p.produto ilike '%tabua%cozin%'
    --AND p.preco >= 70
    --AND p.preco <= 130
    --and p.inativo is not null
    --AND m.codmarca = {$filtro['codmarca']}
    --AND m.controlada = true
    --AND p.codncm = {$filtro['codncm']}
    --AND p.preco <= {$filtro['preco_ate']}
    --AND p.produto ilike '%{$palavra}%'
    --AND p.codsubgrupoproduto = {$filtro['codsubgrupoproduto']}
    --AND sgp.codgrupoproduto = {$filtro['codgrupoproduto']}
    --AND gp.codfamiliaproduto = {$filtro['codfamiliaproduto']}
    --AND fp.codsecaoproduto = {$filtro['codsecaoproduto']}
    --AND fisico.saldoquantidade < 0
    --AND fisico.saldoquantidade > 0
    --AND fiscal.saldoquantidade < 0
    AND fiscal.saldoquantidade != 0
    --and p.codproduto = 3788
    order by p.produto, p.codproduto, fiscal.codfilial, p.codproduto
    --limit 200

*/