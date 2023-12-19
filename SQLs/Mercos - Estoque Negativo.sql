            select mp.codproduto, mp.codprodutovariacao, mp.codprodutoembalagem, mp.saldoquantidade, floor(sum(es.saldoquantidade) / coalesce(pe.quantidade, 1))
            from tblmercosproduto mp
            inner join tblproduto p on (p.codproduto = mp.codproduto)
            left join tblprodutoembalagem pe on (pe.codprodutoembalagem = mp.codprodutoembalagem)
            inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocal in :codestoquelocal and elpv.codprodutovariacao = mp.codprodutovariacao)
            inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = false)
            where mp.inativo is null
            group by mp.codproduto, mp.codprodutovariacao, mp.codprodutoembalagem, pe.quantidade, mp.saldoquantidade 
            having floor(sum(es.saldoquantidade) / coalesce(pe.quantidade, 1)) < 0
			order by codproduto, codprodutovariacao, codprodutoembalagem 
			
select p.codproduto, p.produto, pv.variacao, el.estoquelocal, es.saldoquantidade 
from tblestoquelocalprodutovariacao elpv
inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = false)
inner join tblestoquelocal el on (el.codestoquelocal = elpv.codestoquelocal)
inner join tblprodutovariacao pv on (pv.codprodutovariacao = elpv.codprodutovariacao)
inner join tblproduto p on (p.codproduto = pv.codproduto)
where elpv.codestoquelocal in (101001, 102001)
and elpv.codprodutovariacao in (select mp.codprodutovariacao from tblmercosproduto mp where mp.inativo is null)
and es.saldoquantidade < 0
order by p.produto, pv.variacao, el.estoquelocal

select * from tblnegocio where codnegocio = 03380612

update tblnegocio set codnegociostatus = 1 where codnegocio = 3380612

update tblnegocioprodutobarra set codnegocio = 3384841 where codnegocio = 3380612

03380612


