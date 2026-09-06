-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- Script 10: Monitoreo básico
-- =====================================================
\c db_ep1_equipo_09

-- Tamaño de la base de datos
SELECT pg_size_pretty(pg_database_size('db_ep1_equipo_09')) AS tamano_bd;

-- Conexiones/sesiones activas
SELECT pid, usename, application_name, client_addr, state, query_start
FROM pg_stat_activity
WHERE datname = 'db_ep1_equipo_09';

-- Verificación de objetos creados
SELECT tablename  FROM pg_tables  WHERE schemaname='public' AND tablename  LIKE '%EP1_EQUIPO_09%';
SELECT indexname  FROM pg_indexes WHERE schemaname='public' AND indexname  LIKE '%EP1_EQUIPO_09%';
SELECT viewname   FROM pg_views   WHERE schemaname='public' AND viewname   LIKE '%EP1_EQUIPO_09%';
