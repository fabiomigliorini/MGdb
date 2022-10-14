
update tblnegocio 
set codpessoavendedor = 
	(select p.codpessoa 
	from tblpessoa p 
	where p.vendedor = true
	and inativo is null
	and p.pessoa ilike :vendedor) 
where codnegocio = :codnegocio
and valortotal = :valortotal 
