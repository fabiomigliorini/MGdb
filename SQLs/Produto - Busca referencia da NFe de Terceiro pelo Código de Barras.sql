﻿
select pb.barras, pv.variacao, pe.quantidade, pv.referencia, count(npb.codnegocioprodutobarra), min(npb.criacao), max(npb.criacao), min(npb.codnegocio)
from tblnegocioprodutobarra npb
inner join  tblprodutobarra pb on (pb.codprodutobarra = npb.codprodutobarra)
inner join tblprodutovariacao pv on (pv.codprodutovariacao = pb.codprodutovariacao)
left join tblprodutoembalagem pe on (pe.cod	produtoembalagem = pb.codprodutoembalagem)
where pb.codproduto = :codproduto
and npb.criacao >= '2022-01-01'
group by pb.barras, pv.variacao, pv.referencia, pe.quantidade
order by 2 asc, 1 asc

select * from tblnfeterceiroitem where cean ilike '%7898048135197%'

select distinct cprod, xprod  from tblnfeterceiroitem t where cprod ilike '4-214.1.%' order by cprod

select criacao, * from tblnfeterceiroitem where '7898426273435' in (cean, ceantrib) order by criacao desc nulls last

SKO341 ENV SACO SC KO 41 310X410 80G C/100

select criacao, * from tblnfeterceiroitem where xprod ilike  '%lapis%184%' order by criacao desc nulls last

select criacao, * from tblnfeterceiroitem where cprod ilike '1205%' and xprod ilike '%184%' order by criacao desc nulls last


update tblnfeterceiroitem  set margem = 33.5 where codprodutobarra  = 10011432

select * from tblproduto where codusuariocriacao  = 1 and criacao >= '2020-12-02' and produto  ilike '@ %'

/*
select * from tblnfeterceiroitem where cprod ilike '%PG525%'
*/s

--select * from tblnegocioprodutobarra where codprodutobarra = 30014848


update tblnegocioprodutobarra 
set codprodutobarra = 986198
where tblnegocioprodutobarra.codnegocio in (
	select n.codnegocio
	from tblnegocio n 
	where n.codnaturezaoperacao  = 00000004
	and n.codpessoa = 30011016
	and n.lancamento >= '2019-08-01'
)
and tblnegocioprodutobarra.codprodutobarra = 957020




update tblnotafiscalprodutobarra 
set codprodutobarra = 986198
where tblnotafiscalprodutobarra.codnotafiscal in (
	select n.codnotafiscal
	from tblnotafiscal n 
	where n.codnaturezaoperacao  = 00000004
	and n.codpessoa = 30011016
	and n.saida >= '2019-08-01'
)
and tblnotafiscalprodutobarra.codprodutobarra = 957020



select * from tblnegocioformapagamento t where codnegocio = 2361636


delete from tblnegocioformapagamento  where codnegocioformapagamento  = 2385664

select * from tblmovimentotitulo t where codtitulo = 384193


delete from tblmovimentotitulo where codmovimentotitulo  = 857929


update tblprodutobarra 
set codproduto = :codproduto, 
codprodutoembalagem  = null, 
codprodutovariacao = (select pv.codprodutovariacao from tblprodutovariacao pv where pv.codproduto = :codproduto) 
where barras  = :barras


update tblnegocio set codnegociostatus = 3 where codnegocio = 2939526