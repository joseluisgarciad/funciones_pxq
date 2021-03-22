DELETE FROM t_cargos_fijos;

INSERT INTO t_cargos_fijos (id_cargo_servicio, descripcion, id_usuario, fecha_cambios) 
VALUES('01', 'Cargo Servicio BAP', 'Pepe', timestamp 'now'),
	('02', 'Cargo Fijo por los Servicios de Soporte a Proyectos (Cargo OPEX)', 'Pepe', timestamp 'now'),
	('03', 'Cargo por amortización de los costes de transición y transformación a cargo del Proveedor', 'Pepe', timestamp 'now'),
	('04', 'Cargos por regularizacion trimestral de la facturacion del componente de Servicio', 'Pepe', timestamp 'now'),
	('05', 'Cargo por Proyectos de renovación tecnológica', 'Pepe', timestamp 'now'),
	('06', 'Cargo de Evolutivos y Proyectos de Demanda de Negocio (Cargo CAPEX)', 'Pepe', timestamp 'now'),
	('07', 'Cargos por otros costes de los servicios', 'Pepe', timestamp 'now'),
	('08', 'Cargos por overhead', 'Pepe', timestamp 'now'),
	('09', 'Cargo por travel pass through', 'Pepe', timestamp 'now'),
	('10', 'WHT  Witholding Taxes', 'Pepe', timestamp 'now');

