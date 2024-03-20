select 
	n.codfilial, 
	date_trunc ('month', n.lancamento) as mes, 
	extract (day from n.lancamento) as dia, 
	extract (dow from n.lancamento) as semana, 
	extract (hour from n.lancamento) as hora, 
	sum(n.valortotal) as valor,
	count(n.codnegocio) as quant
from tblnegocio n 
inner join tblnaturezaoperacao nat on (nat.codnaturezaoperacao = n.codnaturezaoperacao)
where codnegociostatus = 2 
and n.lancamento >= date_trunc('year', current_date - interval '1 year')
and nat.venda 
--and extract (hour from n.lancamento) <= 6
group by 
	n.codfilial, 
	date_trunc ('month', n.lancamento) , 
	extract (day from n.lancamento), 
	extract (dow from n.lancamento), 
	extract (hour from n.lancamento)
--limit 100