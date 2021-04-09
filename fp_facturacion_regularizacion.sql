CREATE OR REPLACE FUNCTION public.fp_facturacion_regularizacion(IN id_sociedad_soc_rs_desde text DEFAULT '0'::text,IN id_sociedad_soc_rs_hasta text DEFAULT  '9999999'::text,IN id_anno_mes_desde numeric DEFAULT  0,IN id_anno_mes_hasta numeric DEFAULT  999999)
    RETURNS integer
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100
    
AS $BODY$
DECLARE
	tp_registro RECORD;
	tp_registro_out RECORD;
	v_fact text;
	v_pos integer;
	v_tipo_factura text;
	v_tipo_coste text;
	v_tipo_documento text;
	v_usuario text;
	c_spxq refcursor;
	v_mes_letra_regularizacion text;
	v_mes_regularizacion text;
	v_anno_regularizacion text;
	v_concatena_fecha text;
	v_fecha_factura_regularizacion text;
	v_resultado_f text;
BEGIN
	
	------------------------- ATENCION ------------------------------------------------------------------------
    --- El rango de fechas debe ser el del trimestre a regularizar para que el proceso funcione correctamente.
	-----------------------------------------------------------------------------------------------------------
	
	v_tipo_factura := 'Regularizacion';
	v_tipo_coste := 'Variable';
	v_tipo_documento := 'LV';
	v_usuario := 'Jose'; -- este dato deberia entrar por parametros ¿?¿
	v_anno_regularizacion = (SELECT to_char(concat(id_anno_mes_hasta, '01')::date , 'YYYY')::integer);
	RAISE NOTICE 'v_anno_regularizacion%',v_anno_regularizacion;

	v_concatena_fecha := (SELECT concat(id_anno_mes_hasta, '01'));  	-- se formatea la fecha completa para aumentarla
	v_fecha_factura_regularizacion := (SELECT to_char(((v_concatena_fecha::date) + INTERVAL '1 month')::date, 'YYYYMM'));  -- se aumenta la fecha +1 mes
	RAISE NOTICE 'MES no 12, v_fecha_factura_regularizacion-%, ',v_fecha_factura_regularizacion;
	

	v_mes_letra_regularizacion := (SELECT to_char(concat(id_anno_mes_hasta + 1, '01')::date, 'TMMonth'));   -- extrae mes en letra, 'MM' si quisiera en numero
	
										  
	OPEN c_spxq for 
		with tabla_pxq
     		as (select id_sociedad_soc_rs
			  , id_proceso
              , sum(paq) as pxq
                from t_precio_consolidado AS pxq
		 				WHERE pxq.id_anno_mes BETWEEN id_anno_mes_desde AND id_anno_mes_hasta AND
							pxq.id_sociedad_soc_rs BETWEEN id_sociedad_soc_rs_desde AND id_sociedad_soc_rs_hasta 	
				group by id_sociedad_soc_rs, id_proceso),
     		tabla_facturacion
     		as (select id_proceso
            	  , sum(importe) as fact
                	from t_facturacion AS fact
		 					WHERE fact.id_anno_mes BETWEEN id_anno_mes_desde AND id_anno_mes_hasta AND
									fact.tipo_facturacion = 'Estimada'
                	group by id_proceso)
     		Select coalesce(tabla_pxq.id_proceso, tabla_facturacion.id_proceso) as id_proceso
				, tabla_pxq.id_sociedad_soc_rs
				, ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) as pxq  
				, ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3) as fact 
          		, ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) - ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3)  as regularizacion
				from tabla_pxq
                    	  full join tabla_facturacion on tabla_pxq.id_proceso = tabla_facturacion.id_proceso;		
	
	FETCH c_spxq into tp_registro;
		While (FOUND) Loop
			RAISE NOTICE 'v_fact%',v_fact;
			RAISE NOTICE 'v_pos%',v_pos;			
			INSERT INTO t_facturacion (tipo_facturacion, tipo_coste, sec_factura, id_anno_mes, tipo_documento, id_contrato, id_posicion, id_proceso, 
								  concepto, cantidad, importe, denominacion, id_usuario, fecha_cambios) 
				VALUES (v_tipo_factura, v_tipo_coste, 3, v_fecha_factura_regularizacion::integer, v_tipo_documento, 
										(SELECT id_contrato FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs),
										(SELECT id_posicion FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs)::integer,
										tp_registro.id_proceso, 'Concepto de Facturacion ???', 1, tp_registro.regularizacion, 
										(select concat('Concepto de Facturacion Reg', v_mes_letra_regularizacion, v_anno_regularizacion)), v_usuario, timestamp 'now');

		
			RAISE NOTICE 'id_contrato:%, id_posicion:%, id_proceso:%, pxq:%, fact:%, regularizacion:%',
				(SELECT id_contrato FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs),
			 	(SELECT id_posicion FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs),
				tp_registro.id_proceso, tp_registro.pxq, tp_registro.fact, tp_registro.regularizacion;
			
			FETCH c_spxq into tp_registro;
		END Loop;
		Close c_spxq;
		return 0;

	EXCEPTION
    	WHEN division_by_zero THEN
        	RAISE NOTICE 'division_by_zero';
    	when others then
        	RAISE INFO 'Error Name:%', SQLERRM;
        	RAISE INFO 'Error State:%', SQLSTATE;
        	return -1;	
			
/*			
	
*/					  
END;
$BODY$;