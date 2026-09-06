-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- PASO A.5: Pruebas obligatorias (permitido/denegado)
-- IMPORTANTE: cada bloque se ejecuta CONECTADO como el usuario
-- indicado, no como superusuario/admin. Ejemplo de conexión:
--   psql -h localhost -U APP_USER_1_EP1_EQUIPO_09 -d db_ep1_equipo_09
-- Después de CADA línea, toma una captura del resultado (o del
-- error) y guárdala en /evidencias con nombre descriptivo.
-- =====================================================

-- ############################################
-- # Conectado como APP_USER_1_EP1_EQUIPO_09  #
-- ############################################

-- Puede hacer SELECT a las 3 tablas y a la vista (esperado: OK)
SELECT * FROM "CLASE_MOV_EP1_EQUIPO_09";
SELECT * FROM "CENTROS_EP1_EQUIPO_09";
SELECT * FROM "MOV_EP1_EQUIPO_09";
SELECT * FROM "VW_RESUMEN_MOVIMIENTOS_EP1_EQUIPO_09";

-- Intento de INSERT debe ser DENEGADO (esperado: ERROR: permission denied)
INSERT INTO "MOV_EP1_EQUIPO_09" (material, clase_movimiento, centro)
VALUES ('MAT-999', '101', '1000');

-- Intento de UPDATE debe ser DENEGADO (esperado: ERROR: permission denied)
UPDATE "MOV_EP1_EQUIPO_09" SET importe_ml = 0 WHERE id = 1;


-- ############################################
-- # Conectado como APP_USER_2_EP1_EQUIPO_09  #
-- ############################################

-- Puede hacer SELECT a todo (esperado: OK)
SELECT * FROM "CLASE_MOV_EP1_EQUIPO_09";
SELECT * FROM "MOV_EP1_EQUIPO_09";

-- Puede INSERT/UPDATE SOLO en MOV (esperado: OK)
INSERT INTO "MOV_EP1_EQUIPO_09" (material, clase_movimiento, centro, importe_ml)
VALUES ('MAT-004', '201', '2000', 9000);

UPDATE "MOV_EP1_EQUIPO_09" SET importe_ml = 9500 WHERE material = 'MAT-004';

-- Intento de escribir en un catálogo (fuera de su alcance) debe ser
-- DENEGADO (esperado: ERROR: permission denied) -> refuerza el
-- "mínimo privilegio": solo puede escribir en la tabla transaccional
INSERT INTO "CENTROS_EP1_EQUIPO_09" (codigo, descripcion) VALUES ('9999', 'Centro falso');

-- Intento de DROP TABLE debe ser DENEGADO (esperado: ERROR: must be owner)
DROP TABLE "MOV_EP1_EQUIPO_09";

-- Intento de crear un rol/usuario debe ser DENEGADO
-- (esperado: ERROR: permission denied to create role)
CREATE ROLE "HACKER_EP1_EQUIPO_09" LOGIN PASSWORD 'x';


-- ############################################
-- # Conectado como AUDITOR_EP1_EQUIPO_09     #
-- ############################################

-- Puede consultar todo para efectos de auditoría (esperado: OK)
SELECT * FROM "MOV_EP1_EQUIPO_09";
SELECT * FROM "VW_RESUMEN_MOVIMIENTOS_EP1_EQUIPO_09";

-- Puede ver actividad de sesiones del servidor (esperado: OK, gracias a pg_read_all_stats)
SELECT pid, usename, state, query_start FROM pg_stat_activity;

-- NO puede modificar datos de negocio (esperado: ERROR: permission denied)
INSERT INTO "MOV_EP1_EQUIPO_09" (material, clase_movimiento, centro) VALUES ('MAT-005', '101', '1000');
UPDATE "MOV_EP1_EQUIPO_09" SET importe_ml = 1 WHERE id = 1;
DELETE FROM "MOV_EP1_EQUIPO_09" WHERE id = 1;
