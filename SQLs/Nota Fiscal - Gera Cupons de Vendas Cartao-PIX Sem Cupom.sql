
-- Gera as notas
with pendentes as (
	SELECT 
	 	distinct n.codfilial, n.codnegocio, ' curl "https://sistema.mgpapelaria.com.br/MGsis/index.php?r=negocio/gerarNotaFiscal&id=' || n.codnegocio || '&modelo=65" -H "Accept: application/json, text/javascript, */*; q=0.01" -H "Referer: https://sistema.mgpapelaria.com.br/MGsis/index.php?r=negocio/view&id=2906473" -H "Cookie: remember_82e5d2c56bdd0811318f0cf078b78bfc=eyJpdiI6IjZCK0o3eU1aQmRncWFrZnM1MUhCRmc9PSIsInZhbHVlIjoiQ3kxYXhveHBhak9uSWhDWXhHMU1MdThsbDQ0VG9wNXFuS2JmMHppVmQ0SGhPa2dXR0FyRGJpRkdEM3NsaXQ5cjFxUkM1TnA0QWZGZmkwaTNySDJ1bGtSbkRlRGJkS0ErNU82VExnTEE1MDA9IiwibWFjIjoiMjFjM2RlNGQ2NjBkMzY2ZmViNzBiYjVmYTJmZjA5YzhhY2FjNTg3MjMzNzY0MWE3YWQ5ZTkyNjI0ZGU0ZDAzZCJ9; _gcl_au=1.1.1412810276.1674075554; _ga_9FVEXSFY35=GS1.1.1674242113.2.1.1674242253.0.0.0; _ga=GA1.1.836041152.1674075554; _fbp=fb.2.1674075556284.493645307; PHPSESSID=' || :phpsessid || '; "' as comando
	FROM tblnegocio N
	INNER JOIN tblnegocioformapagamento NFP ON (nfp.codnegocio = n.codnegocio)
	inner join tblformapagamento fp on (fp.codformapagamento = nfp.codformapagamento)
	inner join tblnegocioprodutobarra npb on (npb.codnegocio = n.codnegocio)
	left join tblnotafiscalprodutobarra nfpb on (nfpb.codnegocioprodutobarra = npb.codnegocioprodutobarra)
	where n.lancamento between date_trunc('day', now() - '30 days'::interval) and (now() - '2 hours'::interval) 
	and n.codnegociostatus = 2
	and fp.integracao = true
	and nfpb.codnotafiscalprodutobarra is null
	order by 1 asc 
)
select * from pendentes order by codnegocio asc limit 200
--select codfilial, count(*) from pendentes group by codfilial order by codfilial

--curl 'https://sistema.mgpapelaria.com.br/MGsis/index.php?r=negocio/gerarNotaFiscal&id=2981834&modelo=65' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/109.0' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Accept-Language: pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3' -H 'Accept-Encoding: gzip, deflate, br' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' -H 'Referer: https://sistema.mgpapelaria.com.br/MGsis/index.php?r=negocio/view&id=2981834' -H 'Cookie: remember_82e5d2c56bdd0811318f0cf078b78bfc=eyJpdiI6IjZCK0o3eU1aQmRncWFrZnM1MUhCRmc9PSIsInZhbHVlIjoiQ3kxYXhveHBhak9uSWhDWXhHMU1MdThsbDQ0VG9wNXFuS2JmMHppVmQ0SGhPa2dXR0FyRGJpRkdEM3NsaXQ5cjFxUkM1TnA0QWZGZmkwaTNySDJ1bGtSbkRlRGJkS0ErNU82VExnTEE1MDA9IiwibWFjIjoiMjFjM2RlNGQ2NjBkMzY2ZmViNzBiYjVmYTJmZjA5YzhhY2FjNTg3MjMzNzY0MWE3YWQ5ZTkyNjI0ZGU0ZDAzZCJ9; _gcl_au=1.1.1412810276.1674075554; _ga_9FVEXSFY35=GS1.1.1674242113.2.1.1674242253.0.0.0; _ga=GA1.1.836041152.1674075554; _fbp=fb.2.1674075556284.493645307; PHPSESSID=hul2u0rc7oci0mrd3j8e5nvon3; codpagarmepos=1; XSRF-TOKEN=eyJpdiI6Im9xdEgwb0RTYW5GNXNtSXBRcHlcL0h3PT0iLCJ2YWx1ZSI6Ijd2UUlCKzBJczVFMTRmMEZTb2pqeDJZVEticFZXZlc4RlQ3dncwWTNCcXNpVlNWZFBMTWRmTE9vVWN2R1ZzNTFIaWM5SzBxMU1TN25QalwvWTBHRlFQZz09IiwibWFjIjoiMmRiMzU3NjYxYjMxN2I5ZDA4ODJlZmMyMjI4MzExZDc2ZGUxNGYzYzc2MGFhYzZiOGI3NjNkYjg3MjEyMzZmNCJ9; laravel_session=eyJpdiI6IjVBNGx0S2ExTjh2NXl5NGlpVzFha2c9PSIsInZhbHVlIjoiamJCTzIxblNYZDdvYWY1MUI2KzVPbE43OVBqUmdGTXNJOWdWanVZSXl6V1pcLzZJTFVucjdnc1BWNnY1UVZWcVMyajdJNlVXaWNtYndCcDBNMzllSnRBPT0iLCJtYWMiOiJmYmQyYzczOGUxOTU1MzkwZWQ3YjVhZTcyMjdmNmI1ZWY2YmEyYWJmNmEyZjQ0NWVkODk5ZTU4MjlhMTFiMTRhIn0%3D; 433ad42554cc9716d8e6c800e8498334=f21db968084c61c03e3b70e137ccb873e1c53b27a%3A4%3A%7Bi%3A0%3Bi%3A1%3Bi%3A1%3Bs%3A5%3A%22fabio%22%3Bi%3A2%3Bi%3A10800%3Bi%3A3%3Ba%3A6%3A%7Bs%3A12%3A%22ultimoAcesso%22%3Bs%3A19%3A%2231%2F01%2F2023+10%3A00%3A57%22%3Bs%3A10%3A%22codusuario%22%3Bi%3A1%3Bs%3A19%3A%22impressoraMatricial%22%3BN%3Bs%3A17%3A%22impressoraTermica%22%3Bs%3A17%3A%22elgin-i9-cxacen06%22%3Bs%3A11%3A%22codportador%22%3Bi%3A100%3Bs%3A9%3A%22codfilial%22%3Bi%3A103%3B%7D%7D' -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Site: same-origin'

-- transmite as notas
select 
	--nf.codfilial, count(*), sum(nf.valortotal)
	' curl "https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-php/' || nf.codnotafiscal || '/criar" && curl "https://api-mgspa.mgpapelaria.com.br/api/v1/nfe-php/' || nf.codnotafiscal || '/enviar-sincrono"'
from tblnotafiscal nf
where nf.codnaturezaoperacao = 1 -- venda
and nf.emitida = true 
and nf.modelo = 65
and nf.numero = 0
and nf.codpessoa = 1
and nf.valortotal < 1000
--group by nf.codfilial 
order by 1 asc
--offset 200
--offset 2000

