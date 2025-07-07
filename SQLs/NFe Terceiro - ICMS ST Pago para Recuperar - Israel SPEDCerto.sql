with cpl as (
	select 
		tnt.codnfeterceiro, 
		sum(t.credito) as st_complementar, 
		count(tnt.codtitulonfeterceiro) as guias
	from tbltitulonfeterceiro tnt 
	inner join tbltitulo t on (t.codtitulo = tnt.codtitulo)
	where t.estornado is null 
	and t.transacaoliquidacao is not null
	group by tnt.codnfeterceiro 
)
select 
	nt.codnfeterceiro, 
	nt.nfechave, 
	nt.codfilial - 100 as filial,
	nt.emissao::date emissao, 
	nt.entrada::date entrada, 
	nt.numero, 
	to_char(nt.cnpj, 'FM00000000000000') as cnpj,
	nt.icmsstvalor as st_destacada,
	cpl.st_complementar,
	coalesce(nt.icmsstvalor, 0) + coalesce(cpl.st_complementar, 0) as st_total
from tblnfeterceiro nt
inner join tblnaturezaoperacao nat on (nat.codnaturezaoperacao = nt.codnaturezaoperacao)
left join cpl on (cpl.codnfeterceiro = nt.codnfeterceiro)
where nt.codnotafiscal is not null
and nt.codfilial in (101, 102, 103, 104, 105)
and nat.compra = true
and nt.ignorada = false
and nt.indsituacao = 1
and nt.entrada >= '2017-04-01'
and nt.entrada <= '2024-11-30 23:59:59'
and (coalesce(nt.icmsstvalor, 0) + coalesce(cpl.st_complementar, 0)) > 0
--and nt.nfechave ilike '%3316825'
order by coalesce(nt.entrada, nt.emissao), nt.emissao, nt.nfechave, nt.codnfeterceiro




