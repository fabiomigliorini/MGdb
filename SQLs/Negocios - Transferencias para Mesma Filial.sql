/*
select mov.codestoquemes, mov.entradaquantidade, mov.entradavalor, mov.manual, mov.codnegocioprodutobarra, npb.codnegocio, n.codfilial
from tblestoquemovimento mov
inner join tblestoquemovimento orig on (orig.codestoquemovimento = mov.codestoquemovimentoorigem)
left join tblnegocioprodutobarra npb on (npb.codnegocioprodutobarra = mov.codnegocioprodutobarra)
left join tblnegocio n on (n.codnegocio = npb.codnegocio)
where mov.codestoquemes = orig.codestoquemes
and mov.codestoquemovimentotipo in (4101, 4201)
--limit 50
*/
--select * from tblestoquemovimentotipo

select u.usuario, date_trunc('month', n.lancamento), n.codnegocio, f.filial
from tblnegocio n
inner join tblfilial f on (f.codfilial = n.codfilial)
left join tblusuario u on (u.codusuario = n.codusuario)
where n.codpessoa = f.codpessoa
and n.codnaturezaoperacao in (15, 16)
and n.codnegociostatus = 2
order by n.lancamento desc


-- uso consumo
update tblnegocio set codnaturezaoperacao = 19 where codnegocio = :codnegocio

-- perda
update tblnegocio set codnaturezaoperacao = 18 where codnegocio = :codnegocio

-- transferencia
update tblnegocio set codnaturezaoperacao = 15 where codnegocio = :codnegocio

-- altera filial destino
update tblnegocio set codpessoa = :codpessoa where codnegocio = :codnegocio


--altera filial origem
update tblnegocio set codestoquelocal = :codestoquelocal, codfilial = :codfilial where codnegocio = :codnegocio











select * from tblestoquemovimento where codestoquemovimento = 17686409

select * from tblusuario where codusuario = 10000005



update tblnegocio 
set codnegociostatus = 3
where codnegocio in (1858972
,1649041
,1594350
,1574534
,1538708
,1518447
,1513804
,1491341
,1481336
,1458662
,1398437
,1351302
,1306465
,1274982
,1160443
,1146983
,1134902
,1124536
,1123060
,1117596
,1111629
,1092492
,1070015
,1063266
,1047709
,1023686
,1017621
,922587
,922593
,921476
,896840
,889271
,852253
,846328
,810428
,789923
,766874
,761415
,729079
,720570
,710315
,702847
,679851
,677214
,674756
,673151
,656117
,640595
,639075
,635475
,633675
,616370
,616180
,615898
,615285
,614736
,614548
,614504
,613053
,605682
,605649
,596883
,586727
,586697
,586651
,581518
,578829
,569233
,568785
,560870
,559651
,558165
,547373
,544834
,543508
,535128
,534841
,532525
,528554
,520074
,519959
,516650
,512510
,503273
,502854
,492588
,477817
,460186
,458953
,451698
,330695
,321443
,302086
,273935
,257447
,293711
,275068
,252608
,277431
,252441
,256437
,249100
,224829
,244455
,237983
,235649
,234101
,227966)

