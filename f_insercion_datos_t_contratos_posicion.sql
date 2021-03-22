DELETE FROM t_contratos_posicion;

INSERT INTO t_contratos_posicion (id_sociedad_soc_rs, id_contrato, id_posicion, id_usuario, fecha_cambios) 
VALUES ('100', '15ACONT0', 4, 'Jose', timestamp 'now'),
		('101', '30ACONT1', 3, 'Jose', timestamp 'now'),
		('102', '40ACONT4', 6, 'Jose', timestamp 'now');
