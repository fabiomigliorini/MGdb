﻿alter table tblproduto add abc char(1) not null default 'C' check (abc in ('A', 'B', 'C'));

update tblproduto set abc = 'A' where codproduto in (
22920
, 115
, 9785
, 3878
, 1146
, 104564
, 6342
, 234
, 4747
, 564
, 2308
, 565
, 4076
, 106
, 318814
, 374
, 9880
, 861
, 17307
, 1345
, 100
, 31842
, 313382
, 891
, 377
, 862
, 315428
, 17555
, 1542
, 35780
, 684
, 307794
, 17550
, 302598
, 495
, 933476
, 10191
, 311901
, 102
, 17578
, 3643
, 19154
, 4389
, 25370
, 28438
, 373
, 30811
, 306282
, 760
, 2538
, 9845
, 318228
, 22364
, 34872
, 21786
, 10554
, 2406
, 3780
, 25999
);

update tblproduto set abc = 'B' where codproduto in (
316273
, 23498
, 602
, 18421
, 1079
, 30003
, 110
, 319104
, 29006
, 32396
, 6873
, 3782
, 1543
, 3784
, 33
, 106045
, 368
, 441
, 7141
, 1077
, 28267
, 1148
, 2457
, 35210
, 102094
, 6914
, 35760
, 6281
, 3751
, 30002
, 307826
, 931114
, 2418
, 24556
, 25350
, 311403
, 24811
, 1637
, 969
, 22921
, 26031
, 22790
, 105271
, 1462
, 25197
, 933683
, 1662
, 13234
, 727
, 33405
, 4034
, 15032
, 728
, 200268
, 13296
, 311196
, 713
, 106389
, 1555
, 866
, 3720
, 86
, 890
, 189
, 931390
, 30
, 3388
, 2947
, 14914
, 310355
, 557
, 25095
, 103107
, 107662
, 15033
, 30184
, 2119
, 306212
, 307579
, 318988
, 314251
, 381
, 21849
, 748
, 2774
, 104880
, 32612
, 13273
, 21787
, 1661
, 187
, 1574
, 23017
, 2529
, 307161
, 3384
, 23899
, 21589
, 34890
, 1089
, 4117
, 24389
, 313196
, 312555
, 31093
, 555
, 4050
, 15662
, 188
, 2223
, 314533
, 3010
, 21482
, 367
, 578
, 19094
, 933844
, 304141
, 25807
, 28686
, 7756
, 108901
, 12210
, 25198
, 5443
, 307400
, 7697
, 932501
, 725
, 310516
, 100956
, 191
, 26627
, 110640
, 108671
, 930995
, 14565
, 1090
, 1138
, 638
, 7266
, 805
, 13310
, 6906
, 103766
, 1078
, 101305
, 31916
, 23295
, 24151
, 1665
, 264
, 1608
, 4964
, 2233
, 28348
, 13297
, 933741
, 28289
, 311282
, 26554
, 21935
, 22953
, 1357
, 32397
, 13303
, 8606
, 930832
, 25806
, 23495
, 30738
, 715
, 892
, 24557
, 101067
, 1607
, 307096
, 29
, 28670
, 731
, 13311
, 3957
, 32
, 103591
, 24720
, 105162
, 32448
, 311707
, 105269
, 5414
, 104873
, 193
, 1225
, 23496
, 318710
, 6965
, 22009
, 780
, 12209
, 933321
, 31092
, 315431
, 18472
, 29324
, 19156
, 35173
, 109452
, 7
, 1087
, 20840
, 3303
, 263
, 4965
, 15044
, 4634
, 1155
, 9673
, 106126
, 22954
, 792
, 2224
, 931930
, 3716
, 14
, 1676
, 100199
, 312458
, 2364
, 103808
, 13255
, 444
, 29013
, 25030
, 17382
, 313349
, 100202
, 29274
, 23128
, 310866
, 100201
, 931191
, 23417
, 26555
, 952
, 314250
, 1438
, 317456
, 20416
, 107925
, 314798
, 103
, 7758
, 25810
, 3296
, 933480
, 313377
, 18077
, 932333
, 310003
, 312407
, 1221
, 31932
, 318297
, 27101
, 601
, 26556
, 36560
, 16619
, 932377
, 1157
, 26712
, 932069
, 20633
, 23127
, 1088
, 190
, 14906
, 103047
, 314852
, 32714
, 26590
, 192
, 28
, 29456
, 12211
, 310517
, 25254
, 15342
, 599
, 76
, 15429
, 7819
, 726
, 28160
, 18130
, 7696
, 32253
, 1439
, 19
, 11
, 26483
, 18798
, 3738
, 931577
, 7047
, 18471
, 932025
, 24312
, 7473
, 3649
, 2278
, 30571
, 108622
, 4003
, 26582
);

update tblproduto set abc = 'C' where produto ilike 'mochila%' and abc != 'C';
update tblproduto set abc = 'A' where produto ilike 'eva 02%' and abc != 'A';

select abc, count(*) from tblproduto group by abc;

update tblnfeterceiroitem set margem = 37;

update tblnfeterceiroitem set margem = 30 where codprodutobarra in (
	select pb.codprodutobarra
	from tblproduto p
	inner join tblprodutobarra pb on (pb.codproduto = p.codproduto)
	where p.abc = 'A'
);

update tblnfeterceiroitem set margem = 33.5 where codprodutobarra in (
	select pb.codprodutobarra
	from tblproduto p
	inner join tblprodutobarra pb on (pb.codproduto = p.codproduto)
	where p.abc = 'B'
);

update tblnfeterceiroitem set margem = 20 where codprodutobarra in (
	select pb.codprodutobarra
	from tblproduto p
	inner join tblprodutobarra pb on (pb.codproduto = p.codproduto)
	where p.codmarca = 511
);

update tblnfeterceiroitem set margem = null where codprodutobarra in (
	select pb.codprodutobarra
	from tblproduto p
	inner join tblprodutobarra pb on (pb.codproduto = p.codproduto)
	where p.codtipoproduto != 0
);



