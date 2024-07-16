/**
 * Joga faixa de numeracao das sequences para 70000000
 * pra utilizacao na base de contignencia
 * assim fica identificado quais os registros foram criados
 * no periodo de contingencia
 */
do
$$
declare
    seq record;
    qry varchar;
    minimo bigint;
    maximo bigint;
   	prox bigint;
begin
	
	-- tabela temporaria para guardar sequences alteradas
	create temp table seqsalteradas (sequence_name varchar not null primary key) on commit drop;

	-- busca todas as sequences vinculadas a uma tabela (default nextval(sequence_name))
	for seq in (
		SELECT c.table_name, c.column_name, s.sequence_name
		FROM information_schema.sequences s
		INNER JOIN information_schema.columns c ON (c.column_default ilike  '%' || s.sequence_name || '%')
		ORDER BY s.sequence_name
	) 
	loop 
		
		-- se for da tabela de produtos, utiliza 6 digitos
	    if (seq.table_name = 'tblproduto') then
	    	minimo = 700000;
	    	maximo = 799999;
	    
	    -- se for das tabelas de jobs, comeca em 0
	    elseif (seq.table_name in ('tbljobs', 'tbljobsfailed', 'tbljobsfailedspa', 'tbljobsspa')) then
	    	minimo = 0;
	    	maximo = 99999999;
	    
	    -- se nao utiliza 8 digitos
	    else 
	    	minimo = 70000000;
	    	maximo = 79999999;
	    end if;
	   
	   -- prox = ultimo reigstro utilizado na faixa + 1
	    qry = format('select coalesce(max(%s), %s) + 1 from %s where %s between %s and %s;', 
	   			seq.column_name, minimo, seq.table_name, seq.column_name, minimo, maximo);
	    raise notice '%', qry;
	   	execute qry into prox;
	   
	    -- altera minimo e maximo da sequence pra evitar que esteja fora da faixa no setval
	    qry = format('alter sequence %s start 1 minvalue 1 no maxvalue;', seq.sequence_name);
	    raise notice '%', qry;
	   	execute qry;
	   
	   	-- seta proximo registro = proximo
	    qry = format('select setval(''%s'', %s, false);', seq.sequence_name, prox);
	    raise notice '%', qry;
	   	execute qry;
	   	insert into seqsalteradas values (seq.sequence_name); 
	end loop;

	-- busca as sequences que não estavam vinculadas com nenhuma chave primaria
    -- exemplo, sequence que controla proxiumo numero de nota fiscal
    -- tblnotafiscal_numero_101_1_55_seq
	for seq in (
		SELECT s.sequence_name
		FROM information_schema.sequences s
		WHERE s.sequence_name NOT IN (select alt.sequence_name from seqsalteradas alt)
		ORDER BY s.sequence_name
	) 
	loop
		
		-- prox = cria um gap de 100 registros
	    qry = format('select nextval(''%s'') + 99;', seq.sequence_name);
	    raise notice '%', qry;
	   	execute qry into prox;
	   
	    -- altera minimo e maximo da sequence pra evitar que esteja fora da faixa no setval
	    qry = format('alter sequence %s start 1 minvalue 1 no maxvalue;', seq.sequence_name);
	    raise notice '%', qry;
	   	execute qry;
	   
   	   	-- seta proximo registro = proximo
	    qry = format('select setval(''%s'', %s, false);', seq.sequence_name, prox);
	    raise notice '%', qry;
	   	execute qry;
	end loop;
end;
$$
