DELETE FROM t_precio_unitario;

INSERT INTO t_precio_unitario (tipo_concepto, id_anno_mes, id_stack, id_ambito, id_proceso, pu, id_usuario, fecha_cambios)
VALUES 
('SS', 202101, 'CORPO', 'España', 'PERSONAL', 5403.70, 'Pepe', timestamp 'now'),
('TT', 202101, 'CORPO', 'España', 'PERSONAL', 280.68, 'Pepe', timestamp 'now'),
('JV', 202101, 'CORPO', 'España', 'PERSONAL', 0, 'Pepe', timestamp 'now'),
('SS', 202101, 'CORPO', 'España', 'ECOFI', 8052.97, 'Pepe', timestamp 'now'),
('TT', 202101, 'CORPO', 'España', 'ECOFI', 250.8, 'Pepe', timestamp 'now'),
('JV', 202101, 'CORPO', 'España', 'ECOFI', 0, 'Pepe', timestamp 'now'),
('SS', 202101, 'CORPO', 'España', 'COMPRAS', 4970.89, 'Pepe', timestamp 'now'),
('TT', 202101, 'CORPO', 'España', 'COMPRAS', 193, 'Pepe', timestamp 'now'),
('JV', 202101, 'CORPO', 'España', 'COMPRAS', 0, 'Pepe', timestamp 'now'),
('SS', 202102, 'CORPO', 'España', 'PERSONAL', 5403.70, 'Pepe', timestamp 'now'),
('TT', 202102, 'CORPO', 'España', 'PERSONAL', 280.68, 'Pepe', timestamp 'now'),
('JV', 202102, 'CORPO', 'España', 'PERSONAL', 0, 'Pepe', timestamp 'now'),
('SS', 202102, 'CORPO', 'España', 'ECOFI', 8052.97, 'Pepe', timestamp 'now'),
('TT', 202102, 'CORPO', 'España', 'ECOFI', 250.8, 'Pepe', timestamp 'now'),
('JV', 202102, 'CORPO', 'España', 'ECOFI', 0, 'Pepe', timestamp 'now'),
('SS', 202102, 'CORPO', 'España', 'COMPRAS', 4970.89, 'Pepe', timestamp 'now'),
('TT', 202102, 'CORPO', 'España', 'COMPRAS', 193, 'Pepe', timestamp 'now'),
('JV', 202102, 'CORPO', 'España', 'COMPRAS', 0, 'Pepe', timestamp 'now');
