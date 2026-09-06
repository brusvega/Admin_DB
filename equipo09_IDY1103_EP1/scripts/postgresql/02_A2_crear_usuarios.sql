-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- PASO A.2: Usuarios (login roles) y contraseñas
-- Ejecutar conectado a db_ep1_equipo_09 como superusuario
-- =====================================================

-- Se crean 4 roles CON LOGIN (equivalentes a "usuarios" en PostgreSQL).
-- Las contraseñas son EXACTAMENTE las que exige la pauta; PostgreSQL
-- no valida complejidad de forma nativa, por lo que no fue necesario ajustarlas.
CREATE ROLE "APP_ADMIN_EP1_EQUIPO_09"  LOGIN PASSWORD 'Admin01$EP1';
CREATE ROLE "APP_USER_1_EP1_EQUIPO_09" LOGIN PASSWORD 'User01$EP1';
CREATE ROLE "APP_USER_2_EP1_EQUIPO_09" LOGIN PASSWORD 'User02$EP1';
CREATE ROLE "AUDITOR_EP1_EQUIPO_09"    LOGIN PASSWORD 'Audit01$EP1';

-- Se restringe a los 4 usuarios para que NINGUNO tenga privilegios
-- globales peligrosos (no pueden crear BD, no pueden crear roles,
-- no son superusuario). Esto incluye a APP_ADMIN: administra objetos
-- DENTRO del esquema, pero no el motor completo.
ALTER ROLE "APP_ADMIN_EP1_EQUIPO_09"  NOCREATEDB NOCREATEROLE NOSUPERUSER;
ALTER ROLE "APP_USER_1_EP1_EQUIPO_09" NOCREATEDB NOCREATEROLE NOSUPERUSER;
ALTER ROLE "APP_USER_2_EP1_EQUIPO_09" NOCREATEDB NOCREATEROLE NOSUPERUSER;
ALTER ROLE "AUDITOR_EP1_EQUIPO_09"    NOCREATEDB NOCREATEROLE NOSUPERUSER;

-- Verificación:
-- \du   (comando de psql para listar roles/usuarios y sus atributos)
