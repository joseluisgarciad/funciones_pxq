CREATE OR REPLACE FUNCTION public.fp_escribir_log_ejecucion(IN id_anno_mes numeric,IN ejecucion text,IN id_pais text,IN id_sociedad_csl text,IN id_proceso text,IN id_subproceso text,IN id_inductor_q text,IN descripcion text,IN id_usuario text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100
    
AS $BODY$
DECLARE

BEGIN
				
	INSERT INTO t_log_ejecucion (id_anno_mes, ejecucion, id_pais, id_sociedad_csl, id_proceso, id_subproceso, 
				id_inductor_q, descripcion, id_usuario, fecha_cambios) 
		VALUES (id_anno_mes, ejecucion, id_pais, id_sociedad_csl, id_proceso, id_subproceso, 
				id_inductor_q, descripcion, id_usuario, timestamp 'now');
	
	return 0;

	EXCEPTION
    	WHEN division_by_zero THEN
        	RAISE NOTICE 'division_by_zero';
    	when others then
        	RAISE INFO 'Error Name:%', SQLERRM;
        	RAISE INFO 'Error State:%', SQLSTATE;
        	return -1;
			
END;
$BODY$;