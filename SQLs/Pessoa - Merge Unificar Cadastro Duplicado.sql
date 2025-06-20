

update tblnegocio set codpessoa = :manter where codpessoa = :eliminar;

update tblmercoscliente set codpessoa = :manter where codpessoa = :eliminar;

update tbltitulo set codpessoa = :manter where codpessoa = :eliminar;

update tblnotafiscal set codpessoa = :manter where codpessoa = :eliminar;

update tblpagarmepedido set codpessoa = :manter where codpessoa = :eliminar;

update tblcobrancahistorico set codpessoa = :manter where codpessoa = :eliminar;

update tblliquidacaotitulo set codpessoa = :manter where codpessoa = :eliminar;

update tbltituloagrupamento set codpessoa = :manter where codpessoa = :eliminar;

delete from tblpessoa where codpessoa = :eliminar;

select mc.codmercoscliente, p.codpessoa, p.pessoa, p.cnpj, dup.codpessoa, dup.pessoa
from tblmercoscliente mc 
inner join tblpessoa p on (mc.codpessoa = p.codpessoa and p.ie is null)
inner join tblpessoa dup on (dup.cnpj = p.cnpj and dup.codpessoa != p.codpessoa)
order by mc.criacao ;


select cnpj, fisica, ie, min(fantasia), max(fantasia), count(*), max(criacao)
from tblpessoa p 
group by cnpj, fisica, ie
having count(*) > 1
order by 7 desc;

select * 
from tblpdv t 
order by criacao desc


select * from tblpixcob t where valororiginal  = 26.9 order by criacao desc


select * from tblnaturezaoperacao t 

select p.codpessoa, mc.codmercoscliente as mercos, p.cnpj, p.fantasia, p.pessoa 
from tblpessoa p
inner join tblmercoscliente mc on (mc.codpessoa = p.codpessoa)
where p.cnpj in (
	select pd.cnpj
	from tblpessoa pd
	group by pd.cnpj
	having count(*) > 1
)
order by p.codpessoa