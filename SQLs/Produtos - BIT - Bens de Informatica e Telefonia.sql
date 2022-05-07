/*
Baixado de:
https://www.gov.br/produtividade-e-comercio-exterior/pt-br/assuntos/camex/estrategia-comercial/listas-vigentes
Anexo VI - Lista de Exceções de Bens de Informática e Telecomunicações e Bens de Capital - LEBIT/BK.

Importado em tblanexovilebitbk
*/


--UPDATE tblanexovilebitbk SET ncm = replace(ncm, '.', '')

-- limpa a coluna de ncm
update tblanexovilebitbk set ncm = trim(replace(ncm, '.', ''))

-- marca como bit os que estao no anexo
update tblncm set bit = true where tblncm.ncm in (select a.ncm from tblanexovilebitbk a) and bit = false

-- marca como nao bit os que nao estao no anexo
update tblncm set bit = false where tblncm.ncm not in (select a.ncm from tblanexovilebitbk a)  and bit = true

update tblnegocio set codnegociostatus = 2 where codnegocio = 2637803

update tblnegocio set lancamento = '2022-03-22 10:17:52' where codnegocio = 2637803


