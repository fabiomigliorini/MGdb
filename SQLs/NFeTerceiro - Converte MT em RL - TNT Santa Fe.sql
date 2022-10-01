-- SANTA FE
update tblnfeterceiroitem 
set qcom = qcom / 50,
ucom = 'RL',
vuncom = vuncom * 50
where codnfeterceiro = :codnfeterceiro 
and ucom = 'MT'
and cprod in (
	'211400050040035',
	'211400050040034',
	'211400050040028',
	'211400050040030',
	'211400050040002'
)

-- CAMESA
update tblnfeterceiroitem 
set qcom = qcom / 30,
ucom = 'RL',
vuncom = vuncom * 30
where codnfeterceiro = :codnfeterceiro 
and ucom = 'MT'
and cprod ilike '1.07532.01.%'


