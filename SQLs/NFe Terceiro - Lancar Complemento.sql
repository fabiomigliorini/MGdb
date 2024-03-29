--STYROFORM (1/2 mais Frete)
--update tblnfeterceiroitem set complemento = (vprod *1.8933) , margem = 37 where codnfeterceiro = 26000

--CIRANDA TEXTIL / BRITANNIA (Nota Cheia, mas quantidade dos produtos é / 100)
--update tblnfeterceiroitem set qcom = (qcom/10), qtrib = (qtrib/10), xprod = xprod || ' C/10 *' where cprod ilike '1314/%' and codnfeterceiro = 26044
--update tblnfeterceiroitem set qcom = (qcom/10), qtrib = (qtrib/10), xprod = xprod || ' C/10 *' where cprod ilike '4810/%' and codnfeterceiro = 26044
--update tblnfeterceiroitem set qcom = (qcom/10), qtrib = (qtrib/10), xprod = xprod || ' C/10 *' where cprod ilike '4833/%' and codnfeterceiro = 26044
--update tblnfeterceiroitem set qcom = (qcom/10), qtrib = (qtrib/10), xprod = xprod || ' C/10 *' where cprod ilike '7239/%' and codnfeterceiro = 26044
--update tblnfeterceiroitem set qcom = (qcom/10), qtrib = (qtrib/10), xprod = xprod || ' C/10 *' where cprod ilike '7240/%' and codnfeterceiro = 26044
--update tblnfeterceiroitem set qcom = (qcom/10), qtrib = (qtrib/10), xprod = xprod || ' C/10 *' where cprod ilike '4826/%' and codnfeterceiro = 26044
--update tblnfeterceiroitem set qcom = (qcom/100), qtrib = (qtrib/100), xprod = xprod || ' C/100 *' where cprod ilike '0916/%' and codnfeterceiro = 26044
--update tblnfeterceiroitem set vuntrib = vprod/qtrib, vuncom = vprod/qcom where codnfeterceiro = 26044

--ISSAM/ZEIN
-- update tblnfeterceiroitem set complemento = (vprod / 0.35) - vprod, margem = 40 where codnfeterceiro = 39775
update tblnfeterceiroitem set complemento = vprod, margem = 40 where codnfeterceiro = 39775

--FOUR STAR / CW
update tblnfeterceiroitem set complemento = (vprod * 4 * 0.85) - vprod, margem = 40 where codnfeterceiro in (45935, 45936)

update tblnfeterceiroitem set complemento = (vprod * 2) - vprod, margem = 40 where codnfeterceiro in (45936)

update tblnfeterceiroitem set complemento = (vprod * 4 * 0.8555) - vprod, margem = 40 where codnfeterceiro in (42126)

update tblnfeterceiroitem set complemento = (vprod * 4 * 0.85) - vprod, margem = 40 where codnfeterceiroitem in (550157)

update tblnfeterceiroitem  set complemento = null where codnfeterceiroitem = 550156



--Lua de Cristal
--update tblnfeterceiroitem set complemento = vprod, margem = 37 where codnfeterceiro in (26042)

--Elite / Imposul
--update tblnfeterceiroitem set complemento = vprod, margem = 40 where codnfeterceiro in (34769)

--Lumasol
--update tblnfeterceiroitem set complemento = vprod, margem = 37 where codnfeterceiro in (27605)


update tblnfeterceiroitem set complemento = (vprod * 0.934308075), margem = 37 where codnfeterceiro in (32388)

select sum(vprod) from tblnfeterceiroitem t where codnfeterceiro in (32388)

--Republic VIX
--update tblnfeterceiroitem set complemento = vprod, margem = 37 where codnfeterceiro in (25002)

--99 Express
--update tblnfeterceiroitem set complemento = vprod - ipivipi, margem = 75 where codnfeterceiro in (24568)

--MAGNO
--update tblnfeterceiroitem set complemento = vprod * 0.98630137, margem = 37 where codnfeterceiro in (25681)

