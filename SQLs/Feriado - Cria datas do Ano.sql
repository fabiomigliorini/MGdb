-- select * from tblferiado
-- http://www.feriados.com.br/feriados-sinop-mt.php

-- NACIONAL - DATA FIXA
INSERT INTO tblferiado (data, feriado) values ('2023-01-01', 'Ano Novo'); -- OK
INSERT INTO tblferiado (data, feriado) values ('2023-04-21', 'Tiradentes'); -- OK
INSERT INTO tblferiado (data, feriado) values ('2023-05-01', 'Dia do Trabalho'); -- OK
INSERT INTO tblferiado (data, feriado) values ('2023-09-07', 'Independencia'); -- OK
INSERT INTO tblferiado (data, feriado) values ('2023-10-12', 'Nossa Senhora Aparecida'); -- OK
INSERT INTO tblferiado (data, feriado) values ('2023-11-02', 'Finados'); -- OK
INSERT INTO tblferiado (data, feriado) values ('2023-11-15', 'Proclamacao da Republica'); -- OK
INSERT INTO tblferiado (data, feriado) values ('2023-12-25', 'Natal'); -- OK

-- NACIONAL - DATA VARIAVEL
INSERT INTO tblferiado (data, feriado) values ('2023-04-07', 'Sexta-Feira Santa'); -- OK
INSERT INTO tblferiado (data, feriado) values ('2023-02-21', 'Carnaval');  -- OK

-- ESTADUAL
INSERT INTO tblferiado (data, feriado) values ('2023-11-20', 'Consciencia Negra'); -- OK

-- MUNICIPAL
INSERT INTO tblferiado (data, feriado) values ('2023-09-14', 'Aniversario Sinop'); -- OK
INSERT INTO tblferiado (data, feriado) values ('2023-06-08', 'Corpus Christi'); -- OK
INSERT INTO tblferiado (data, feriado) values ('2023-06-13', 'Santo Antonio'); -- OK


select * from tblferiado order by data desc