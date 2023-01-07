/*
delete from tblmercoscliente ;
delete from tblmercospedido ;
delete from tblmercospedidoitem ;
delete from tblmercosproduto ;
delete from tblmercosprodutoimagem ;

ALTER SEQUENCE tblmercoscliente_codmercoscliente_seq RESTART;
ALTER SEQUENCE tblmercosimagem_codmercosimagem_seq RESTART;
ALTER SEQUENCE tblmercospedido_codmercospedido_seq RESTART;
ALTER SEQUENCE tblmercospedidoitem_codmercospedidoitem_seq RESTART;
ALTER SEQUENCE tblmercosproduto_codmercosproduto_seq RESTART;
ALTER SEQUENCE tblmercosprodutoimagem_codmercosprodutoimagem_seq RESTART;
*/


select inativo, * from tblmercosproduto order by inativo nulls last


-- Sincronizar Inativos
select mp.codproduto, mp.codprodutovariacao, mp.codprodutoembalagem
from tblmercosproduto mp
inner join tblproduto p on (p.codproduto = mp.codproduto)
where mp.inativo is null
and p.inativo is not null
order by p.alteracao

-- Sincronizar Precos
select mp.codproduto, mp.codprodutovariacao, mp.codprodutoembalagem
from tblmercosproduto mp
inner join tblproduto p on (p.codproduto = mp.codproduto)
left join tblprodutoembalagem pe on (pe.codprodutoembalagem = mp.codprodutoembalagem)
where mp.inativo is null
and p.inativo is not null
order by p.alteracao

-- Sincronizar Precos Embalagem
select mp.codproduto, mp.codprodutovariacao, mp.codprodutoembalagem
from tblmercosproduto mp
inner join tblproduto p on (p.codproduto = mp.codproduto)
inner join tblprodutoembalagem pe on (pe.codprodutoembalagem = mp.codprodutoembalagem)
where mp.inativo is null
and round(coalesce(pe.preco, p.preco * pe.quantidade), 2) != mp.preco 
order by p.alteracao 


-- Sincronizar Estoque
select mp.codproduto, mp.codprodutovariacao, mp.codprodutoembalagem, mp.saldoquantidade, floor(es.saldoquantidade / coalesce(pe.quantidade, 1))
from tblmercosproduto mp
inner join tblproduto p on (p.codproduto = mp.codproduto)
left join tblprodutoembalagem pe on (pe.codprodutoembalagem = mp.codprodutoembalagem)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocal = :codestoquelocal and elpv.codprodutovariacao = mp.codprodutovariacao)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = false)
where mp.inativo is null
and mp.saldoquantidade != floor(es.saldoquantidade / coalesce(pe.quantidade, 1))

-- Produtos Com Estoque e Com Imagem que ainda nao estao no Mercos
select 
	p.codproduto,
	p.produto,
	pv.variacao,
	sld.saldoquantidade,
	' curl "http://sistema.mgpapelaria.com.br/MGLara/mercos/produto/' || pv.codproduto || '/exporta?codprodutovariacao=' || pv.codprodutovariacao || '&codprodutoembalagem=0" -H "Cookie: PHPSESSID=uofutodghpmpht369d658b9sq3; XSRF-TOKEN=eyJpdiI6ImtrYU13eDhoMUNlQVdqaTUwYWNNdFE9PSIsInZhbHVlIjoiTkt2WFNYRlZQMkRJYUYxRFwvMGl5XC9DdEVrYzdoRjFkRWNINE5CaHBZYzlqYVRNR2RUUTZxZnJUcVVEbmpKWHZOQ0JGMHJmK1Nld0ZqYWVpMHZXdVZHZz09IiwibWFjIjoiYjdiYWYwYmU0MTNiMDQ2ODRlMDEyNjYxZWQzYWE3MzQ3ZTk0NmNlNDM5NWI1Y2Q5YTU5ODgwYmViMTg3ZTMxYiJ9; laravel_session=eyJpdiI6InVuSDBZMDFmclVOZnFDTEZ0VkpsOWc9PSIsInZhbHVlIjoiNzYyZktkUjI5Z245NzB2elZQNmlYMHJ5anZydVU2bllsaHVuKzE4M1hrYjVCNnVodzhKT0I5YVhBZHFGUkc5Qm5JeHRSdWI0c2tETExcL21BckxhdW53PT0iLCJtYWMiOiJiNTQ1MGMzNmE0NTQ4NTU4MzM1ZWM0NGNlNTk4ZDkwZGYxNTJhMWEzNGU0MTNjMTg4MDllMTM2NDg4MDBmZTdmIn0%3D"'	
	--	*
