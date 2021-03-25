CREATE OR REPLACE FUNCTION public.fp_facturacion_1(IN id_anno_mes numeric DEFAULT 0,IN id_pais text DEFAULT  'España'::text,IN id_sociedad_soc_rs_desde text DEFAULT  '0'::text,IN id_sociedad_soc_rs_hasta text DEFAULT  '9999999'::text) AS $$

DECLARE
	tp_registro RECORD;
	tp_registro_out RECORD;
	v_usuario text;
	v_fact text;
	v_pos integer;
	v_tipo_factura text;
	c_spxq refcursor;
	v_tipo_documento_fact text;
	v_lean_Corpo_1 integer;
	v_lean_Corpo_2 integer;	
	v_concepto_fact text;
	v_tipo_coste text;
	v_concatena_fecha text;
	v_mes_regularizacion integer;
	v_anno_factura integer;	
	v_mes_letra_factura text;
	v_fecha_regularizacion text;
BEGIN
	v_usuario := 'Jose';
	v_tipo_factura := 'Estimada';
	v_lean_Corpo_1 := 60;
	v_lean_Corpo_2 := 40;
	v_tipo_documento_fact := 'LV';
	v_concepto_fact := 'Concepto de Facturacion ???';
	v_tipo_coste := 'Variable';
	
	---
	
	-- se formatea la fecha completa para poder tratarla
	v_concatena_fecha := (SELECT concat(id_anno_mes, '01'));  	
	 -- se resta 1 mes a la fecha para acceder a la regularización y PxQ del mes anterior
	v_fecha_regularizacion := (SELECT to_char(((v_concatena_fecha::date) - INTERVAL '1 month')::date, 'YYYYMM')); 
	RAISE NOTICE 'MES , v_fecha_regularizacion-%, ',v_fecha_regularizacion;
	

	v_mes_letra_factura := (SELECT to_char(concat(id_anno_mes, '01')::date, 'TMMonth'));   -- extrae mes en letra, 'MM' si quisiera en numero
	v_anno_factura = (SELECT to_char(concat(id_anno_mes, '01')::date , 'YYYY')::integer);
	
	---
	
	RAISE NOTICE 'v_anno_factura%',v_anno_factura;
	RAISE NOTICE 'v_mes_letra_factura%',v_mes_letra_factura;
	
	OPEN c_spxq for 
		with tabla_pxq
     		as (select id_sociedad_soc_rs
			  , id_proceso
              , sum(paq) as pxq
                from t_precio_consolidado AS pxq
		 				WHERE pxq.id_anno_mes = v_fecha_regularizacion::integer AND -- El mes anterior a la fecha de factura (regularización)
								pxq.id_sociedad_soc_rs BETWEEN id_sociedad_soc_rs_desde AND id_sociedad_soc_rs_hasta 
                group by id_sociedad_soc_rs, id_proceso),
     		tabla_facturacion
     		as (select id_proceso
            	  , sum(importe) as fact
                	from t_facturacion AS fact
		 					WHERE fact.id_anno_mes = v_fecha_regularizacion::integer AND -- El mes anterior a la fecha de factura (regularización)
									fact.tipo_facturacion = v_tipo_factura				
                	group by id_proceso)
     		Select coalesce(tabla_pxq.id_proceso, tabla_facturacion.id_proceso) as id_proceso
				, tabla_pxq.id_sociedad_soc_rs
          		, tabla_pxq.pxq
          		, tabla_facturacion.fact
          		, ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,2) - ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,2) as regularizacion
				, ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,2) + ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,2) + 
					(ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,2) - ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,2)) as estimado		
				, ROUND((((ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,2) + ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,2) + 
					 (ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,2) - ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,2))) * v_lean_Corpo_1) / 100)::numeric,2) as res_estimado
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
										tp_registro.id_proceso, v_concepto_fact, 1, tp_registro.res_estimado, 
										(select concat(v_concepto_fact, v_mes_letra_factura, v_anno_factura)), v_usuario, timestamp 'now');

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