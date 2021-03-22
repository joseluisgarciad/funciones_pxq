CREATE OR REPLACE FUNCTION public.fp_facturacion_1(IN id_anno_mes_desde numeric DEFAULT 0,IN id_anno_mes_hasta numeric DEFAULT  999999,IN id_pais text DEFAULT  'España'::text,IN id_sociedad_soc_rs_desde text DEFAULT  '0'::text,IN id_sociedad_soc_rs_hasta text DEFAULT  '9999999'::text)

DECLARE
	tp_registro RECORD;
	tp_registro_out RECORD;
	v_fact text;
	v_pos integer;
	v_tipo_factura text;
	c_spxq refcursor;
	v_tipo_documento_fact text;
	v_lean_Corpo_1 integer;
	v_lean_Corpo_2 integer;	
	v_concepto_fact text;
	v_tipo_coste text;
BEGIN

	v_tipo_factura := 'Estimada';
	v_lean_Corpo_1 := 60;
	v_lean_Corpo_2 := 40;
	v_tipo_documento_fact := 'LV';
	v_concepto_fact := 'Concepto de Facturacion ???';
	v_tipo_coste := 'Variable';
	
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
				, NULLIF(tabla_pxq.pxq,0) + NULLIF(tabla_facturacion.fact,0) + (NULLIF(tabla_pxq.pxq,0) - NULLIF(tabla_facturacion.fact,0)) as estimado		
				, ((NULLIF(tabla_pxq.pxq,0) + NULLIF(tabla_facturacion.fact,0) + (NULLIF(tabla_pxq.pxq,0) - NULLIF(tabla_facturacion.fact,0))) * v_lean_Corpo_1) / 100 as res_estimado				
            		from tabla_pxq
                    	  full join tabla_facturacion on tabla_pxq.id_proceso = tabla_facturacion.id_proceso;		
	
	FETCH c_spxq into tp_registro;
		While (FOUND) Loop
			--v_fact := SELECT id_factura FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs;
			--v_pos := SELECT id_posicion FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs;			
			RAISE NOTICE 'v_fact%',v_fact;
			RAISE NOTICE 'v_pos%',v_pos;			
			INSERT INTO t_facturacion (tipo_facturacion, tipo_coste, sec_factura, id_anno_mes, tipo_documento, id_contrato, id_posicion, id_proceso, 
								  concepto, cantidad, importe, denominacion, id_usuario, fecha_cambios) 
				VALUES (v_tipo_factura, v_tipo_coste, 1, 202104, v_tipo_documento_fact, 
										(SELECT id_contrato FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs),
										(SELECT id_posicion FROM t_contratos_posicion WHERE id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs)::integer,
										tp_registro.id_proceso, v_concepto_fact, 1, tp_registro.res_estimado, 'Concepto de Facturacion 1Abril2021', 'Jose', timestamp 'now');

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