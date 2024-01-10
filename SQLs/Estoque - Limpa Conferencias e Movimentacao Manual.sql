
-- marca conferencias de estoeque como inativas
update tblestoquesaldoconferencia
set inativo = date_trunc('second', now()) 
where tblestoquesaldoconferencia.codestoquesaldoconferencia in (
	select esc.codestoquesaldoconferencia 
	from tblestoquesaldoconferencia esc
	inner join tblestoquesaldo es on (es.codestoquesaldo = esc.codestoquesaldo)
	inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocalprodutovariacao = es.codestoquelocalprodutovariacao)
	inner join tblprodutovariacao pv on (pv.codprodutovariacao = elpv.codprodutovariacao )
	where pv.codproduto = :codproduto
);

-- marca como nao conferido
update tblestoquesaldo 
set ultimaconferencia = null
where codestoquesaldo in (
	select esc.codestoquesaldo
	from tblestoquesaldoconferencia esc
	inner join tblestoquesaldo es on (es.codestoquesaldo = esc.codestoquesaldo)
	inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocalprodutovariacao = es.codestoquelocalprodutovariacao)
	inner join tblprodutovariacao pv on (pv.codprodutovariacao = elpv.codprodutovariacao )
	where pv.codproduto = :codproduto
);

-- apaga movimentos das conferencias de estoque
delete from tblestoquemovimento 
where tblestoquemovimento.codestoquesaldoconferencia in (
	select codestoquesaldoconferencia
	from tblestoquesaldoconferencia esc
	where esc.inativo is not null
);

-- apaga movimentos de transferencia de entrada manuais
delete from tblestoquemovimento 
where tblestoquemovimento.manual 
and tblestoquemovimento.codestoquemovimento in (
	select mov.codestoquemovimento 
	from tblestoquemovimento mov
	inner join tblestoquemes mes on (mes.codestoquemes = mov.codestoquemes )
	inner join tblestoquesaldo sld on (sld.codestoquesaldo = mes.codestoquesaldo)
	inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocalprodutovariacao = sld.codestoquelocalprodutovariacao)
	inner join tblprodutovariacao pv on (pv.codprodutovariacao = elpv.codprodutovariacao )
	where mov.manual = true
	and pv.codproduto = :codproduto
	and mov.codestoquemovimentoorigem is not null
);

-- esses tem que apagar  na mao (envolve outros produtos)
select mov.codestoquemovimento, mov.codestoquemes
from tblestoquemovimento mov
inner join tblestoquemes mes on (mes.codestoquemes = mov.codestoquemes )
inner join tblestoquesaldo sld on (sld.codestoquesaldo = mes.codestoquesaldo)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocalprodutovariacao = sld.codestoquelocalprodutovariacao)
inner join tblprodutovariacao pv on (pv.codprodutovariacao = elpv.codprodutovariacao )
inner join tblestoquemovimento dest on (dest.codestoquemovimentoorigem = mov.codestoquemovimento)
where mov.manual = true
and pv.codproduto = :codproduto
order by codestoquemes desc
;

-- apaga restante dos movimentos manuais
delete from tblestoquemovimento 
where tblestoquemovimento.manual 
and tblestoquemovimento.codestoquemovimento in (
	select mov.codestoquemovimento 
	from tblestoquemovimento mov
	inner join tblestoquemes mes on (mes.codestoquemes = mov.codestoquemes )
	inner join tblestoquesaldo sld on (sld.codestoquesaldo = mes.codestoquesaldo)
	inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocalprodutovariacao = sld.codestoquelocalprodutovariacao)
	inner join tblprodutovariacao pv on (pv.codprodutovariacao = elpv.codprodutovariacao )
	where mov.manual = true
	and pv.codproduto = :codproduto
);

select ' time curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || mes.codestoquemes || ' '
from tblestoquemes mes
inner join tblestoquesaldo sld on (sld.codestoquesaldo = mes.codestoquesaldo)
inner join tblestoquelocalprodutovariacao elpv on (elpv.codestoquelocalprodutovariacao = sld.codestoquelocalprodutovariacao)
inner join tblprodutovariacao pv on (pv.codprodutovariacao = elpv.codprodutovariacao )
where pv.codproduto = :codproduto
order by elpv.codestoquelocalprodutovariacao, mes.codestoquesaldo, mes.mes;



with tot as (
	select mov.codestoquemes, sum(mov.entradaquantidade) as entradaquantidade, sum(mov.saidaquantidade) as saidaquantidade
	from tblprodutovariacao pv
	inner join tblestoquelocalprodutovariacao elpv on (elpv.codprodutovariacao = pv.codprodutovariacao)
	inner join tblestoquesaldo sld on (sld.codestoquelocalprodutovariacao = elpv.codestoquelocalprodutovariacao)
	inner join tblestoquemes mes on (mes.codestoquesaldo = sld.codestoquesaldo)
	inner join tblestoquemovimento mov on (mov.codestoquemes = mes.codestoquemes)
	where pv.codproduto = :codproduto 
	group by mov.codestoquemes
)
select ' time curl https://sistema.mgpapelaria.com.br/MGLara/estoque/calcula-custo-medio/' || mes.codestoquemes || ' ', tot.entradaquantidade, mes.entradaquantidade, coalesce(mes.saidaquantidade , 0), coalesce(tot.saidaquantidade , 0)
from tot
inner join tblestoquemes mes on (mes.codestoquemes = tot.codestoquemes)
where (coalesce(mes.entradaquantidade, 0) != coalesce(tot.entradaquantidade, 0)
or coalesce(mes.saidaquantidade , 0) != coalesce(tot.saidaquantidade , 0))
