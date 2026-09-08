-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- PASO C.2: Auditoría
-- =====================================================

-- Configuración recomendada en postgresql.conf (requiere reinicio del servicio):
--   log_connections     = on
--   log_disconnections  = on
--   log_line_prefix     = '%m [%p] %u@%d '
--   log_statement       = 'mod'            -- registra INSERT/UPDATE/DELETE/DDL
--   shared_preload_libraries = 'pgaudit'   -- si el módulo está disponible
--   pgaudit.log = 'write, ddl, role'
--
-- Con esto quedan registrados: inicios/cierres de sesión, intentos fallidos
-- de autenticación (log_connections captura también los fallidos) y accesos
-- de escritura/DDL sobre los objetos sensibles.

-- Complemento manual: tabla de bitácora propia (no es una de las 3 tablas
-- mínimas de A.4, es un objeto adicional para la sección C de auditoría)
\c db_ep1_equipo_09
SET ROLE "APP_ADMIN_EP1_EQUIPO_09";

CREATE TABLE "LOG_ACCESO_EP1_EQUIPO_09" (
    id             SERIAL PRIMARY KEY,
    usuario_bd     TEXT NOT NULL DEFAULT current_user,
    accion         TEXT NOT NULL,
    tabla_afectada TEXT,
    fecha_hora     TIMESTAMP NOT NULL DEFAULT now()
);

-- Solo AUDITOR puede leerla; el resto no tiene acceso
GRANT SELECT ON "LOG_ACCESO_EP1_EQUIPO_09" TO "ROL_AUDIT_EP1_EQUIPO_09";

RESET ROLE;

INSERT INTO "LOG_ACCESO_EP1_EQUIPO_09" (accion, tabla_afectada)
VALUES ('LOGIN_TEST', 'N/A');




-- JUAN (REVISAR VARIABLES):
-- 1. Logs nativos de conexion
ALTER SYSTEM SET log_connections = 'on';
ALTER SYSTEM SET log_disconnections = 'on';
ALTER SYSTEM SET log_line_prefix = '%m [%p] %u@%d: ';
SELECT pg_reload_conf();

-- 2. Tabla de bitacora para registrar cambios
CREATE TABLE auditoria_log_ep1_equipo_09 (
    id SERIAL PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    operacion VARCHAR(20) NOT NULL,
    tabla_afectada VARCHAR(50) NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    detalles TEXT
);

-- Acceso de lectura al rol auditor
GRANT SELECT ON auditoria_log_ep1_equipo_09 TO rol_audit_ep1_equipo_09;

-- 3. Funcion trigger para guardar el log cuando se inserte o modifique un movimiento
CREATE OR REPLACE FUNCTION fn_log_auditoria_movimientos()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_log_ep1_equipo_09 (usuario, operacion, tabla_afectada, detalles)
    VALUES (
        SESSION_USER,
        TG_OP,
        TG_TABLE_NAME,
        CONCAT('Material: ', NEW.material, ' | Doc: ', NEW.documento_material)
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger asociado a la tabla de movimientos
DROP TRIGGER IF EXISTS trg_auditoria_movimientos ON mov_ep1_equipo_09;
CREATE TRIGGER trg_auditoria_movimientos
AFTER INSERT OR UPDATE ON mov_ep1_equipo_09
FOR EACH ROW EXECUTE FUNCTION fn_log_auditoria_movimientos();
