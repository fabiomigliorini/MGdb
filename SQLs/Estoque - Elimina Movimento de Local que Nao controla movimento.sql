--FISICO
select ' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-negocio-produto-barra/' || mov.codnegocioprodutobarra, mov.codestoquemes, mov.data
from tblestoquelocal el
inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocal = el.codestoquelocal)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = false)
inner join tblestoquemes mes on (mes.codestoquesaldo = es.codestoquesaldo)
inner join tblestoquemovimento mov on (mov.codestoquemes = mes.codestoquemes)
where el.controlaestoque = false
order by mov."data" desc
--limit 100 offset 200

select count(*)
from tblestoquelocal el
inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocal = el.codestoquelocal)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = false)
inner join tblestoquemes mes on (mes.codestoquesaldo = es.codestoquesaldo)
inner join tblestoquemovimento mov on (mov.codestoquemes = mes.codestoquemes)
where el.controlaestoque = false
--order by mov."data" desc
--limit 100

select esc.*
from tblestoquelocal el
inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocal = el.codestoquelocal)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = false)
inner join tblestoquesaldoconferencia esc on (esc.codestoquesaldo = es.codestoquesaldo)
where el.controlaestoque = false

--FISCAL
select ' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-nota-fiscal-produto-barra/' || mov.codnotafiscalprodutobarra, mov.codestoquemes, mov.data
from tblestoquelocal el
inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocal = el.codestoquelocal)
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = true)
inner join tblestoquemes mes on (mes.codestoquesaldo = es.codestoquesaldo)
inner join tblestoquemovimento mov on (mov.codestoquemes = mes.codestoquemes)
where el.controlaestoque = false
order by mov."data" desc
--limit 100 offset 200