--DU Careca
--update tblnfeterceiroitem set complemento = vprod - vdesc, margem = 37 where codnfeterceiro in (27610)

-- Rocie / Fartex / Wincy / Rio de Ouro
update tblnfeterceiroitem set complemento = (vprod * 2.5) - vprod, margem = 40 where codnfeterceiro in (45996)


-- Bazzi Company
-- update tblnfeterceiroitem set complemento = (vprod * 5.2435) - vprod, margem = 40 where codnfeterceiro in (29286)

-- Brindes Coelho (Ex Lumasol)
-- update tblnfeterceiroitem set complemento = (vprod * 1.014355021), margem = 40 where codnfeterceiro in (29823) 

-- Brindes Coelho (Ex Lumasol)
-- update tblnfeterceiroitem set complemento = (vprod * 1.014355021), margem = 40 where codnfeterceiro in (30001) 

update tblnfeterceiroitem set complemento = (vprod * 1.5), margem = 40 where codnfeterceiro in (33950)

update tblnfeterceiroitem set complemento = (vprod * 1.53344569070727), margem = 37 where codnfeterceiro in (38318)

update tblnfeterceiroitem set complemento = vprod, margem = 37 where codnfeterceiro in (35948)

update tblnfeterceiroitem set complemento = vprod * 2.02302837016504, margem = 40 where codnfeterceiro in (34983)

update tblnfeterceiroitem set complemento = null, margem = 37 where codnfeterceiro in (38150)

update tblnfeterceiroitem set complemento = (vprod * 2), margem = 40 where codnfeterceiro in (35902)

--GGB Plast
update tblnfeterceiroitem set complemento = (vprod * 0.428562639), margem = 37 where codnfeterceiro in (38610)


-- Multi Placas
update tblnfeterceiroitem set complemento = (vprod * 9), margem = 40 where codnfeterceiro in (361592107)


with it as (
	select nti.codnfeterceiro, sum(nti.complemento) as complemento
	from tblnfeterceiroitem nti
	group by nti.codnfeterceiro
)
select nt.valorprodutos, nt.valortotal, it.complemento, nt.valortotal + it.complemento as geral
from tblnfeterceiro nt
inner join it on (it.codnfeterceiro  = nt.codnfeterceiro)
where nt.codnfeterceiro in (30171)


--select * from tblnfeterceiroitem where codnfeterceiro = 24692 order by nitem

update tblnfeterceiroitem set complemento = vprod where codnfeterceiro = 36549

update tblnfeterceiroitem set complemento = vprod where codnfeterceiro = 39375

update tblnfeterceiroitem set margem = 40 where codnfeterceiro = 40409




select * from tblnfeterceiroitem nti where codnfeterceiro = 36343


select margem, * from tblnfeterceiroitem   where codnfeterceiroitem = 491207


select senhacertificado, filial, * from tblfilial order by codfilial 


select codtributacao, * from tblproduto where codproduto = 9785

select * from tbltributacao t 


select observacao, credito, emissao, * from tbltitulo where observacao ilike '%22812%' order by emissao desc nulls last

select nt.numero, nti.voutro, nti.complemento , nti.margem, nti.qcom, nti.vprod, nti.*
from tblnfeterceiroitem nti
inner join tblnfeterceiro nt on (nt.codnfeterceiro = nti.codnfeterceiro)
where nt.codpessoa = 7850
order by nti.criacao desc


select * from tblpessoa where codpessoa = 13243

update tblpessoa set ie = '134014669' where codpessoa = 13243




update tblnfeterceiroitem t  set margem = 40, complemento = vprod where codnfeterceiro = 41968



select * from tblnegocio where codnegocio = 2860952



select nextval('tblnfeterceiroitem_codnfeterceiroitem_seq')

update tblnfeterceiroitem set nitem = nitem * 100 where codnfeterceiro in (42124, 42126, 42127)

select * from tblnfeterceiroitem t where codnfeterceiro = 41744 order by nitem


