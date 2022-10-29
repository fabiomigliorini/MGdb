select 
     --  tblgrupoproduto.codgrupoproduto
     --, tblgrupoproduto.grupoproduto
     --, tblsubgrupoproduto.codsubgrupoproduto
     --, tblsubgrupoproduto.subgrupoproduto
       tblmarca.codmarca
     , tblmarca.marca
     , tblnaturezaoperacao.codnaturezaoperacao
     , tblnaturezaoperacao.naturezaoperacao
     , tblfilial.codfilial
     , tblfilial.filial
     , tblproduto.codproduto
     , tblproduto.produto
     , tblnegocio.codnegocio
     , tblnegocio.lancamento
     , tblnegocioprodutobarra.quantidade * coalesce(tblprodutoembalagem.quantidade, 1) as quantidade
     , tblnegocioprodutobarra.valortotal as valorbruto
     , tblnegocioprodutobarra.valortotal * (1-(coalesce(tblnegocio.valordesconto, 0) / tblnegocio.valortotal)) as valorliquido
  from tblnegocio 
  left join tblnegocioprodutobarra on (tblnegocioprodutobarra.codnegocio       = tblnegocio.codnegocio)
  left join tblfilial              on (tblfilial.codfilial                     = tblnegocio.codfilial)
  left join tblprodutobarra        on (tblprodutobarra.codprodutobarra         = tblnegocioprodutobarra.codprodutobarra)
  left join tblproduto             on (tblproduto.codproduto                   = tblprodutobarra.codproduto)
  left join tblsubgrupoproduto     on (tblsubgrupoproduto.codsubgrupoproduto   = tblproduto.codsubgrupoproduto)
  --left join tblgrupoproduto        on (tblgrupoproduto.codgrupoproduto         = tblsubgrupoproduto.codgrupoproduto)
  left join tblmarca               on (tblmarca.codmarca                       = coalesce(tblprodutobarra.codmarca, tblproduto.codmarca))
  left join tblprodutoembalagem    on (tblprodutoembalagem.codprodutoembalagem = tblprodutobarra.codprodutoembalagem)
  left join tblnaturezaoperacao    on (tblnaturezaoperacao.codnaturezaoperacao = tblnegocio.codnaturezaoperacao)
 where tblnegocio.codnegociostatus  = 2 -- fechado
   and tblnegocio.lancamento       >= '2020-11-01 00:00:00.0'
--   and tblnegocio.lancamento       <= '2015-12-31 23:59:59.9'
   --and tblnegocio.codpessoa         not in (select tblfilial.codpessoa from tblfilial)
   --AND tblproduto.codproduto IN (30532, 30825, 46572, 47187, 49582, 47570, 53670, 54396)
   and tblsubgrupoproduto.codgrupoproduto = 1070
   and (tblnaturezaoperacao.venda or tblnaturezaoperacao.vendadevolucao or tblnaturezaoperacao.compra)
   --and tblproduto.codsubgrupoproduto = 00014010
   
   
select * from tblnaturezaoperacao t where venda = true