from tblproduto p
inner join tblprodutovariacao pv on (pv.codproduto = p.codproduto)
inner join tblprodutoimagem pi on (pi.codprodutoimagem = pv.codprodutoimagem)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocal = 101001 and elpv.codprodutovariacao = pv.codprodutovariacao)
inner join tblestoquesaldo sld on (sld.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and sld.fiscal = false)
where sld.saldoquantidade > 1
and p.inativo is null
--and p.codproduto = 28510
and pv.codprodutovariacao not in (
	select mp.codprodutovariacao  
	from tblmercosproduto mp
	where mp.inativo is null
)
and p.produto not ilike '*%'
order by p.produto, pv.variacao
--limit 10
--offset 40


select 
	count(*)	
	--	*
from tblproduto p
inner join tblprodutovariacao pv on (pv.codproduto = p.codproduto)
inner join tblprodutoimagem pi on (pi.codprodutoimagem = pv.codprodutoimagem)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocal = 101001 and elpv.codprodutovariacao = pv.codprodutovariacao)
inner join tblestoquesaldo sld on (sld.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and sld.fiscal = false)
where sld.saldoquantidade > 1
and p.inativo is null
--and p.codproduto = 28510
and pv.codprodutovariacao not in (
	select mp.codprodutovariacao  
	from tblmercosproduto mp
	where mp.inativo is null
)
and p.produto not ilike '*%'
--order by p.produto, pv.variacao asc


select distinct
	(string_to_array(replace(replace(replace(replace(p.produto, m.marca, ''), 'P/', ''), 'C/', ''), '  ', ' '), ' '))[1],
	(string_to_array(replace(replace(replace(replace(p.produto, m.marca, ''), 'P/', ''), 'C/', ''), '  ', ' '), ' '))[2]
	--	codproduto, p.produto, * 
from tblproduto p
inner join tblmarca m on (m.codmarca = p.codmarca)
inner join tblmercosproduto mp on (mp.codproduto = p.codproduto)
--order by p.produto
order by 1, 2


            select mp.produtoid, pim.codprodutoimagem, mp.codmercosproduto, mp.codproduto
            from tblmercosproduto mp
            inner join tblprodutovariacao pv on (pv.codprodutovariacao = mp.codprodutovariacao)
            inner join tblprodutoimagemprodutovariacao pipv on (pipv.codprodutovariacao = pv.codprodutovariacao)
            inner join tblprodutoimagem pim on (pim.codprodutoimagem = pipv.codprodutoimagem)
            left join tblmercosprodutoimagem mpi on (mpi.codmercosproduto = mp.codmercosproduto and mpi.codimagem = pim.codimagem)
            where mpi.codmercosprodutoimagem is null



select mp.produtoid, pim.codprodutoimagem, mp.codmercosproduto, mp.codproduto
from tblmercosproduto mp
inner join tblprodutovariacao pv on (pv.codprodutovariacao = mp.codprodutovariacao)
inner join tblprodutoimagemprodutovariacao pipv on (pipv.codprodutovariacao = pv.codprodutovariacao)
inner join tblprodutoimagem pim on (pim.codprodutoimagem = pipv.codprodutoimagem)
left join tblmercosprodutoimagem mpi on (mpi.codmercosproduto = mp.codmercosproduto and mpi.codimagem = pim.codimagem)
where mp.inativo is null 
and mpi.codmercosprodutoimagem is null



select mp.codproduto, mp.codprodutovariacao, mp.codprodutoembalagem, p.alteracao, mp.alteracao 
from tblmercosproduto mp
inner join tblproduto p on (p.codproduto = mp.codproduto)
where mp.inativo is null
and p.alteracao > mp.alteracao 
order by p.alteracao


select mp.codproduto, mp.codprodutovariacao, mp.codprodutoembalagem
from tblmercosproduto mp
inner join tblprodutoembalagem pe on (pe.codprodutoembalagem = mp.codprodutoembalagem)
where mp.inativo is null
and pe.alteracao > mp.alteracao 
order by pe.alteracao


select mp.codproduto, mp.codprodutovariacao, mp.codprodutoembalagem
from tblmercosproduto mp
inner join tblprodutovariacao pv on (pv.codprodutovariacao = mp.codprodutovariacao)
where mp.inativo is null
and pv.alteracao > mp.alteracao
order by pv.alteracao



-- 
delete from tblmercospedido t 

update tblnegocio set codnegociostatus = 3 where codnegociostatus= 1


select * from tblmercospedido order by numero 


select * from tblmovimentotitulo t where codtitulo = 464175

select * from tblprodutobarra where codproduto = 67312

select * from tblusuario where codusuario = 302103


select n.codnegocio, n.codnegociostatus 
from tblmercospedido mp
inner join tblnegocio n on (n.codnegocio  =mp.codnegocio)
where n.codnegociostatus !=3



