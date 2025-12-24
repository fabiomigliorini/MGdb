select 
	nt.codfilial,
	nt.emissao,
	nt.nfechave, 
	nti.nitem, 
	nti.cprod, 
	TO_CHAR(pb.codproduto, 'FM000000') || 
		CASE 
		    WHEN pe.quantidade > 0 THEN '-' || TRUNC(pe.quantidade, 0)::varchar
		    ELSE '' 
		END AS codigo,
	nti.cean,
	nti.ceantrib,
	nti.xprod, 
	nti.ncm,
	nti.cest,
	nti.cfop,
	nti.cst,
	nti.csosn,
	nti.qtrib,
	nti.utrib,
	nti.vuntrib,
	nti.qcom,
	nti.ucom,
	nti.vuncom,
	nti.vprod,
	nti.vdesc,
	nti.vfrete,
	nti.vseg,
	nti.voutro,
	nti.ipivipi,
	nti.vicms,
	nti.vicmsst,
	nti.cofinsvcofins,
	nti.pisvpis
from tblnfeterceiro nt
inner join tblnfeterceiroitem nti on (nti.codnfeterceiro = nt.codnfeterceiro)
inner join tblprodutobarra pb on (pb.codprodutobarra  = nti.codprodutobarra)
left join tblprodutoembalagem pe on (pe.codprodutoembalagem = pb.codprodutoembalagem)
--where nt.codfilial in (101, 102, 103, 104, 105)
where nt.codfilial = 105
and nt.entrada >= '2020-01-01'
--and nt.nfechave not ilike '%04576775%'
order by 1, 2, 3, 4
