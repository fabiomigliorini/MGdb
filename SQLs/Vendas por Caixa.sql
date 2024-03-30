select
	date_trunc('month', n.lancamento) as mes,
	f.filial,
	u.usuario,
	sum(npb.valortotal) as valortotal,
	count(npb.codnegocioprodutobarra) as quantidade --*
from tblnegocio n
inner join tblnaturezaoperacao nat on (nat.codnaturezaoperacao = n.codnaturezaoperacao)
inner join tblusuario u on (u.codusuario = n.codusuario)
inner join tblnegocioprodutobarra npb on (npb.codnegocio = n.codnegocio)
inner join tblfilial f ON (f.codfilial = n.codfilial)
where n.codnegociostatus = 2
and n.lancamento between :inicio and :fim
and nat.venda = 1
--and n.codfilial = 105
group by
	date_trunc('month', n.lancamento),
	f.filial,
	u.usuario
order by 5 desc
--limit 50
