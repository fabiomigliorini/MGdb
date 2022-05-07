
select e.sigla, sum(nf.valortotal)
from tblnotafiscal nf
inner join tblnaturezaoperacao nat on (nat.codnaturezaoperacao = nf.codnaturezaoperacao)
inner join tblpessoa p on (p.codpessoa = nf.codpessoa)
inner join tblcidade c on (c.codcidade = p.codcidade)
inner join tblestado e on (e.codestado = c.codestado)
inner join tblfilial f on (f.codfilial = nf.codfilial)
where f.codempresa  = 1
and nf.emissao >= '2020-01-01'
and nat.compra = true
group by e.sigla 
order by 2 desc


select * from tblnotafiscalprodutobarra t  where codnotafiscal = 2123127