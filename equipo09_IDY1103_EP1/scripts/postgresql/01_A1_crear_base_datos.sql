-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- PASO A.1: Creación del esquema/espacio de trabajo
-- Motor: PostgreSQL
-- Ejecutar conectado como superusuario (ej: psql -U postgres)
-- =====================================================

-- Se crea la base de datos con codificación UTF8 (requisito de los CSV
-- del proyecto, que usan encoding UTF-8) y a partir de template0 para
-- evitar heredar configuraciones regionales del template por defecto.
CREATE DATABASE db_ep1_equipo_09
    WITH ENCODING = 'UTF8'
    TEMPLATE = template0;

COMMENT ON DATABASE db_ep1_equipo_09 IS 'Base de datos EP1 - Equipo 09 - IDY1103 - Movimientos de material (SAP)';

-- Verificación: la base debe aparecer en el listado
-- \l  (comando de psql para listar bases de datos)
