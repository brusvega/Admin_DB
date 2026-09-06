-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- PASO A.3 (parte 2): Asignación de permisos - mínimo privilegio
-- Se ejecuta DESPUÉS de crear las tablas (A.4), ya que se otorgan
-- permisos sobre objetos que deben existir previamente.
-- =====================================================
\c db_ep1_equipo_09

-- Por defecto, en PostgreSQL el rol especial PUBLIC tiene algunos
-- privilegios heredados. Se los quitamos primero para partir de
-- "cero accesos" y luego otorgar solo lo necesario (mínimo privilegio).
REVOKE ALL ON "CLASE_MOV_EP1_EQUIPO_09", "CENTROS_EP1_EQUIPO_09", "MOV_EP1_EQUIPO_09" FROM PUBLIC;

-- ============ ROL_READ: SOLO lectura (SELECT) en las 3 tablas + vista ============
-- Usado por APP_USER_1 (y también por APP_USER_2, que además tendrá WRITE)
GRANT USAGE ON SCHEMA public TO "ROL_READ_EP1_EQUIPO_09";
GRANT SELECT ON
    "CLASE_MOV_EP1_EQUIPO_09",
    "CENTROS_EP1_EQUIPO_09",
    "MOV_EP1_EQUIPO_09",
    "VW_RESUMEN_MOVIMIENTOS_EP1_EQUIPO_09"
TO "ROL_READ_EP1_EQUIPO_09";

-- ============ ROL_WRITE: lectura + escritura CONTROLADA ============
-- Solo puede escribir en la tabla TRANSACCIONAL (MOV), NO en los
-- catálogos maestros (CLASE_MOV, CENTROS) -> esa es la tabla
-- "indicada abajo" equivalente a PEDIDOS/PAGOS del enunciado genérico.
GRANT USAGE ON SCHEMA public TO "ROL_WRITE_EP1_EQUIPO_09";
GRANT INSERT, UPDATE ON "MOV_EP1_EQUIPO_09" TO "ROL_WRITE_EP1_EQUIPO_09";
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO "ROL_WRITE_EP1_EQUIPO_09";

-- ============ ROL_AUDIT: SOLO lectura + auditoría ============
GRANT USAGE ON SCHEMA public TO "ROL_AUDIT_EP1_EQUIPO_09";
GRANT SELECT ON
    "CLASE_MOV_EP1_EQUIPO_09",
    "CENTROS_EP1_EQUIPO_09",
    "MOV_EP1_EQUIPO_09",
    "VW_RESUMEN_MOVIMIENTOS_EP1_EQUIPO_09"
TO "ROL_AUDIT_EP1_EQUIPO_09";

-- Permiso adicional para que AUDITOR pueda revisar actividad/sesiones
-- del servidor SIN ser superusuario (equivalente a "permisos para
-- revisar auditoría/logs" que pide la pauta).
GRANT pg_read_all_stats TO "AUDITOR_EP1_EQUIPO_09";

-- Verificación:
-- \dp "MOV_EP1_EQUIPO_09"   (muestra la tabla de privilegios por rol)
