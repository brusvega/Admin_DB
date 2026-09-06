-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- PASO A.4 (parte 1): Tablas, índice y vista
-- =====================================================

-- Ejecutamos como APP_ADMIN para que administre los objetos del esquema.
SET ROLE "APP_ADMIN_EP1_EQUIPO_09";

-- ============ TABLA MAESTRA: CLASE_MOV ============
-- Corresponde a Clase_mov.csv (Codigo;Descripcion) -> catálogo de
-- clases de movimiento (ej: 101 Entrada, 201 Salida, etc.)
CREATE TABLE "CLASE_MOV_EP1_EQUIPO_09" (
    "Codigo"      VARCHAR,
    "Descripcion" VARCHAR
);

-- ============ TABLA MAESTRA: CENTROS ============
-- Corresponde a Centros.csv (Codigo;Descripcion) -> catálogo de
-- centros/plantas.
CREATE TABLE "CENTROS_EP1_EQUIPO_09" (
    "Codigo"      VARCHAR,
    "Descripcion" VARCHAR
);

-- ============ TABLA TRANSACCIONAL: MOV ============
-- Corresponde a la estructura de los 32 archivos mov.csv
CREATE TABLE "MOV_EP1_EQUIPO_09" (
    "Material" VARCHAR,
    "Texto breve de material" VARCHAR,
    "Clase de movimiento" VARCHAR,
    "Posición doc.mat." VARCHAR,
    "Cuenta" VARCHAR,
    "Ctd.en UM entrada" VARCHAR,
    "Un.medida de entrada" VARCHAR,
    "Centro" VARCHAR,
    "Almacén" VARCHAR,
    "Documento material" VARCHAR,
    "Fe.contabilización" VARCHAR,
    "Importe ML" VARCHAR,
    "Nº reserva" VARCHAR,
    "Hora de entrada" VARCHAR,
    "Referencia"VARCHAR,
    "Sociedad" VARCHAR,
    "Texto de clase-mov." VARCHAR,
    "Clase de mov." VARCHAR,
    "Clase de operación" VARCHAR,
    "Fecha de documento" VARCHAR,
    "Fecha de entrada" VARCHAR,
    "Motivo movimiento" VARCHAR,
    "Nombre" VARCHAR;
);

-- ============ ÍNDICE OBLIGATORIO (idx_mat) ============
-- Índice por el campo "material", que es el que más se filtra/consulta. 
CREATE INDEX IDX_MAT_EP1_EQUIPO_09 ON "MOV_EP1_EQUIPO_09"("Material");

-- ============ VISTA DE RESUMEN ============
-- Combina el movimiento con la descripción de su clase y de su centro.
CREATE OR REPLACE VIEW "VW_RESUMEN_MOVIMIENTOS_EP1_EQUIPO_09" AS
SELECT
    m."Material",
    m."Texto breve de material",
    cm."Descripcion" AS "Clase_movimiento_desc",
    c."Descripcion" AS "Centro_desc",
    m."Fe.contabilización",
    m."Importe ML"
FROM "MOV_EP1_EQUIPO_09" AS m
INNER JOIN "CLASE_MOV_EP1_EQUIPO_09" AS cm
    ON cm."Codigo" = m."Clase de movimiento"
INNER JOIN "CENTROS_EP1_EQUIPO_09" AS c
    ON c."Codigo" = m."Centro";

RESET ROLE;

-- Verificación:
-- \dt   (lista las 3 tablas)
-- \di   (debe aparecer idx_mat_ep1_equipo_09)
-- \dv   (debe aparecer la vista)
