CREATE OR REPLACE FUNCTION public.fp_pxq(IN fec_desde numeric,IN fec_hasta numeric)

DECLARE
	tp_registro RECORD;
	tp_registro_out RECORD;
	v_factorx float;
	v_ratio float;
	v_pu float;
	v_paq float;
	v_par float;
	v_stack text;
	v_tipo_dato text;
	v_tipo_concepto text;
	v_pais text;
	v_b1 float;
	v_b2 float;
	v_q100 float;
	v_qm float;
	v_rm float;	
	v_r100 float;
	v_cal numeric;
	v_cal2 numeric;
	v_bool1 boolean;
	v_bool2 boolean;
	v_escalon float;
	v_par_b1 numeric(2);
	v_par_b2 numeric(2);
	v_par_b3 numeric(2);	
	c_spxq cursor for select * from t_precio_consolidado
		Where t_precio_consolidado.id_anno_mes BETWEEN $1 AND $2;
		/*AND t_precio_consolidado.id_stack = $3 AND
			  t_precio_consolidado.id_sociedad_csl = $4 AND t_precio_consolidado.id_sociedad_soc_rs = $5 AND
			  t_precio_consolidado.id_proceso = $6 AND t_precio_consolidado.id_subproceso = $5; */

BEGIN
	v_stack := 'CORPO';
	v_tipo_concepto := 'SS';
	v_pais := 'España';
	v_factorx := 25;
	v_par_b1 := 10;
	v_par_b2 := 20;
	v_par_b3 := 25;
	
	OPEN c_spxq;
	FETCH c_spxq into tp_registro;
		While (FOUND) Loop
		----------------------------------------------
		-- Recuperación de datos de calculo de BBDD --
		----------------------------------------------
			v_b1 := (SELECT porc_variacion FROM t_banda_1 WHERE id_proceso = tp_registro.id_proceso AND id_subproceso = tp_registro.id_subproceso);
			v_b2 := (SELECT porc_variacion FROM t_banda_2 WHERE id_proceso = tp_registro.id_proceso AND id_subproceso = tp_registro.id_subproceso);

			v_pu := (SELECT pu FROM t_precio_unitario WHERE tipo_concepto = v_tipo_concepto AND id_anno_mes = tp_registro.id_anno_mes AND 
					 				                         id_stack = v_stack AND id_ambito = v_pais AND id_proceso = tp_registro.id_proceso);

			v_q100 := (SELECT q_100 FROM t_q100 WHERE id_anno_mes = tp_registro.id_anno_mes AND id_sociedad_csl = tp_registro.id_sociedad_csl AND
								                       id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs AND id_stack = tp_registro.id_stack AND
								                       id_proceso = tp_registro.id_proceso AND id_subproceso = tp_registro.id_subproceso);

			v_qm := (SELECT q_m FROM t_qm WHERE id_anno_mes = tp_registro.id_anno_mes AND id_sociedad_csl = tp_registro.id_sociedad_csl AND
							                     id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs AND id_stack = tp_registro.id_stack AND
							                     id_proceso = tp_registro.id_proceso AND id_subproceso = tp_registro.id_subproceso);

			v_r100 := (SELECT r_100 FROM t_r100 WHERE id_anno_mes = tp_registro.id_anno_mes AND id_stack = tp_registro.id_stack AND 
					                                  id_pais = v_pais AND id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs AND
								                      id_proceso = tp_registro.id_proceso AND  id_subproceso = tp_registro.id_subproceso);

			v_rm := (SELECT r_m FROM t_rm WHERE id_anno_mes = tp_registro.id_anno_mes AND id_stack = tp_registro.id_stack AND 
					                             id_pais = v_pais AND id_sociedad_soc_rs = tp_registro.id_sociedad_soc_rs AND
							                     id_proceso = tp_registro.id_proceso AND  id_subproceso = tp_registro.id_subproceso);
								
			
			----------------------------------
			-------   CALCULO DE PaQ   -------
			----------------------------------
			--______________________________
					v_q100 = 10000;
					v_qm = 10600;
					v_pu = 100;
			--______________________________
			
			v_cal := ((v_q100 - v_qm) / v_q100) * 100;
			if v_cal < 0 THEN v_cal := v_cal * -1; END IF;
			RAISE NOTICE '-------------- %, %, %, %, % ', tp_registro.id_anno_mes, tp_registro.id_sociedad_csl, tp_registro.id_sociedad_soc_rs, tp_registro.id_proceso, tp_registro.id_subproceso;
			v_bool1 := v_cal >= v_b1 - 1;
            v_bool2 := v_cal <= v_b1 + 1;
			
			if (v_cal >= v_b1) AND (v_cal <= v_b1) THEN   -- Dentro de B1
				RAISE NOTICE 'A - v_cal %', v_cal;
				v_paq := v_pu ;	
			else
				if (v_cal >= v_b1 - 1) AND (v_cal <= v_b1 + 1) THEN  -- Dentro de B1 con escalón
				RAISE NOTICE 'B - v_cal %', v_cal;				
					IF ((v_q100 - v_qm ) / v_qm) < 0 THEN
					    v_paq = v_pu * ( 1 - abs((v_q100 - v_qm ) / v_qm) * (v_factorx / 100) * (( abs(v_q100 - v_qm) / v_q100) - 0.04) / 0.02);
					else
						v_paq = v_pu * ( 1 + ((v_q100 - v_qm ) / v_qm) * (v_factorx / 100) * (((v_q100 - v_qm) / v_q100) - 0.04) / 0.02);
					END IF;					
				else
					if v_cal < v_b2 THEN -- Entre B1 y B2 (sin escalón)
						RAISE NOTICE 'C - v_cal %', v_cal;					
						IF ((v_q100 - v_qm ) / v_qm) < 0 THEN
							v_paq = v_pu * ( 1 - abs((v_q100 - v_qm ) / v_qm) * (v_factorx / 100));
						else
							v_paq = v_pu * ( 1 + ((v_q100 - v_qm ) / v_qm) * (v_factorx / 100));
						END IF;							
					else 
						if v_cal >= v_b2 THEN -- Dentro de Banda 2 (o superior a ella) - Renegociar contrato
							RAISE NOTICE 'Fuera de b2 %, renegociar contrato ',v_b2;
						END IF;
					end if;
				end if;
			end if;	
			RAISE NOTICE ' v_paq %', v_paq;
										
			----------------------------------
			-------   CALCULO DE PaR   -------
			----------------------------------
			--______________________________
					v_paq = 100;
					v_factorx = 30;
					v_r100 = 10;
					v_rm = 8;
			--______________________________						
			v_cal := ((v_r100 - v_rm) / v_r100) * 100;
			if v_cal < 0 THEN v_cal := v_cal * -1; END IF;

			if v_cal < v_par_b1 THEN   -- Dentro de v_par_b1  (¿¿ Menor o Menor/igual ??)
				RAISE NOTICE 'A - v_cal %', v_cal;
				v_par := v_paq ;	
			else
				if (v_cal >= v_par_b1) AND (v_cal <= v_par_b2) THEN  -- Dentro de B1 y B2 con escalón
					RAISE NOTICE 'B - v_cal %', v_cal;
					RAISE NOTICE '((v_rm - v_r100 ) / v_r100) CONDICION : %', ((v_rm - v_r100 ) / v_r100);
					IF ((v_rm - v_r100 ) / v_r100) < 0 THEN
					    v_par = v_paq * ( 1 - abs((v_rm - v_r100 ) / v_r100) * ((abs(v_rm - v_r100) / v_r100) - 0.1) / 0.1  * (1 - (v_factorx / 100)));
					else
						v_par = v_paq * ( 1 + (abs(v_rm - v_r100 ) / v_r100) * (abs(v_rm - v_r100) / v_r100) - 0.1 / 0.1  * (1 - (v_factorx / 100))); --aa
					END IF;					
				else
					if v_cal >= v_par_b3 and v_cal <= v_par_b3 THEN -- Dentro del rango 
						RAISE NOTICE 'C - v_cal %', v_cal;					
						IF ((v_r100 - v_rm ) / v_rm) < 0 THEN
							v_par = v_paq * ( 1 - abs((v_rm - v_r100 ) / v_r100) * (1 - (v_factorx / 100)));
						else
							v_par = v_paq * ( 1 + abs((v_rm - v_r100 ) / v_r100) * (1 - (v_factorx / 100)));
						END IF;							
					end if;
				end if;
			end if;	
			RAISE NOTICE ' v_par %', v_par;
			

			UPDATE t_precio_consolidado
				SET paq = v_paq, par = v_par, id_usuario = 'Jose', fecha_cambios = timestamp 'now'
				WHERE t_precio_consolidado.id_anno_mes = tp_registro.id_anno_mes
					AND t_precio_consolidado.id_proceso = tp_registro.id_proceso
					AND t_precio_consolidado.id_subproceso = tp_registro.id_subproceso;
			
			RAISE NOTICE 'v_paq es --%', v_paq;
			RAISE NOTICE 'v_par es --%', v_par;
			
			FETCH c_spxq into tp_registro;
		END Loop;
		Close c_spxq;
		return tp_registro;
--	FOR registro_out IN SELECT * FROM public."T_SPxQ"
--			Where "T_SPxQ".anomes BETWEEN $1 AND $2
--		LOOP
--			RETURN NEXT registro_out;
--		END LOOP;
--		RETURN;
	EXCEPTION
    	WHEN division_by_zero THEN
        	RAISE NOTICE 'division_by_zero';
    	when others then
        	RAISE INFO 'Error Name:%', SQLERRM;
        	RAISE INFO 'Error State:%', SQLSTATE;
        	return -1;			
END;
$$ LANGUAGE 'plpgsql';
