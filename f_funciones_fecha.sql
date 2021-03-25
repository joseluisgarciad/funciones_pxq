
SELECT ('20211201'::date) + INTERVAL '1 month';
SELECT ('20211201'::date) + INTERVAL '1 year';
SELECT ('20211201'::date) + INTERVAL '1 day';
SELECT to_char((('20211201'::date) + INTERVAL '1 month')::date, 'YYYYMM');
SELECT to_char((('20211201'::date) + INTERVAL '1 year')::date, 'YYYYMM');
SELECT to_char((('20211201'::date) + INTERVAL '1 day')::date, 'YYYYMM');  
SELECT to_char(concat(202112, '01')::date , 'YYYY')::integer
SELECT to_char(concat(202112, '01')::date , 'MM')::integer
SELECT to_char(concat(202112, '01')::date , 'DD')::integer
select to_char(concat(202103 + 1, '01')::date, 'TMMonth')  -- Mes en letra
select to_char(concat(202103 + 1, '01')::date, 'TMDay')   --- Dia en letra
-- esto funciona regular, solo funciona hasta diciembre porque si le das aumentar una fecha de diciembre, da error
SELECT to_char(concat(202112 + 1, '01')::date, 'YYYYMM') 



--- ====================================================================================

/*
create or replace function f_sumar_meses(var_dte date,cnt int) returns setof date as
$$
declare
qry text;
begin
qry = format( 'select (''%s''::date + interval ''%s'')::date',var_dte,cnt||' month') ;
RETURN QUERY
     EXECUTE qry;
end
$$
language plpgsql
*/
SELECT to_char(f_Sumar_meses('20211201',1)::date, 'YYYYMM')
