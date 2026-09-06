-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- Pruebas del trigger de MODO SOLO LECTURA
-- Tomar captura de cada bloque para /evidencias
-- =====================================================

-- ############################################
-- # PASO 1: Conectado como APP_ADMIN, ACTIVAR #
-- ############################################
\c db_ep1_equipo_09

UPDATE "CONTROL_MODO_EP1_EQUIPO_09"
SET solo_lectura = true, modificado_por = current_user, fecha_hora = now();

SELECT * FROM "CONTROL_MODO_EP1_EQUIPO_09" ORDER BY id DESC LIMIT 1; -- debe mostrar solo_lectura = true


-- ####################################################################
-- # PASO 2: Conectado como APP_USER_2 (normalmente SÍ puede escribir #
-- # en MOV) -> ahora debe ser DENEGADO por el trigger, no por GRANT  #
-- ####################################################################
INSERT INTO "MOV_EP1_EQUIPO_09" (material, clase_movimiento, centro)
VALUES ('MAT-TEST', '101', '1000');
-- esperado: ERROR: MODO SOLO LECTURA ACTIVO: operación INSERT bloqueada
-- en la tabla MOV_EP1_EQUIPO_09 (usuario: APP_USER_2_EP1_EQUIPO_09)


-- ####################################################################
-- # PASO 3: Conectado como APP_ADMIN -> también debe ser DENEGADO,   #
-- # demostrando que el bloqueo es TOTAL (ni siquiera el admin puede) #
-- ####################################################################
SET ROLE "APP_ADMIN_EP1_EQUIPO_09";
INSERT INTO "CLASE_MOV_EP1_EQUIPO_09" (codigo, descripcion) VALUES ('999', 'Prueba');
-- esperado: ERROR: MODO SOLO LECTURA ACTIVO: operación INSERT bloqueada
-- en la tabla CLASE_MOV_EP1_EQUIPO_09 (usuario: APP_ADMIN_EP1_EQUIPO_09)
RESET ROLE;

-- Las lecturas (SELECT) siguen funcionando con normalidad para todos:
SELECT * FROM "MOV_EP1_EQUIPO_09"; -- esperado: OK, sin restricción


-- ############################################
-- # PASO 4: Conectado como APP_ADMIN, APAGAR #
-- ############################################
UPDATE "CONTROL_MODO_EP1_EQUIPO_09"
SET solo_lectura = false, modificado_por = current_user, fecha_hora = now();

-- ############################################
-- # PASO 5: Verificar que vuelve a la normalidad #
-- ############################################
SET ROLE "APP_ADMIN_EP1_EQUIPO_09";
INSERT INTO "CLASE_MOV_EP1_EQUIPO_09" (codigo, descripcion) VALUES ('998', 'Prueba OK');
-- esperado: OK, ya no hay bloqueo
RESET ROLE;
