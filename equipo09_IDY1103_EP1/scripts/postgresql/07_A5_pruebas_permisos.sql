-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- PASO A.5: Pruebas obligatorias (permitido/denegado)
-- IMPORTANTE: cada query se ejecuta CONECTADO como el usuario
-- indicado, no como superusuario/admin.
-- 1. Ejecutar SET ROLE "usuario", 2. Hacer pruebas, 3. RESET ROLE
-- Para ver usuario actual: SELECT current_user;
-- Antes de cada acción BEGIN TRANSACTION y si es necesario ROLLBACK
-- =====================================================

-- ############################################
-- # Conectado como APP_USER_1_EP1_EQUIPO_09  #
-- ############################################

SET ROLE "APP_USER_1_EP1_EQUIPO_09";
SELECT current_user;

-- Puede hacer SELECT a las 3 tablas y a la vista (esperado: OK)
SELECT current_user, * FROM "CLASE_MOV_EP1_EQUIPO_09" LIMIT 5;
SELECT current_user, * FROM "CENTROS_EP1_EQUIPO_09" LIMIT 5;
SELECT current_user, * FROM "MOV_EP1_EQUIPO_09" LIMIT 5;
SELECT current_user, * FROM "VW_RESUMEN_MOVIMIENTOS_EP1_EQUIPO_09" LIMIT 5;

-- Intento de INSERT debe ser DENEGADO (esperado: ERROR: permission denied)
BEGIN TRANSACTION;
INSERT INTO "MOV_EP1_EQUIPO_09" ("Material", "Clase de movimiento", "Centro")
VALUES ('MAT-999', '101', '1000');
ROLLBACK;

-- Intento de UPDATE debe ser DENEGADO (esperado: ERROR: permission denied)
BEGIN TRANSACTION;
UPDATE "CENTROS_EP1_EQUIPO_09" SET "Descripcion" = 'Duoc' WHERE "Codigo" = 'BPAP';
ROLLBACK;

RESET ROLE;

-- ############################################
-- # Conectado como APP_USER_2_EP1_EQUIPO_09  #
-- ############################################

SET ROLE "APP_USER_2_EP1_EQUIPO_09";
SELECT current_user;

-- Puede hacer SELECT a todo (esperado: OK)
SELECT current_user, * FROM "CLASE_MOV_EP1_EQUIPO_09" LIMIT 5;
SELECT current_user, * FROM "CENTROS_EP1_EQUIPO_09" LIMIT 5;
SELECT current_user, * FROM "MOV_EP1_EQUIPO_09" LIMIT 5;
SELECT current_user, * FROM "VW_RESUMEN_MOVIMIENTOS_EP1_EQUIPO_09" LIMIT 5;

-- Puede INSERT/UPDATE SOLO en MOV (esperado: OK)
BEGIN TRANSACTION;
INSERT INTO "MOV_EP1_EQUIPO_09" ("Material", "Clase de movimiento", "Centro")
VALUES ('MAT-999', '101', '1000');
ROLLBACK;

BEGIN TRANSACTION;
UPDATE "MOV_EP1_EQUIPO_09" SET "Material" = 'MAT-999' WHERE "Documento material" = '4957051489';
ROLLBACK;

-- Intento de escribir en un catálogo (fuera de su alcance) debe ser
-- DENEGADO (esperado: ERROR: permission denied)
BEGIN TRANSACTION;
INSERT INTO "CENTROS_EP1_EQUIPO_09" (codigo, descripcion) VALUES ('9999', 'Centro falso');
ROLLBACK;

-- Intento de DROP TABLE debe ser DENEGADO (esperado: ERROR: must be owner)
BEGIN TRANSACTION;
DROP TABLE "MOV_EP1_EQUIPO_09";
ROLLBACK;

-- Intento de crear un rol/usuario debe ser DENEGADO
-- (esperado: ERROR: permission denied to create role)
BEGIN TRANSACTION;
CREATE ROLE "HACKER_EP1_EQUIPO_09" LOGIN PASSWORD 'x';
ROLLBACK;

RESET ROLE;

-- ############################################
-- # Conectado como AUDITOR_EP1_EQUIPO_09     #
-- ############################################

SET ROLE "AUDITOR_EP1_EQUIPO_09";
SELECT current_user;

-- Puede consultar todo para efectos de auditoría (esperado: OK)
SELECT current_user, * FROM "CLASE_MOV_EP1_EQUIPO_09" LIMIT 5;
SELECT current_user, * FROM "VW_RESUMEN_MOVIMIENTOS_EP1_EQUIPO_09" LIMIT 5;

-- Puede ver actividad de sesiones del servidor (esperado: OK, gracias a pg_read_all_stats)
SELECT current_user, pid, usename, state, query_start FROM pg_stat_activity;

-- NO puede modificar datos de negocio (esperado: ERROR: permission denied)
BEGIN TRANSACTION;
INSERT INTO "MOV_EP1_EQUIPO_09" ("Material", "Clase de movimiento", "Centro")
VALUES ('MAT-999', '101', '1000');
ROLLBACK;

BEGIN TRANSACTION;
UPDATE "CENTROS_EP1_EQUIPO_09" SET "Descripcion" = 'Duoc' WHERE "Codigo" = 'BPAP';
ROLLBACK;

BEGIN TRANSACTION;
DELETE FROM "CENTROS_EP1_EQUIPO_09" WHERE "Codigo" = 'BPAP';
ROLLBACK;

RESET ROLE;
