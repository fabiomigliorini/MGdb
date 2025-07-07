with vendas as
(
	select n.codpessoa, sum(n.valortotal) valor, max(n.lancamento)::date data
	from tblnegocio n
	inner join tblnaturezaoperacao nat on (nat.codnaturezaoperacao = n.codnaturezaoperacao)
	where n.codnegociostatus = 2 
	and nat.venda = true
	group by n.codpessoa 
), titulos as 
(
	select t.codpessoa, sum(t.saldo) as saldo, min(t.vencimento) as vencimento
	from tbltitulo t
	where t.saldo != 0 
	group by t.codpessoa
)
select 
	p.codpessoa, 
	p.fantasia, 
	v.valor as totalcompras,
	v.data,
	ta.saldo,
	ta.vencimento,
	p.mensagemvenda, 
	p.observacoes 
from tblpessoa p
left join vendas v on (v.codpessoa = p.codpessoa)
left join titulos ta on (ta.codpessoa = p.codpessoa)
where (p.observacoes ilike '%vista%' or p.mensagemvenda ilike '%vista%')
and p.creditobloqueado = false 
and p.inativo is null
order by p.fantasia 






