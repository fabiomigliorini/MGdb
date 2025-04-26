
select a.codfilial, a.data,  a.nsu, a.nsu - 1 as falltando, ' php artisan nfe-php:dist-dfe --codfilial=' || a.codfilial  ||  ' --numNSU=' || a.nsu - 1 
from tbldistribuicaodfe a
left join tbldistribuicaodfe b on (a.codfilial = b.codfilial and a.nsu - 1 = b.nsu)
where b.coddistribuicaodfe is null
and a.data >= now() - '1 years'::interval
order by a.codfilial, a.nsu desc


select a.codfilial, a.data,  a.nsu 
from tbldistribuicaodfe a
where a.codfilial = :codfilial
order by a.codfilial, a.nsu desc
