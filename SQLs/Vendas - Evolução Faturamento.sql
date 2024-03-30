select 
	  to_char(date_trunc('month', lancamento), 'YYYY-MM-DD') as mes 
	, filial
	, sum(n.valortotal * case when no.codoperacao = 1 then -1 else 1 end ) as venda
	, sum(case when no.codoperacao = 1 then -1 else 1 end) as quant
from tblnegocio n
inner join tblfilial f on (f.codfilial = n.codfilial)
left join tblpessoa pv on (pv.codpessoa = n.codpessoavendedor)
left join tblpessoa p on (p.codpessoa = n.codpessoa)
left join tblgrupocliente gc on (gc.codgrupocliente = p.codgrupocliente)
inner join tblnaturezaoperacao no on (no.codnaturezaoperacao = n.codnaturezaoperacao)
where lancamento >= '2012-01-01 00:00:00.0'
and lancamento <= '2024-01-31 23:59:59.9'
and codnegociostatus = 2
and n.codnaturezaoperacao in (1, 2, 5) -- venda, devolucao, cupom
--and n.codnaturezaoperacao in (2) -- venda, devolucao, cupom
and n.codpessoa not in (select tblfilial.codpessoa from tblfilial)
group by 
	  date_trunc('month', lancamento)
	, filial
order by 1, 2, 3


