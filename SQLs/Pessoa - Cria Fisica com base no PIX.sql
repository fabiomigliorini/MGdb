
with pix as (
	select pix.cpf, max(pix.nome) as nome, count(*) as quantidade
	from tblpix pix
	where pix.nome is not null 
	and pix.cpf is not null
	--and pix.nome ilike :nome
	and pix.cpf = :cpf
	group by pix.cpf
)
insert into tblpessoa (
	cnpj, 
	fisica, 
	pessoa, 
	fantasia, 
	telefone1, 
	email, 
	endereco, 
	numero, 
	bairro, 
	codcidade,
	cep,
	enderecocobranca, 
	numerocobranca, 
	bairrocobranca, 
	codcidadecobranca,
	cepcobranca,
	cliente,
	codgrupocliente,
	observacoes,
	mensagemvenda,
	notafiscal
)	
select 
	pix.cpf as cnpj, 
	true as fisica, 
	pix.nome as pessoa, 
	pix.nome as fantasia, 
	'66 0000 0000' as telefone1, 
	'nfe@mgpapelaria.com.br' as email, 
	'Avenida' as endereco, 
	'S/N' as numero, 
	'Bairro' as bairro, 
	5021 as codcidade, -- Sinop
	78550000 as cep,
	'Avenida' as enderecocobranca, 
	'S/N' as numerocobranca, 
	'Bairro' as bairrocobranca, 
	5021 as codcidadecobranca, -- Sinop
	78550000 as cepcobranca,
	true as cliente,
	7 as codgrupocliente, --consumidor pessoa fisica
	'Cadastro Automatico PIX. Confirmar Endereço, Telefone e Email.' as observacoes,
	'Cadastro Automatico PIX. Confirmar Endereço, Telefone e Email.' as mensagemvenda,
	0 as notafiscal -- Tratamento Padrao
from pix
left join tblpessoa pe on (pe.cnpj = pix.cpf)
where pe.codpessoa is null



select notafiscal, * from tblpessoa where codpessoa = 14601