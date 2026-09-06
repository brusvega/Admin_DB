-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- Script 07: Auditoría y cifrado
-- =====================================================

-- ============ AUDITORÍA ============
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

-- ============ CIFRADO ============
-- En tránsito (TLS/SSL) - configurar en postgresql.conf:
--   ssl = on
--   ssl_cert_file = 'server.crt'
--   ssl_key_file  = 'server.key'
-- Y en pg_hba.conf exigir conexiones "hostssl" en lugar de "host".
--
-- Si el entorno de laboratorio no permite configurar TLS (por ejemplo,
-- sin permisos de administración del servicio), se documenta como
-- limitación y se propone como mejora futura habilitarlo en el servidor
-- productivo, dejando como control compensatorio restringir el acceso
-- a la red local del laboratorio.
