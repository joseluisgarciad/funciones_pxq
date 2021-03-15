DELETE FROM t_factor_x;

INSERT INTO t_factor_x (id_anno_mes, id_pais, id_proceso, id_subproceso, id_inductor_q, factorx, id_usuario, fecha_cambios) 
VALUES (202101, 'España', 'PERSONAL', 'Administración de Personal', 'Personal Activo', 47, 'Pepe', timestamp 'now'),
	(202101, 'España', 'PERSONAL', 'Bajas de Empleados', 'Personal Activo',35 , 'Pepe', timestamp 'now'),
	(202101, 'España', 'PERSONAL', 'Nómina y Beneficios Sociales', 'Personal Activo', 55, 'Pepe', timestamp 'now'),
	(202101, 'España', 'PERSONAL', 'Gestión de la Formación', 'Personal Activo',53 ,'Pepe', timestamp 'now'),
	(202101, 'España', 'PERSONAL', 'Gestión del Talento', 'Personal Activo',57 , 'Pepe', timestamp 'now'),
	(202101, 'España', 'PERSONAL', 'Servicio de Atención al Empleado', 'Personal Activo',60.8 , 'Pepe', timestamp 'now'),
	(202101, 'España', 'ECOFI', 'Gestión y Contabilización de Pagos', 'Nº Pagos CSC',64.6 , 'Pepe', timestamp 'now'),
	(202101, 'España', 'ECOFI', 'Facturación y Cobro Especial', 'Nº Facturas emitidas',68.4 , 'Pepe', timestamp 'now'),
	(202101, 'España', 'ECOFI', 'Gestión de Medios de Pago', 'Nº Movimientos Bancarios',72.2 , 'Pepe', timestamp 'now' ),
	(202101, 'España', 'ECOFI', 'Registro y Contabilización de Albaranes y facturas', 'Nº Facturas proveedor',76 , 'Pepe', timestamp 'now'),
	(202101, 'España', 'COMPRAS', 'Compras Transaccionales', 'Cantidad de Adjudicaciones',79.8 , 'Pepe', timestamp 'now'),
	(202101, 'España', 'COMPRAS', 'Compras NO Transaccionales', 'Importe Adjudicado',83 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'PERSONAL', 'Administración de Personal', 'Personal Activo',78 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'PERSONAL', 'Bajas de Empleados', 'Personal Activo',23 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'PERSONAL', 'Nómina y Beneficios Sociales', 'Personal Activo',66 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'PERSONAL', 'Gestión de la Formación', 'Personal Activo',76 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'PERSONAL', 'Gestión del Talento', 'Personal Activo',12 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'PERSONAL', 'Servicio de Atención al Empleado', 'Personal Activo',43.8 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'ECOFI', 'Gestión y Contabilización de Pagos', 'Nº Pagos CSC',35.6 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'ECOFI', 'Facturación y Cobro Especial', 'Nº Facturas emitidas',65.4 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'ECOFI', 'Gestión de Medios de Pago', 'Nº Movimientos Bancarios',71.4 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'ECOFI', 'Registro y Contabilización de Albaranes y facturas', 'Nº Facturas proveedor',75 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'COMPRAS', 'Compras Transaccionales', 'Cantidad de Adjudicaciones',23 , 'Pepe', timestamp 'now'),
	(202102, 'España', 'COMPRAS', 'Compras NO Transaccionales', 'Importe Adjudicado',45 , 'Pepe', timestamp 'now');
