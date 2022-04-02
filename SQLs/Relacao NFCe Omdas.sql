--select codfilial, nfechave, emissao --, valortotal
select count(*)
from tblnotafiscal
where cpf is null
and emissao between '2021-10-26 00:00:00' and '2022-03-27 23:59:59'
and emitida = true
and modelo = 65
and nfecancelamento is null
and nfeinutilizacao is null
and nfeautorizacao is not null
and codfilial in (103)
--order by codfilial, nfechave