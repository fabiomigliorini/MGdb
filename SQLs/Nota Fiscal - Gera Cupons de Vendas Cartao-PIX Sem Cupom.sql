
-- Gera as notas
with pendentes as (
	SELECT 
	 	distinct n.codfilial, n.codnegocio, ' curl "https://sistema.mgpapelaria.com.br/MGsis/index.php?r=negocio/gerarNotaFiscal&id=' || n.codnegocio || '&modelo=65" -H "Accept: application/json, text/javascript, */*; q=0.01" -H "Referer: https://sistema.mgpapelaria.com.br/MGsis/index.php?r=negocio/view&id=2906473" -H "Cookie: remember_82e5d2c56bdd0811318f0cf078b78bfc=eyJpdiI6IjZCK0o3eU1aQmRncWFrZnM1MUhCRmc9PSIsInZhbHVlIjoiQ3kxYXhveHBhak9uSWhDWXhHMU1MdThsbDQ0VG9wNXFuS2JmMHppVmQ0SGhPa2dXR0FyRGJpRkdEM3NsaXQ5cjFxUkM1TnA0QWZGZmkwaTNySDJ1bGtSbkRlRGJkS0ErNU82VExnTEE1MDA9IiwibWFjIjoiMjFjM2RlNGQ2NjBkMzY2ZmViNzBiYjVmYTJmZjA5YzhhY2FjNTg3MjMzNzY0MWE3YWQ5ZTkyNjI0ZGU0ZDAzZCJ9; _gcl_au=1.1.1412810276.1674075554; _ga_9FVEXSFY35=GS1.1.1674242113.2.1.1674242253.0.0.0; _ga=GA1.1.836041152.1674075554; _fbp=fb.2.1674075556284.493645307; PHPSESSID=jk3voas1ok7pntq672dtr273d5; "' as comando
	FROM tblnegocio N
	INNER JOIN tblnegocioformapagamento NFP ON (nfp.codnegocio = n.codnegocio)
	inner join tblformapagamento fp on (fp.codformapagamento = nfp.codformapagamento)
	inner join tblnegocioprodutobarra npb on (npb.codnegocio = n.codnegocio)
	left join tblnotafiscalprodutobarra nfpb on (nfpb.codnegocioprodutobarra = npb.codnegocioprodutobarra)
	where n.lancamento between date_trunc('day', now() - '30 days'::interval) and (now() - '4 hours'::interval) 
	and n.codnegociostatus = 2
	and fp.integracao = true
	and nfpb.codnotafiscalprodutobarra is null
	order by 1 asc 
)
select * from pendentes order by codnegocio asc --offset 850
--select codfilial, count(*) from pendentes group by codfilial order by codfilial

-- transmite as notas
select 
	--nf.codfilial, count(*), sum(nf.valortotal)
	'curl "https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-php/' || nf.codnotafiscal || '/criar" && curl "https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-php/' || nf.codnotafiscal || '/enviar-sincrono"'
from tblnotafiscal nf
where nf.codnaturezaoperacao = 1 -- venda
and nf.emitida = true 
and nf.modelo = 65
and nf.numero = 0
and nf.codpessoa = 1
and nf.valortotal < 1000
--group by nf.codfilial 
order by 1 ASC
--offset 1500
--offset 2000
