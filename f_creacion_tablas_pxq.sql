CREATE TABLE IF NOT EXISTS t_pais(
	id_pais 				Text,
	region_geo 				Text,
	id_usuario 				Varchar,
	fecha_cambios 			Timestamp,
	PRIMARY KEY (id_pais)
);

CREATE TABLE IF NOT EXISTS t_ambito(
	id_pais					Text,
	id_ambito 				Text,
	divisa					Text,    -- Pendiente de revisión
	tipo_cambio				Text,    -- Pendiente de revisión
	id_usuario 				Text,
	fecha_cambios 			Timestamp,
	PRIMARY KEY (id_pais, id_ambito)
);

CREATE TABLE IF NOT EXISTS t_sociedades_csl(
	id_ambito 				Text,
	id_pais					Text,
	id_sociedad_cls			Text,
	desc_sociedad_cls		Text,
	id_pais_soc_rs			Text,
	id_sociedad_soc_rs		Text,
	desc_sociedad_soc_rs	Text,
	receptora_factura		Varchar(2), -- SI o NO
	aclaraciones			Text,
	seg_op_ecofin			Text,
	resp_ecofin				Text,
	seg_op_compras			Text,
	resp_compras			Text,
	seg_op_personas			Text,
	resp_personas			Text,
	cambios					Text,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_ambito, id_pais, id_sociedad_cls)	
);


CREATE TABLE IF NOT EXISTS t_inductores_q(
	id_stack				Text,
	inductor_q				Text,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_stack, inductor_q)	
);

CREATE TABLE IF NOT EXISTS t_ratio_control_corpo(
	id_stack				Text,
	inductor_q				Text,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_stack, inductor_q)	
);

CREATE TABLE IF NOT EXISTS t_procesos_servicios(
	id_stack				Text,
	id_proceso				Text,
	id_subproceso			Text,
	descripcion				Text,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_stack, id_proceso, id_subproceso)
);

-- Tabla pendiente de Revisión

CREATE TABLE IF NOT EXISTS t_cargos_fijos(
	id_cargo_servicio		Text,
	descripcion				Text,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_cargo_servicio)
);

/* 
NO ES NECESARIA A PRIORI

CREATE TABLE IF NOT EXISTS t_precios(
	id_anno					Varchar(4),
	id_pais					Text,
	id_proceso				Text,
	tipo_cargo				Text,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno, id_pais, id_proceso)
);

NO ES NECESARIA A PRIORI
CREATE TABLE IF NOT EXISTS t_reparto_pais_ps(
	id_anno					Varchar(4),
	id_stack				Text,
	id_pais					Text,
	id_proceso				Text,
	id_subproceso			Text,
	id_inductor_q			Text,
	porc_reparto			float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno, id_stack, id_pais, id_proceso)
);
*/

-- Tabla pendiente de Revisión

CREATE TABLE IF NOT EXISTS t_reparto_cargos_fijos(
	id_anno					Numeric(4),
	id_stack				Text,
	id_pais					Text,
	id_sociedad_csl			Text,
	id_sociedad				Text,
	id_proceso				Text,
	importe					float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno, id_stack, id_pais, id_sociedad_csl, id_sociedad, id_proceso)	
);

-- Tabla pendiente de Revisión

CREATE TABLE IF NOT EXISTS t_eficiencias(
	id_anno					Numeric(4),
	id_pais					Text,
	id_proceso				Text,
	-- id_subproceso		Text,  Pendiente de revisión
	porc_eficiencia			float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno, id_pais, id_proceso)	
);

CREATE TABLE IF NOT EXISTS t_contratos_posicion(
	id_sociedad_soc_rs		Text,
	id_contrato				Text,
	id_posicion				Text,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_sociedad_soc_rs, id_contrato, id_posicion)
);

CREATE TABLE IF NOT EXISTS t_q100(
	id_anno_mes				Numeric(6),
	id_sociedad_csl			Text,
	id_sociedad_soc_rs		Text,
	id_stack				Text,
	id_proceso				Text,
	id_subproceso			Text,
	q_principal				Text,
	q_100					Decimal,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno_mes, id_sociedad_csl, id_sociedad_soc_rs, id_stack, id_proceso, id_subproceso)
);

CREATE TABLE IF NOT EXISTS t_q100_sim(
	id_usuario_sim			Text,
	id_anno_mes				Numeric(6),
	id_sociedad_csl			Text,
	id_sociedad_soc_rs		Text,
	id_stack				Text,
	id_proceso				Text,
	id_subproceso			Text,
	q_principal				Text,
	q_100					Decimal,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_usuario_sim, id_anno_mes, id_sociedad_csl, id_sociedad_soc_rs, id_stack, id_proceso, id_subproceso)
);


