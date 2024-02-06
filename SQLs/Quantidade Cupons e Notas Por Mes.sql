            select mp.codproduto, mp.codprodutovariacao, mp.codprodutoembalagem, mp.saldoquantidade, floor(sum(es.saldoquantidade) / coalesce(pe.quantidade, 1))
            from tblmercosproduto mp
            inner join tblproduto p on (p.codproduto = mp.codproduto)
            left join tblprodutoembalagem pe on (pe.codprodutoembalagem = mp.codprodutoembalagem)
            inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocal in (102001, 101001) and elpv.codprodutovariacao = mp.codprodutovariacao)
            inner join tblestoquesaldo es on (es.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao and es.fiscal = false)
            where mp.inativo is null
            group by mp.codproduto, mp.codprodutovariacao, mp.codprodutoembalagem, pe.quantidade, mp.saldoquantidade 
            having mp.saldoquantidade != floor(sum(es.saldoquantidade) / coalesce(pe.quantidade, 1))
            order by codproduto, codprodutovariacao, codprodutoembalagem 
