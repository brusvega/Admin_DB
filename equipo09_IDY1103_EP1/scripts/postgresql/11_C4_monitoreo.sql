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



-- JUAN: (REVISAR VARIABLES)

-- Paso C.4: Consultas de monitoreo y comandos para respaldo pg_dump
-- Conectar a db_ep1_equipo_09

-- 1. Monitoreo: Tamano de la base de datos
SELECT 
    datname AS base_de_datos,
    pg_size_pretty(pg_database_size(datname)) AS tamano
FROM pg_database
WHERE datname = 'db_ep1_equipo_09';

-- 2. Monitoreo: Tamano de tablas y cantidad de registros
SELECT 
    relname AS tabla,
    pg_size_pretty(pg_total_relation_size(relid)) AS tamano_total,
    n_live_tup AS total_registros
FROM pg_stat_user_tables
ORDER BY pg_total_relation_size(relid) DESC;

-- 3. Monitoreo: Sesiones y conexiones activas
SELECT 
    pid, 
    usename, 
    client_addr, 
    backend_start, 
    state, 
    query 
FROM pg_stat_activity 
WHERE datname = 'db_ep1_equipo_09';

-- 4. Comandos de respaldo en terminal Linux:
-- pg_dump -U postgres -d db_ep1_equipo_09 -F c -b -v -f /respaldos/equipo09_IDY1103_EP1.dump