delete from tblmercosproduto t where codproduto = 1146

select * from tblnegocio where codnegocio = 2938298


select * from tblpagarmepedido where valor  = 109.43



select distinct codproduto,
' curl "https://sistema.mgpapelaria.com.br/MGLara/mercos/produto/' || codproduto || '/atualiza" -H "Referer: https://sistema.mgpapelaria.com.br/MGLara/produto/' || codproduto || '" -H "Cookie: remember_82e5d2c56bdd0811318f0cf078b78bfc=eyJpdiI6IjZCK0o3eU1aQmRncWFrZnM1MUhCRmc9PSIsInZhbHVlIjoiQ3kxYXhveHBhak9uSWhDWXhHMU1MdThsbDQ0VG9wNXFuS2JmMHppVmQ0SGhPa2dXR0FyRGJpRkdEM3NsaXQ5cjFxUkM1TnA0QWZGZmkwaTNySDJ1bGtSbkRlRGJkS0ErNU82VExnTEE1MDA9IiwibWFjIjoiMjFjM2RlNGQ2NjBkMzY2ZmViNzBiYjVmYTJmZjA5YzhhY2FjNTg3MjMzNzY0MWE3YWQ5ZTkyNjI0ZGU0ZDAzZCJ9; PHPSESSID=thp5bih4cusbn5c8e95pc500n3; XSRF-TOKEN=eyJpdiI6IjdES3NkRVo5WlY4NHFPN04yMnNcL0tBPT0iLCJ2YWx1ZSI6IlptUzlVOHZid2ZtQkJJOWI5dWVxUktzUzdFSmxXeDZLZ0N2VW5iTW5JaE5NenhjQ0NuYU9ENE50aXFieFpJc0JveE5cL3YyNzk5MFwvT2tcL3lkNXJZXC9uZz09IiwibWFjIjoiM2FhMGI2NjBlNTY3OTYxOWI2MDVjODExZTVlM2E2ZGMzMjBjODhjMWU1ZDkwZDUyNzgwZjIyODk1YTIyNTQ1ZCJ9; laravel_session=eyJpdiI6IjlNVGxkM3B1dFZwNFNYYmM2T0oxS0E9PSIsInZhbHVlIjoiTm42MkorR0VibG1aSjVtWWk1MFpEV2lKbGJEOTlSRFNGdHFYRmpadEJ2SE1yRDA1dTB2QmVnd2JOZ1VRQitIYjVPeHRROEdpVWdESERPUEl6byt1N1E9PSIsIm1hYyI6IjVkZDRiM2NiZGJkZTUwODRhYmI5YjRmNjM1MjRhNDE5MzdlOGNhZGViNGYwNDYzOGQxMGRhNjhiMDM2YzFmZTUifQ%3D%3D; 433ad42554cc9716d8e6c800e8498334=eb6dec17a981400c5071cb519158b898e07759c7a%3A4%3A%7Bi%3A0%3Bi%3A1%3Bi%3A1%3Bs%3A5%3A%22fabio%22%3Bi%3A2%3Bi%3A10800%3Bi%3A3%3Ba%3A6%3A%7Bs%3A12%3A%22ultimoAcesso%22%3Bs%3A19%3A%2227%2F12%2F2022+13%3A51%3A52%22%3Bs%3A10%3A%22codusuario%22%3Bi%3A1%3Bs%3A19%3A%22impressoraMatricial%22%3BN%3Bs%3A17%3A%22impressoraTermica%22%3Bs%3A17%3A%22elgin-i9-cxacen06%22%3Bs%3A11%3A%22codportador%22%3Bi%3A100%3Bs%3A9%3A%22codfilial%22%3Bi%3A103%3B%7D%7D" -H "Sec-Fetch-Dest: empty" -H "Sec-Fetch-Mode: cors" -H "Sec-Fetch-Site: same-origin"'
from tblmercosproduto t 
where inativo is null
order by codproduto asc

select table_name, column_name  from information_schema."columns" c where column_name ilike '%maga%' limit 10



select 
	codproduto, 
	produto, 
	descricaosite, 
	regexp_replace(
		replace(
			replace(
				descricaosite, 
				'</p>',
				E'\n'
			), 
			'<br>',
			E'\n'
		), 
		E'<[^>]+>', 
		'', 
		'gi'
	) 
from tblproduto t 
where descricaosite ilike '%<%'

select count(*)
from tblproduto t 
where descricaosite ilike '%<%'


update tblproduto
set descricaosite = 
	regexp_replace(
		replace(
			replace(
				descricaosite, 
				'</p>',
				E'\n'
			), 
			'<br>',
			E'\n'
		), 
		E'<[^>]+>', 
		'', 
		'gi'
	) 
where descricaosite ilike '%<%'
