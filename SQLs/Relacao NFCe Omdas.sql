select codfilial, nfechave, emissao --, valortotal
--select count(*)
from tblnotafiscal
where cpf is null
and emissao between '2021-04-14 00:00:00' and '2022-07-05 23:59:59'
and emitida = true
and modelo = 65
and nfecancelamento is null
and nfeinutilizacao is null
and nfeautorizacao is not null
--and codfilial not in (103) -- OMDAS
and codfilial in (103) -- MENINO JESUS
order by codfilial, nfechave