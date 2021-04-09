SELECT * from t_precio_consolidado ORDER BY id_anno_mes, id_proceso
SELECT f_insercion_datos_t_precio_consolidado()
SELECT f_insercion_datos_t_facturacion();
SELECT f_insercion_datos_t_r100();
SELECT f_insercion_datos_t_qm();
SELECT f_insercion_datos_t_q100();
SELECT f_insercion_datos_t_rm()
SElect f_insercion_datos_t_precio_unitario()
DELETE FROM t_log_ejecucion
DELETE FROM t_facturacion WHERE id_anno_mes = 202104 and sec_factura = 1
SELECT fp_pxq(202104,202106)
Select to_char(sum(25.22 * 2525432.2), '999,999,999.999')
SELECT (202103)::integer
SELECT (202103)::text

select * from t_log_ejecucion
select * from t_facturacion
SELECT * FROM t_precio_consolidado where id_proceso = 'PERSONAL' ORDER BY ID_ANNO_MES, ID_SUBPROCESO

SELECT * 

SELECT fp_facturacion_regularizacion('101', '101', 202101, 202103)
SELECT fp_facturacion_0(202102, 'España', '101', '101')
SELECT fp_facturacion(1, 202105, 'España', '101', '101')
SELECT * FROM t_precio_unitario
SELECT * FROM t_q100
SELECT * FROM t_qm
SELECT * FROM t_r100
SELECT * FROM t_rm
SELECT * FROM t_factor_x

DROP TABLE t_log_ejecucion
CREATE TABLE IF NOT EXISTS t_log_ejecucion(
	id_anno_mes			Numeric(6),
	ejecucion			Text,
	contador			Serial,
	id_pais				Text,
	id_sociedad_csl		Text,
	id_proceso			Text,
	id_subproceso			Text,
	id_inductor_q			Text,
	descripcion			Text,
	id_usuario			Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno_mes, ejecucion, contador)	
);

DELETE FROM t_log_ejecucion;

INSERT INTO t_log_ejecucion (id_anno_mes, ejecucion, id_pais, id_sociedad_cls, id_proceso, id_subproceso, 
				id_inductor_q, descripcion, id_usuario, fecha_cambios) 
VALUES (202101, 'PxQ', 'España', '101', 'PERSONAL', 'Administración de Personal', 'Personal Activo', 'Descripcion', 'Jose', timestamp 'now'),
	(202101, 'PxQ', 'España', '101', 'PERSONAL', 'Bajas de Empleados', 'Personal Activo', 'Descripcion', 'Jose', timestamp 'now');
CREATE OR REPLACE FUNCTION public.fp_escribir_log_ejecucion(IN id_anno_mes numeric,IN ejecucion text,IN id_pais text,IN id_sociedad_csl text,IN id_proceso text,IN id_subproceso text,IN id_inductor_q text,IN descripcion text,IN id_usuario text)

SELECT fp_escribir_log_ejecucion (202101, 'PxQ', 'España', '101', 'PERSONAL', 'Administración de Personal', 'Personal Activo', 'Descripcion', 'Jose')
SELECT * FROM t_log_ejecucion


	OPEN c_spxq for 
		with tabla_pxq
     		as (select id_sociedad_soc_rs
			  , id_proceso
              , sum(paq) as pxq
                from t_precio_consolidado AS pxq
		 				WHERE pxq.id_anno_mes BETWEEN 202101 AND 202103 AND
							pxq.id_sociedad_soc_rs BETWEEN '101' AND '101' 	
				group by id_sociedad_soc_rs, id_proceso),
     		tabla_facturacion
     		as (select id_proceso
            	  , sum(importe) as fact
                	from t_facturacion AS fact
		 					WHERE fact.id_anno_mes BETWEEN 202101 AND 202103 AND
									fact.tipo_facturacion = 'Estimada'
                	group by id_proceso)
     		Select coalesce(tabla_pxq.id_proceso, tabla_facturacion.id_proceso) as id_proceso
				, tabla_pxq.id_sociedad_soc_rs
				, ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) as pxq  
				, ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3) as fact 
          		, ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) - ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3)  as regularizacion
				from tabla_pxq
                    	  full join tabla_facturacion on tabla_pxq.id_proceso = tabla_facturacion.id_proceso;		


select * from t_facturacion AS fact
		 					WHERE fact.id_anno_mes BETWEEN 202103 AND 202103 AND
									fact.tipo_facturacion = 'Estimada'
									
