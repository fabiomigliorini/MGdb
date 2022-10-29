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
	'211400050040016'
)

-- CAMESA
update tblnfeterceiroitem 
set qcom = qcom / 30,
ucom = 'RL',
vuncom = vuncom * 30
where codnfeterceiro = :codnfeterceiro 
and ucom = 'MT'
and cprod ilike '1.07532.01.%'


select * from tblnegocioprodutobarra t where codnegocio = 2850977

update tblnegocioprodutobarra  set valorunitario = valortotal /quantidade where codnegocio = 2850977


select * from tblnotafiscalprodutobarra t2   where codnotafiscal  = 2217066

update tblnotafiscalprodutobarra  set valorunitario = valortotal /quantidade where codnotafiscal = 2217066
