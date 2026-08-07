select tblgrupoproduto.codgrupoproduto
     , tblgrupoproduto.grupoproduto
     , tblsubgrupoproduto.codsubgrupoproduto
     , tblsubgrupoproduto.subgrupoproduto
     , tblmarca.codmarca
     , tblmarca.marca
     , tblfilial.codfilial
     , tblfilial.filial
     , tblproduto.codproduto
     , tblproduto.produto
     , tblnegocio.codnegocio
     , tblnegocio.lancamento
     , tblnegocioprodutobarra.quantidade * coalesce(tblprodutoembalagem.quantidade, 1) as quantidade
     , tblnegocioprodutobarra.valortotal
  from tblnegocio 
  left join tblnegocioprodutobarra on (tblnegocioprodutobarra.codnegocio       = tblnegocio.codnegocio)
  left join tblfilial              on (tblfilial.codfilial                     = tblnegocio.codfilial)
  left join tblprodutobarra        on (tblprodutobarra.codprodutobarra         = tblnegocioprodutobarra.codprodutobarra)
  left join tblproduto             on (tblproduto.codproduto                   = tblprodutobarra.codproduto)
  left join tblsubgrupoproduto     on (tblsubgrupoproduto.codsubgrupoproduto   = tblproduto.codsubgrupoproduto)
  left join tblgrupoproduto        on (tblgrupoproduto.codgrupoproduto         = tblsubgrupoproduto.codgrupoproduto)
  left join tblmarca               on (tblmarca.codmarca                       = coalesce(tblprodutobarra.codmarca, tblproduto.codmarca))
  left join tblprodutoembalagem    on (tblprodutoembalagem.codprodutoembalagem = tblprodutobarra.codprodutoembalagem)
 where tblnegocio.codoperacao       = 2 -- saida
   and tblnegocio.codnegociostatus  = 2 -- fechado
   and tblnegocio.lancamento       >= '2013-06-01 00:00:00.0'
   and tblnegocio.lancamento       <= '2013-07-31 23:59:59.9'
   and tblnegocio.codpessoa         not in (select tblfilial.codpessoa from tblfilial)
   AND tblnegocioprodutobarra.inativo IS NULL
   
   
   
   select 
       tblproduto.codproduto
     , tblproduto.produto
     --, tblnegocio.codnegocio
     --, tblnegocio.lancamento
     , sum(tblnegocioprodutobarra.quantidade * coalesce(tblprodutoembalagem.quantidade, 1)) as quantidade
     , sum(tblnegocioprodutobarra.valortotal) as valor
  from tblnegocio 
  left join tblnegocioprodutobarra on (tblnegocioprodutobarra.codnegocio       = tblnegocio.codnegocio)
  left join tblprodutobarra        on (tblprodutobarra.codprodutobarra         = tblnegocioprodutobarra.codprodutobarra)
  left join tblproduto             on (tblproduto.codproduto                   = tblprodutobarra.codproduto)
  left join tblprodutoembalagem    on (tblprodutoembalagem.codprodutoembalagem = tblprodutobarra.codprodutoembalagem)
  left join tblnaturezaoperacao    on (tblnaturezaoperacao.codnaturezaoperacao = tblnegocio.codnaturezaoperacao)
 where tblnegocio.codnegociostatus  = 2 -- fechado
   and tblnegocio.lancamento       >= '2025-07-31 00:00:00.0'
   and tblnegocio.lancamento       <= '2026-07-30 23:59:59.9'
   and tblnegocio.codpessoa         not in (select tblfilial.codpessoa from tblfilial)
   AND tblnegocioprodutobarra.inativo IS null
   and tblnaturezaoperacao.venda = true
  group by 
       tblproduto.codproduto
     , tblproduto.produto
  order by 4 desc
  
  
  
  
  
   select 
       tblproduto.codproduto
     , tblproduto.produto
     --, tblnegocio.codnegocio
     --, tblnegocio.lancamento
     , sum(tblnegocioprodutobarra.quantidade * coalesce(tblprodutoembalagem.quantidade, 1)) as quantidade
     , sum(tblnegocioprodutobarra.valortotal) as valor
  from tblnegocio 
  left join tblnegocioprodutobarra on (tblnegocioprodutobarra.codnegocio       = tblnegocio.codnegocio)
  left join tblprodutobarra        on (tblprodutobarra.codprodutobarra         = tblnegocioprodutobarra.codprodutobarra)
  left join tblproduto             on (tblproduto.codproduto                   = tblprodutobarra.codproduto)
  left join tblprodutoembalagem    on (tblprodutoembalagem.codprodutoembalagem = tblprodutobarra.codprodutoembalagem)
  left join tblnaturezaoperacao    on (tblnaturezaoperacao.codnaturezaoperacao = tblnegocio.codnaturezaoperacao)
 where tblnegocio.codnegociostatus  = 2 -- fechado
   and tblnegocio.lancamento       >= '2025-07-31 00:00:00.0'
   and tblnegocio.lancamento       <= '2026-07-30 23:59:59.9'
   and tblnegocio.codpessoa         not in (select tblfilial.codpessoa from tblfilial)
   AND tblnegocioprodutobarra.inativo IS null
   and tblnaturezaoperacao.venda = true
  group by 
       tblproduto.codproduto
     , tblproduto.produto
  order by 4 desc

  
  
select 
	date_trunc('month', nf.emissao) as mes, 
	sum(nf.valortotal) as valor
from tblnotafiscal nf
inner join tblnaturezaoperacao nat on (nat.codnaturezaoperacao = nf.codnaturezaoperacao)
where nf.codfilial in (101, 102, 103, 104, 105)
and nf.emitida 
and nf.status = 'AUT'
and nat.venda = true
group by date_trunc('month', nf.emissao)
order by mes desc