CREATE TABLE IF NOT EXISTS t_qm(
	id_anno_mes				Numeric(6),
	id_sociedad_csl			Text,
	id_sociedad_soc_rs		Text,
	id_stack				Text,
	id_proceso				Text,
	id_subproceso			Text,
	q_principal				Text,
	q_m						Decimal,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno_mes, id_sociedad_csl, id_sociedad_soc_rs, id_stack, id_proceso, id_subproceso)
	
);

CREATE TABLE IF NOT EXISTS t_qm_sim(
	id_usuario_sim			Text,
	id_anno_mes				Numeric(6),
	id_sociedad_csl			Text,
	id_sociedad_soc_rs		Text,
	id_stack				Text,
	id_proceso				Text,
	id_subproceso			Text,
	q_principal				Text,
	q_m						Decimal,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_usuario_sim, id_anno_mes, id_sociedad_csl, id_sociedad_soc_rs, id_stack, id_proceso, id_subproceso)
	
);


CREATE TABLE IF NOT EXISTS t_r100(
	id_anno_mes				Numeric(6),
	id_stack				Text,
	id_pais					Text,
	id_sociedad_soc_rs		Text,
	id_proceso				Text,
	id_subproceso			Text,
	q_principal_ratio		Text,
	r_100					Decimal,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno_mes, id_stack, id_pais, id_sociedad_soc_rs, id_proceso, id_subproceso)
	
);

CREATE TABLE IF NOT EXISTS t_r100_sim(
	id_usuario_sim			Text,
	id_anno_mes				Numeric(6),
	id_stack				Text,
	id_pais					Text,
	id_sociedad_soc_rs		Text,
	id_proceso				Text,
	id_subproceso			Text,
	q_principal_ratio		Text,
	r_100					Decimal,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_usuario_sim, id_anno_mes, id_stack, id_pais, id_sociedad_soc_rs, id_proceso, id_subproceso)
	
);


CREATE TABLE IF NOT EXISTS t_rm(
	id_anno_mes				Numeric(6),
	id_pais					Text,
	id_stack				Text,
	id_sociedad_soc_rs		Text,
	id_proceso				Text,
	id_subproceso			Text,
	q_principal_ratio		Text,
	r_m						Decimal,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno_mes, id_pais, id_stack, id_sociedad_soc_rs, id_proceso, id_subproceso)	
);

CREATE TABLE IF NOT EXISTS t_rm_sim(
	id_usuario_sim			Text,
	id_anno_mes				Numeric(6),
	id_pais					Text,
	id_stack				Text,
	id_sociedad_soc_rs		Text,
	id_proceso				Text,
	id_subproceso			Text,
	q_principal_ratio		Text,
	r_m						Decimal,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno_mes, id_pais, id_stack, id_sociedad_soc_rs, id_proceso, id_subproceso)	
);


-- Tabla pendiente de Revisión

CREATE TABLE IF NOT EXISTS t_precio_unitario(
	tipo_concepto			Varchar(2),	
	id_anno_mes				Numeric(6),
	id_stack				Text,
	id_ambito 				Text,
	id_proceso				Text,
	id_subproceso			Text,
	q_principal				Text,
	pu						float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (tipo_concepto, id_anno_mes, id_stack, id_ambito, id_proceso)	
	
);

CREATE TABLE IF NOT EXISTS t_precio_unitario_sim(
	id_usuario_sim			Text,
	tipo_concepto			Varchar(2),	
	id_anno_mes				Numeric(6),
	id_stack				Text,
	id_ambito 				Text,
	id_proceso				Text,
	id_subproceso			Text,
	q_principal				Text,
	pu						float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_usuario_sim, tipo_concepto, id_anno_mes, id_stack, id_ambito, id_proceso)	
	
);


CREATE TABLE IF NOT EXISTS t_banda_1(
	id_proceso				Text,
	id_subproceso			Text,	
	id_inductor_q			Text,
	porc_variacion			float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_proceso, id_subproceso)
);

CREATE TABLE IF NOT EXISTS t_banda_2(
	id_proceso				Text,
	id_subproceso			Text,	
	id_inductor_q			Text,
	porc_variacion			float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_proceso, id_subproceso)			
);

CREATE TABLE IF NOT EXISTS t_banda_1_sim(
	id_usuario_sim			Text,	
	id_proceso				Text,
	id_subproceso			Text,	
	id_inductor_q			Text,
	porc_variacion			float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_usuario_sim ,id_proceso , id_subproceso)
);

CREATE TABLE IF NOT EXISTS t_banda_2_sim(
	id_usuario_sim			Text,	
	id_proceso				Text,
	id_subproceso			Text,	
	id_inductor_q			Text,
	porc_variacion			float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_usuario_sim, id_proceso, id_subproceso)			
);


CREATE TABLE IF NOT EXISTS t_factor_x(
	id_anno_mes				Numeric(6),
	id_pais					Text,
	id_proceso				Text,
	id_subproceso			Text, 
	id_inductor_q			Text,
	factorx					float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno_mes, id_pais, id_proceso, id_subproceso)	

);

