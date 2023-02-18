
select n.codfilial as codfilial_negocio, ucr.codfilial as codfilial_xerox, ucx.codfilial as codfilial_caixa, n.codnegocio, n.lancamento 
from tblnegocio n
inner join tblusuario ucx on (ucx.codusuario = n.codusuario)
inner join tblusuario ucr on (ucr.codusuario = n.codusuariocriacao)
where n.codusuariocriacao in (301962, 302027, 302020, 302022, 302021)
and ucx.codfilial != n.codfilial
and n.codusuario != n.codusuariocriacao 
and n.lancamento >= '2021-01-01';

select 
	n.codfilial, 
	n.codnegocio, 
	n.lancamento,
	'update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = ' || n.codnegocio  || ';',
	' curl https://sistema.mgpapelaria.com.br/MGLara/estoque/gera-movimento-negocio/' || n.codnegocio 
from tblnegocio n
where n.codusuariocriacao in (302001)
and n.lancamento >= '2023-02-04'
--and n.codfilial != 103
;

update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = 2989861;
update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = 2989891;
update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = 2989908;
update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = 2989930;
update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = 2989950;
update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = 2989960;