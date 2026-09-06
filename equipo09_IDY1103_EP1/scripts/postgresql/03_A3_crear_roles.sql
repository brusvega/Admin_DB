-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- PASO A.3 (parte 1): Creación de roles y asignación a usuarios
-- =====================================================

-- Roles de GRUPO, sin capacidad de login: solo agrupan privilegios.
-- Es la forma estándar en PostgreSQL de implementar "roles" tipo
-- ROL_READ/ROL_WRITE/ROL_AUDIT de la pauta.
CREATE ROLE "ROL_READ_EP1_EQUIPO_09"  NOLOGIN;
CREATE ROLE "ROL_WRITE_EP1_EQUIPO_09" NOLOGIN;
CREATE ROLE "ROL_AUDIT_EP1_EQUIPO_09" NOLOGIN;

-- Asignación (membresía) de cada usuario a su rol:
-- APP_USER_1 -> solo lectura
GRANT "ROL_READ_EP1_EQUIPO_09"  TO "APP_USER_1_EP1_EQUIPO_09";

-- APP_USER_2 -> lectura + escritura controlada (solo sobre las tablas indicadas)

GRANT "ROL_READ_EP1_EQUIPO_09"  TO "APP_USER_2_EP1_EQUIPO_09";
GRANT "ROL_WRITE_EP1_EQUIPO_09" TO "APP_USER_2_EP1_EQUIPO_09";

-- AUDITOR -> solo lectura + permisos necesarios para revisar auditoría/logs
GRANT "ROL_READ_EP1_EQUIPO_09" TO "AUDITOR_EP1_EQUIPO_09";
GRANT "ROL_AUDIT_EP1_EQUIPO_09" TO "AUDITOR_EP1_EQUIPO_09";

-- APP_ADMIN -> permiso para conectarse a la BD y crear objetos dentro de ella (esquema public)
GRANT CONNECT, CREATE ON DATABASE db_ep1_equipo_09 TO "APP_ADMIN_EP1_EQUIPO_09";
GRANT USAGE, CREATE ON SCHEMA public TO "APP_ADMIN_EP1_EQUIPO_09";

-- Verificación:
-- \du   (la columna "Member of" debe mostrar el rol asignado a cada usuario)