CREATE TABLE IF NOT EXISTS t_factor_x_sim(
	id_usuario_sim			Text,	
	id_anno_mes				Numeric(6),
	id_pais					Text,
	id_proceso				Text,
	id_subproceso			Text,  
	id_inductor_q			Text,
	factorx					float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_usuario_sim, id_anno_mes, id_pais, id_proceso, id_subproceso)	

);

CREATE TABLE IF NOT EXISTS t_precio_consolidado(
	id_anno_mes				Numeric(6),
	id_stack				Text,
	id_sociedad_csl			Text,
	id_sociedad_soc_rs		Text,
	id_proceso				Text,
	id_subproceso			Text,
	id_inductor_q			Text,
	r_100					float,
	paq						float,
	par						float,	
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno_mes, id_stack, id_sociedad_csl, id_sociedad_soc_rs, id_proceso, id_subproceso)	
	
);

CREATE TABLE IF NOT EXISTS t_precio_consolidado_sim(
	id_usuario_sim			Text,
	id_anno_mes				Numeric(6),
	id_stack				Text,
	id_sociedad_csl			Text,
	id_sociedad_soc_rs		Text,
	id_proceso				Text,
	id_subproceso			Text,
	id_inductor_q			Text,
	r_100					float,
	paq						float,
	par						float,	
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_usuario_sim, id_anno_mes, id_stack, id_sociedad_csl, id_sociedad_soc_rs, id_proceso, id_subproceso)	
	
);

CREATE TABLE IF NOT EXISTS t_precio_overhead(
	id_anno_mes				Numeric(6),
	id_stack				Text,
	id_sociedad_csl			Text,
	id_sociedad_soc_rs		Text,
	id_proceso				Text,
	id_subproceso			Text,
	id_inductor_q			Text,
	r_100					float,
	cantidad				float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno_mes, id_stack, id_sociedad_csl, id_sociedad_soc_rs, id_proceso, id_subproceso)	
	
);

CREATE TABLE IF NOT EXISTS t_precio_overhead_sim(
	id_anno_mes				Numeric(6),
	id_stack				Text,
	id_sociedad_csl			Text,
	id_sociedad_soc_rs		Text,
	id_proceso				Text,
	id_subproceso			Text,
	id_inductor_q			Text,
	r_100					float,
	cantidad				float,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno_mes, id_stack, id_sociedad_csl, id_sociedad_soc_rs, id_proceso, id_subproceso)	
	
);

CREATE TABLE IF NOT EXISTS t_periodos(
	id_anno_mes				Numeric(6),
	id_stack				Text,
	id_sociedad_csl			Text,
	id_proceso				Text,
	tipo_dato				Varchar(4),  -- Real/Simu
	flag_proceso			Varchar(2), 
	flag_factura			Varchar(2),  -- ¿Es valido? -- Flag Factura (Si/No) o (1/2)
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY(id_proceso, tipo_dato)
);

CREATE TABLE IF NOT EXISTS t_usuarios_permisos(
	id_usuario				Text, -- Cuidado con primary key por el tipo de permisos que pueda tener
	id_stack				Text,
	id_pais					Text,
	id_ambito				Text,
	id_sociedad_csl			Text,	
	id_proceso				Text,
	rol						Text,
	id_usuario				Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_usuario) -- ¿?¿?
);

CREATE TABLE IF NOT EXISTS t_log_ejecucion(
	id_anno_mes			Numeric(6),
	ejecucion			Text,
	contador			Serial,
	id_pais				Text,
	id_sociedad_cls			Text,
	id_proceso			Text,
	id_subproceso			Text,
	id_inductor_q			Text,
	descripcion			Text,
	id_usuario			Text,
	fecha_cambios			Timestamp,
	PRIMARY KEY (id_anno_mes, ejecucion, contador)	
);


CREATE TABLE IF NOT EXISTS t_facturacion(
	tipo_facturacion		Text,   --Tipo Factura (Fija, Estimada, Regularización)ç
	tipo_coste				Text,   --TT, JV, Overhead, travel, Factura plus, Otros costes de operación, variable
	sec_factura				Integer,
	id_anno_mes				Numeric(6),
	tipo_documento			Text,
	contrato				Text,
	posicion				Integer,
	id_proceso				Text,
	concepto				Text,
	cantidad				float,
	importe					float,
	denominacion			Text,
	id_usuario				Text,
	fecha_cambios			Timestamp
);

CREATE TABLE IF NOT EXISTS t_simulacion(
	id_anno_mes				Numeric(6),
	contrato				Text,
	posicion				Integer,
	id_sociedad_csl			Text,
	id_sociedad_soc_rs		Text,
	id_proceso				Text,
	id_subproceso			Text,
	id_inductor_q			Text,
	cantidad				float,
	importe					float,
	denominacion			Text,
	id_usuario				Text,
	fecha_cambios			Timestamp
);
