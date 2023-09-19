
select n.codfilial as codfilial_negocio, ucr.codfilial as codfilial_xerox, ucx.codfilial as codfilial_caixa, n.codnegocio, n.lancamento 
from tblnegocio n
inner join tblusuario ucx on (ucx.codusuario = n.codusuario)
inner join tblusuario ucr on (ucr.codusuario = n.codusuariocriacao)
where n.codusuariocriacao in (301990)
and ucx.codfilial != n.codfilial
and n.codusuario != n.codusuariocriacao 
and n.lancamento >= '2023-01-01';

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



select n.codfilial, n.codnegocio, n.lancamento, n.valortotal, p.fantasia, 'update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = ' || n.codnegocio 
from tblnegocio n
inner join tblpessoa p on (p.codpessoa = n.codpessoa)
where n.codusuariocriacao in (301990)
and n.lancamento >= '2023-07-15'
and n.codfilial != 103
and n.codnegociostatus = 2
order by lancamento desc



update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = 3213516;
update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = 3213424;
update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = 3213278;
update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = 3210921;
update tblnegocio set codfilial = 103, codestoquelocal = 103001 where codnegocio = 3212385;

