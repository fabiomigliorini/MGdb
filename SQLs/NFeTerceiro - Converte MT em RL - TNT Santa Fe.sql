-- SANTA FE
update tblnfeterceiroitem 
set qcom = qcom / 50,
ucom = 'RL',
vuncom = vuncom * 50
where codnfeterceiro = :codnfeterceiro 
and ucom = 'MT'
and cprod in (
	'211400050040044',
	'211400050040035',
	'211400050040034',
	'211400050040028',
	'211400050040030',
	'211400050040002',
	'211400050040027',
	'211400050040065',
	'211400050040003',
	'211400050040015',
	'211400050040016',
	'211400050040013',
	'211400050040088',
	'211400050040029'
)

-- CAMESA
update tblnfeterceiroitem 
set qcom = qcom / 30,
ucom = 'RL',
vuncom = vuncom * 30
where codnfeterceiro = :codnfeterceiro 
and ucom = 'MT'
and cprod ilike '1.07532.01.%'


-- PEGON
update tblnfeterceiroitem 
set qcom = :quantidade_bobinas,
ucom = 'RL',
vuncom = vprod / :quantidade_bobinas
where codnfeterceiro = :codnfeterceiro 
and ucom = 'KG'
and cprod ilike '3'



