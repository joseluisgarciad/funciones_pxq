DELETE FROM t_banda_1;

INSERT INTO t_banda_1 (id_proceso, id_subproceso, id_inductor_q, porc_variacion, id_usuario, fecha_cambios) 
VALUES ('PERSONAL', 'Administración de Personal', 'Transacciones / Q', 5 , 'Pepe', timestamp 'now'),
('PERSONAL', 'Bajas de Empleados', 'Terminaciones / Q', 5 , 'Pepe', timestamp 'now'),
('PERSONAL', 'Nómina y Beneficios Sociales','Nómina procesadas / Q', 5 , 'Pepe', timestamp 'now'),
('PERSONAL', 'Gestión de la Formación', 'Inscriptos en Sesiones Asistidas / Q', 5 , 'Pepe', timestamp 'now'),
('PERSONAL', 'Gestión del Talento', 'No inscriptos en ciclos / Q', 5 , 'Pepe', timestamp 'now'),
('PERSONAL', 'Servicio de Atención al Empleado', 'No Tickets / Q', 5 , 'Pepe', timestamp 'now'),
('ECOFI', 'Gestión y Contabilización de Pagos', 'Nº Pagos CSC', 5 , 'Pepe', timestamp 'now'),
('ECOFI', 'Facturación y Cobro Especial', 'Nº Facturas emitidas', 5 , 'Pepe', timestamp 'now'),
('ECOFI', 'Gestión de Medios de Pago', 'Nº Movimientos Bancarios', 5 , 'Pepe', timestamp 'now'),
('ECOFI', 'Registro y Contabilización de Albaranes y facturas', 'Nº Facturas proveedor', 5 , 'Pepe', timestamp 'now'),
('COMPRAS', 'Compras Transaccionales', 'Cantidad de Adjudicaciones', 5 , 'Pepe', timestamp 'now'),
('COMPRAS', 'Compras NO Transaccionales', 'Importe Adjudicado', 5 , 'Pepe', timestamp 'now');


DELETE FROM t_banda_2;

INSERT INTO t_banda_2 (id_proceso, id_subproceso, id_inductor_q, porc_variacion, id_usuario, fecha_cambios) 
VALUES ('PERSONAL', 'Administración de Personal', 'Transacciones / Q', 25 , 'Pepe', timestamp 'now'),
('PERSONAL', 'Bajas de Empleados', 'Terminaciones / Q', 25 , 'Pepe', timestamp 'now'),
('PERSONAL', 'Nómina y Beneficios Sociales','Nómina procesadas / Q', 25 , 'Pepe', timestamp 'now'),
('PERSONAL', 'Gestión de la Formación', 'Inscriptos en Sesiones Asistidas / Q', 25 , 'Pepe', timestamp 'now'),
('PERSONAL', 'Gestión del Talento', 'No inscriptos en ciclos / Q', 25 , 'Pepe', timestamp 'now'),
('PERSONAL', 'Servicio de Atención al Empleado', 'No Tickets / Q', 25 , 'Pepe', timestamp 'now'),
('ECOFI', 'Gestión y Contabilización de Pagos', 'Nº Pagos CSC', 25 , 'Pepe', timestamp 'now'),
('ECOFI', 'Facturación y Cobro Especial', 'Nº Facturas emitidas', 25 , 'Pepe', timestamp 'now'),
('ECOFI', 'Gestión de Medios de Pago', 'Nº Movimientos Bancarios', 25 , 'Pepe', timestamp 'now'),
('ECOFI', 'Registro y Contabilización de Albaranes y facturas', 'Nº Facturas proveedor', 25 , 'Pepe', timestamp 'now'),
('COMPRAS', 'Compras Transaccionales', 'Cantidad de Adjudicaciones', 25 , 'Pepe', timestamp 'now'),
('COMPRAS', 'Compras NO Transaccionales', 'Importe Adjudicado', 25 , 'Pepe', timestamp 'now');
