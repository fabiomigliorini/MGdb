﻿update tblnfeterceiroitem set margem = 37 where codnfeterceiro = 26761

UPDATE TBLNFETERCEIROITEM
SET CPROD = TBLNFETERCEIROITEM.CPROD || '/' || SEG.CPROD
, XPROD = TBLNFETERCEIROITEM.XPROD || ' + ' || SEG.XPROD
, CEAN = TBLNFETERCEIROITEM.CEAN || '/' || SEG.CEAN
, CEANTRIB = TBLNFETERCEIROITEM.CEANTRIB || '/' || SEG.CEANTRIB
, VUNCOM = TBLNFETERCEIROITEM.VUNCOM + SEG.VUNCOM
, VUNTRIB = TBLNFETERCEIROITEM.VUNTRIB + SEG.VUNTRIB
, VPROD = TBLNFETERCEIROITEM.VPROD + (SEG.VPROD / 1)
, VBC = TBLNFETERCEIROITEM.VBC + (SEG.VBC / 1)
, VICMS = TBLNFETERCEIROITEM.VICMS + (SEG.VICMS / 1)
, VBCST = TBLNFETERCEIROITEM.VBCST + (SEG.VBCST / 1)
, VICMSST = TBLNFETERCEIROITEM.VICMSST + (SEG.VICMSST / 1)
, IPIVBC = TBLNFETERCEIROITEM.IPIVBC + (SEG.IPIVBC / 1)
, IPIVIPI = TBLNFETERCEIROITEM.IPIVIPI + (SEG.IPIVIPI / 1)
, COMPLEMENTO = TBLNFETERCEIROITEM.COMPLEMENTO + (SEG.COMPLEMENTO / 1)
FROM TBLNFETERCEIROITEM SEG 
WHERE TBLNFETERCEIROITEM.CODNFETERCEIROITEM = 267979 -- que recebe o valor
AND SEG.CODNFETERCEIROITEM = 267980; -- que vai apagar

/*
UPDATE TBLNFETERCEIROITEM
SET QCOM = QCOM - (QCOM / 1)
, QTRIB = QTRIB - (QTRIB / 1)
, VPROD = VPROD - (VPROD / 1)
, VBC = VBC - (VBC / 1)
, VICMS = VICMS - (VICMS / 1)
, VBCST = VBCST - (VBCST / 1)
, VICMSST = VICMSST - (VICMSST / 1)
, IPIVBC = IPIVBC - (IPIVBC / 1)
, IPIVIPI = IPIVIPI - (IPIVIPI / 1)
, COMPLEMENTO = COMPLEMENTO - (COMPLEMENTO / 1)
WHERE TBLNFETERCEIROITEM.CODNFETERCEIROITEM = 267980
*/

DELETE FROM TBLNFETERCEIROITEM WHERE CODNFETERCEIROITEM = 267980;

SELECT 
	SUM(VPROD) AS VPROD,
	SUM(VUNTRIB * QTRIB) AS VUNTRIB,
	SUM(VBC) AS VBC,
	SUM(VICMS) AS VICMS,
	SUM(VBCST) AS VBCST,
	SUM(VICMSST) AS VICMSST,
	SUM(IPIVBC) AS IPIVBC,
	SUM(IPIVIPI) AS IPIVIPI
FROM TBLNFETERCEIROITEM 
WHERE CODNFETERCEIRO = 26761
;




select nextval('tblnfeterceiroitem_codnfeterceiroitem_seq')

update tblnfeterceiroitem set nitem = nitem * 100 where codnfeterceiro = 36204

select * from tblnfeterceiroitem t where codnfeterceiro = 36493 order by nitem

