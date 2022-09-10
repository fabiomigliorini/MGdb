


update tblnfeterceiroitem 
set nitem = nitem*100
where codnfeterceiro = :codnfeterceiro 

select nextval('tblnfeterceiroitem_codnfeterceiroitem_seq')