
select current_date;
select current_time;
select current_timestamp;
select extract(year from  timestamp'2009-12-31 12:25:50');
select extract(month from  timestamp'2009-12-31 12:25:50');
select extract(day from  timestamp'2009-12-31 12:25:50');
select extract(hour from  timestamp'2009-12-31 12:25:50');
select extract(minute from  timestamp'2009-12-31 12:25:50');
select extract(second from  timestamp'2009-12-31 12:25:50');
select extract(century from  timestamp'2009-12-31 12:25:50');
select extract(dow from  timestamp'2009-12-31 12:25:50');
select extract(doy from  timestamp'2009-12-31 12:25:50');
select extract(week from  timestamp'2009-12-31 12:25:50');
select extract(quarter from  timestamp'2009-12-31 12:25:50');
 select titulo from libros
  where extract(day from edicion)=9; -- filtra por la parte del dia de la fecha 'edicion'

SELECT ('20211201'::date) + INTERVAL '1 month';
SELECT ('20211201'::date) + INTERVAL '1 year';
SELECT ('20211201'::date) + INTERVAL '1 day';
SELECT to_char((('20211201'::date) + INTERVAL '1 month')::date, 'YYYYMM');
SELECT to_char((('20211201'::date) + INTERVAL '1 year')::date, 'YYYYMM');
SELECT to_char((('20211201'::date) + INTERVAL '1 day')::date, 'YYYYMM');  
SELECT to_char(concat(202112, '01')::date , 'YYYY')::integer
SELECT to_char(concat(202112, '01')::date , 'MM')::integer
SELECT to_char(concat(202112, '01')::date , 'DD')::integer
SELECT to_char(concat(202112, '01')::date, 'TMMonth')   -- extrae mes en letra, 'MM' si quisiera en numero
SELECT to_char(concat(202112, '01')::date, 'MM')
SELECT to_char(concat(202112, '01')::date , 'YYYY')
-- esto funciona regular, solo funciona hasta diciembre porque si le das aumentar una fecha de diciembre, da error
select to_char(concat(202103 + 1, '01')::date, 'TMMonth')  -- Mes en letra
select to_char(concat(202103 + 1, '01')::date, 'TMDay')   --- Dia en letra
SELECT to_char(concat(202112 + 1, '01')::date, 'YYYYMM') 

SELECT to_char((('20210401'::date) - INTERVAL '1 month')::date, 'YYYYMM')

Select to_char(sum(25.22 * 2525432.2), '999,999,999.999')
SELECT (202103)::integer
SELECT (202103)::text
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

--- ====================================================================================

CREATE FUNCTION nextSunday() RETURNS date AS $$
DECLARE
    dia_semana INT := CAST(EXTRACT(DOW FROM CURRENT_DATE)as INT);
    dia INT :=  7 - dia_semana;
BEGIN
    RETURN current_date + dia;
END;
$$ LANGUAGE plpgsql