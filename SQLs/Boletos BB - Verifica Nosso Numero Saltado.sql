-- insere na base numeros saltados vinculados a um titulo de teste
with faixa as (
	select min(t.nossonumero)::numeric as min, max(t.nossonumero)::numeric as max
	from tbltituloboleto t 
	where t.codportador = :codportador
	and t.vencimento >= '2024-01-01'
)
insert into tbltituloboleto (codtitulo, codportador, nossonumero)
select :codtitulo, :codportador, to_char(seq, 'FM00000000000000000000')
from faixa, generate_series(faixa.min, faixa.max) seq
where not exists (
	select tit.codtitulo 
	from tbltituloboleto tit
	where tit.codportador = :codportador
	and tit.nossonumero::numeric = seq
)

-- consulta os boletos desse titulo de teste
select 
	' curl https://api-mgspa.mgpapelaria.com.br/api/v1/titulo/' || t.codtitulo || '/boleto-bb/' || t.codtituloboleto || '/consultar -X POST  -H "Accept: text/json" | head -n 5'
from tbltituloboleto t 
where codtitulo  = :codtitulo 

-- apaga boletos que nao conseguiram ser consultados
delete 
from tbltituloboleto
where codtitulo  = :codtitulo 
and vencimento is null

