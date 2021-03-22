CREATE OR REPLACE FUNCTION public.fp_facturacion_regularizacion(IN id_sociedad_soc_rs_desde text DEFAULT '0'::text,IN id_sociedad_soc_rs_hasta text DEFAULT  '9999999'::text,IN id_anno_mes_desde numeric DEFAULT  0,IN id_anno_mes_hasta numeric DEFAULT  999999)

DECLARE
	tp_registro RECORD;
	tp_registro_out RECORD;
	v_fact text;
	v_pos integer;
	v_tipo_factura text;
	c_spxq refcursor;

BEGIN

	v_tipo_factura := 'Regularizacion';
	
	OPEN c_spxq for 
		with tabla_pxq
     		as (select id_sociedad_soc_rs
			  , id_proceso
              , sum(paq) as pxq
                from t_precio_consolidado AS pxq
		 				WHERE pxq.id_anno_mes BETWEEN 202101 AND 202101 
                group by id_sociedad_soc_rs, id_proceso),
     		tabla_facturacion
     		as (select id_proceso
            	  , sum(importe) as fact
                	from t_facturacion AS fact
		 					WHERE fact.id_anno_mes BETWEEN 202101 AND 202101 
                	group by id_proceso)
     		Select coalesce(tabla_pxq.id_proceso, tabla_facturacion.id_proceso) as id_proceso
				, tabla_pxq.id_sociedad_soc_rs
          		, tabla_pxq.pxq
          		, tabla_facturacion.fact
          		, NULLIF(tabla_pxq.pxq,0) - NULLIF(tabla_facturacion.fact,0) as regularizacion
            		from tabla_pxq
                    	  full join tabla_facturacion on tabla_pxq.id_proceso = tabla_facturacion.id_proceso;		
	/*
	select * from t_precio_consolidado
		Where t_precio_consolidado.id_anno_mes BETWEEN $3 AND $4;
		/*AND t_precio_consolidado.id_stack = $3 AND
			  t_precio_consolidado.id_sociedad_csl = $4 AND t_precio_consolidado.id_sociedad_soc_rs = $5 AND
			  t_precio_consolidado.id_proceso = $6 AND t_precio_consolidado.id_subproceso = $5; */
	*/
	
	FETCH c_spxq into tp_registro;
		While (FOUND) Loop
			--v_fact := SELECT id_factura FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs;
			--v_pos := SELECT id_posicion FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs;			
			RAISE NOTICE 'v_fact%',v_fact;
			RAISE NOTICE 'v_pos%',v_pos;			
			INSERT INTO t_facturacion (tipo_facturacion, tipo_coste, sec_factura, id_anno_mes, tipo_documento, id_contrato, id_posicion, id_proceso, 
								  concepto, cantidad, importe, denominacion, id_usuario, fecha_cambios) 
				VALUES (v_tipo_factura, 'Variable', 3, 202104, 'LV', 
										(SELECT id_contrato FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs),
										(SELECT id_posicion FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs)::integer,
										tp_registro.id_proceso, 'Concepto de Facturacion ???', 1, tp_registro.regularizacion, 'Concepto de Facturacion ???Abril2021', 'Jose', timestamp 'now');

--			UPDATE t_precio_consolidado
--				SET paq = v_paq, par = v_par, id_usuario = 'Jose', fecha_cambios = timestamp 'now'
--				WHERE t_precio_consolidado.id_anno_mes = tp_registro.id_anno_mes
--					AND t_precio_consolidado.id_proceso = tp_registro.id_proceso
--					AND t_precio_consolidado.id_subproceso = tp_registro.id_subproceso;
			
			RAISE NOTICE 'id_contrato:%, id_posicion:%, id_proceso:%, pxq:%, fact:%, regularizacion:%',(SELECT id_contrato FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs),
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
$$ LANGUAGE 'plpgsql';