DELETE FROM t_facturacion;

INSERT INTO t_facturacion (tipo_facturacion, tipo_coste, sec_factura, id_anno_mes, tipo_documento, id_contrato, id_posicion, id_proceso, 
								  concepto, cantidad, importe, denominacion, id_usuario, fecha_cambios) 
VALUES ('Estimada', 'Variable', 1, 202101, 'LV', '15ACONT1', 3, 'ECOFI', 'Concepto de Facturacion Ec1', 1, 300, 'Concepto de Facturacion Ec1Enero2021', 'Jose', timestamp 'now'),
		('Estimada', 'Variable', 2, 202101, 'LV', '15ACONT1', 3, 'ECOFI', 'Concepto de Facturacion Ec2', 1, 150, 'Concepto de Facturacion Ec2Enero2021', 'Jose', timestamp 'now'),
		('Estimada', 'Variable', 1, 202101, 'LV', '15ACONT1', 3, 'PERSONAL', 'Concepto de Facturacion Pe1', 1, 350, 'Concepto de Facturacion Pe1Enero2021', 'Jose', timestamp 'now'),
		('Estimada', 'Variable', 2, 202101, 'LV', '15ACONT1', 3, 'PERSONAL', 'Concepto de Facturacion Pe2', 1, 275, 'Concepto de Facturacion Pe2Enero2021', 'Jose', timestamp 'now'),
		('Estimada', 'Variable', 1, 202101, 'LV', '15ACONT1', 3, 'COMPRAS', 'Concepto de Facturacion Co1', 1, 150, 'Concepto de Facturacion Co1Enero2021', 'Jose', timestamp 'now'),
 		('Estimada', 'Variable', 2, 202101, 'LV', '15ACONT1', 3, 'COMPRAS', 'Concepto de Facturacion Co2', 1, 60, 'Concepto de Facturacion Co2Enero2021', 'Jose', timestamp 'now'),
		('Estimada', 'Variable', 1, 202102, 'LV', '15ACONT1', 3, 'ECOFI', 'Concepto de Facturacion Ec1', 1, 275, 'Concepto de Facturacion Ec1Enero2021', 'Jose', timestamp 'now'),
		('Estimada', 'Variable', 2, 202102, 'LV', '15ACONT1', 3, 'ECOFI', 'Concepto de Facturacion Ec2', 1, 125, 'Concepto de Facturacion Ec2Enero2021', 'Jose', timestamp 'now'),
		('Estimada', 'Variable', 1, 202102, 'LV', '15ACONT1', 3, 'PERSONAL', 'Concepto de Facturacion Pe1', 1, 400, 'Concepto de Facturacion Pe1Enero2021', 'Jose', timestamp 'now'),
		('Estimada', 'Variable', 2, 202102, 'LV', '15ACONT1', 3, 'PERSONAL', 'Concepto de Facturacion Pe2', 1, 215, 'Concepto de Facturacion Pe2Enero2021', 'Jose', timestamp 'now'),
		('Estimada', 'Variable', 1, 202102, 'LV', '15ACONT1', 3, 'COMPRAS', 'Concepto de Facturacion Co1', 1, 160, 'Concepto de Facturacion Co1Enero2021', 'Jose', timestamp 'now'),
 		('Estimada', 'Variable', 2, 202102, 'LV', '15ACONT1', 3, 'COMPRAS', 'Concepto de Facturacion Co2', 1, 30, 'Concepto de Facturacion Co2Enero2021', 'Jose', timestamp 'now');