select id_proceso
            	  , sum(importe) as fact
                	from t_facturacion AS fact
		 					WHERE fact.id_anno_mes BETWEEN 202101 AND 202103 AND
									fact.tipo_facturacion = 'Estimada'
                	group by id_proceso									


		with tabla_pxq
     		as (select id_sociedad_soc_rs
			  , id_proceso
              , sum(paq) as pxq
                from t_precio_consolidado AS pxq
		 				WHERE pxq.id_anno_mes = 202103 AND -- El mes anterior a la fecha de factura (regularización)
								pxq.id_sociedad_soc_rs BETWEEN '101' AND '101' 
                group by id_sociedad_soc_rs, id_proceso),
     		tabla_facturacion
     		as (select id_proceso
            	  , sum(importe) as fact
                	from t_facturacion AS fact
		 					WHERE fact.id_anno_mes = 202103 AND -- El mes anterior a la fecha de factura (regularización)
									fact.tipo_facturacion = 'Estimada'				
                	group by id_proceso)
     		Select coalesce(tabla_pxq.id_proceso, tabla_facturacion.id_proceso) as id_proceso
				, tabla_pxq.id_sociedad_soc_rs
          		, ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) as pxq
          		, ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3) as fact
          		, ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) - ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3) as regularizacion
				, ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) + ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3) + 
					(ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) - ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3)) as estimado		
				, ROUND((((ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) + ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3) + 
					 (ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) - ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3))) * 60) / 100)::numeric,3) as res_estimado
            		from tabla_pxq
                    	  full join tabla_facturacion on tabla_pxq.id_proceso = tabla_facturacion.id_proceso;		
	


		with tabla_pxq
     		as (select id_sociedad_soc_rs
			  , id_proceso
              , sum(paq) as pxq
                from t_precio_consolidado AS pxq
		 				WHERE pxq.id_anno_mes = 202105 AND -- El mes anterior para Fact 2 actual para Fact 1
								pxq.id_sociedad_soc_rs BETWEEN '101' AND '101'
                group by id_sociedad_soc_rs, id_proceso),
     		tabla_facturacion
     		as (select id_proceso
            	  , sum(importe) as fact
                	from t_facturacion AS fact
		 					WHERE fact.id_anno_mes = 202105 AND -- El mes anterior para Fact 2 actual para Fact 1
									fact.tipo_facturacion = 'Estimada' and sec_factura = 2	 			
                	group by id_proceso)
     		Select coalesce(tabla_pxq.id_proceso, tabla_facturacion.id_proceso) as id_proceso
				, tabla_pxq.id_sociedad_soc_rs
          		, ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) as pxq
          		, ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3) as fact
				, ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) + ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3) as estimado		
				, ROUND((((ROUND(NULLIF(tabla_pxq.pxq,0)::numeric,3) + ROUND(NULLIF(tabla_facturacion.fact,0)::numeric,3)) * 60) / 100)::numeric,3) as res_estimado -- porcentaje Lean Corpo que corresponda
            		from tabla_pxq
                    	  full join tabla_facturacion on tabla_pxq.id_proceso = tabla_facturacion.id_proceso;		
	

select * from t_precio_consolidado AS pxq
		 				WHERE pxq.id_anno_mes = 202104 AND -- El mes anterior para Fact 2 actual para Fact 1
								pxq.id_sociedad_soc_rs BETWEEN '101' AND '101' 
								
select id_sociedad_soc_rs
			  , id_proceso
              , sum(paq) as pxq
                from t_precio_consolidado AS pxq
		 				WHERE pxq.id_anno_mes = 202104 AND -- El mes anterior para Fact 2 actual para Fact 1
								pxq.id_sociedad_soc_rs BETWEEN '101' AND '101'
                group by id_sociedad_soc_rs, id_proceso								
 

select * from t_facturacion AS fact
		 					WHERE fact.id_anno_mes = 202105 AND -- El mes anterior para Fact 2 actual para Fact 1
									fact.tipo_facturacion = 'Estimada'	and sec_factura = 2			
					
select id_proceso
            	  , sum(importe) as fact
                	from t_facturacion AS fact
		 					WHERE fact.id_anno_mes = 202105 AND -- El mes anterior para Fact 2 actual para Fact 1
									fact.tipo_facturacion = 'Estimada' and sec_factura = 2				
                	group by id_proceso					
					
DELETE FROM t_facturacion WHERE  sec_factura = 1 AND id_anno_mes = 202105

SELECT fp_facturacion(1,)
SELECT * FROM T_FACTURACION

SELECT * FROM T_PRECIO_UNITARIO
