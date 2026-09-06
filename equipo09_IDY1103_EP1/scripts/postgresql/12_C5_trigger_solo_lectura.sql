-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- EXTRA (buena práctica adicional): Trigger de "MODO SOLO LECTURA"
-- Bloquea TODA modificación (INSERT/UPDATE/DELETE) en TODAS las
-- tablas del equipo, para CUALQUIER usuario (incluso APP_ADMIN),
-- mientras la bandera esté activada.
-- =====================================================
\c db_ep1_equipo_09
SET ROLE "APP_ADMIN_EP1_EQUIPO_09";

-- ============ 1) TABLA DE CONTROL (el "interruptor") ============
-- Esta tabla NO lleva el trigger de bloqueo, porque es la que
-- necesitamos poder seguir modificando para prender/apagar el modo.
CREATE TABLE "CONTROL_MODO_EP1_EQUIPO_09" (
    id             SERIAL PRIMARY KEY,
    solo_lectura   BOOLEAN NOT NULL DEFAULT false,
    modificado_por TEXT NOT NULL DEFAULT current_user,
    fecha_hora     TIMESTAMP NOT NULL DEFAULT now()
);

-- Fila inicial: modo normal (lectura y escritura permitidas)
INSERT INTO "CONTROL_MODO_EP1_EQUIPO_09" (solo_lectura) VALUES (false);

-- Solo APP_ADMIN puede leer/cambiar el interruptor (el resto no ve
-- ni puede tocar esta tabla, para que nadie más pueda desactivarlo)
REVOKE ALL ON "CONTROL_MODO_EP1_EQUIPO_09" FROM PUBLIC;
GRANT SELECT, UPDATE ON "CONTROL_MODO_EP1_EQUIPO_09" TO "APP_ADMIN_EP1_EQUIPO_09";

-- ============ 2) FUNCIÓN DEL TRIGGER (la "alarma") ============
CREATE OR REPLACE FUNCTION fn_bloquear_modificaciones_ep1_equipo_09()
RETURNS TRIGGER AS $$
DECLARE
    v_solo_lectura BOOLEAN;
BEGIN
    -- Revisa el estado actual del interruptor
    SELECT solo_lectura INTO v_solo_lectura
    FROM "CONTROL_MODO_EP1_EQUIPO_09"
    ORDER BY id DESC
    LIMIT 1;

    IF v_solo_lectura THEN
        RAISE EXCEPTION
            'MODO SOLO LECTURA ACTIVO: operación % bloqueada en la tabla % (usuario: %)',
            TG_OP, TG_TABLE_NAME, current_user;
    END IF;

    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- ============ 3) ASOCIAR EL TRIGGER A LAS 4 TABLAS ============
CREATE TRIGGER trg_bloqueo_clase_mov_ep1_equipo_09
    BEFORE INSERT OR UPDATE OR DELETE ON "CLASE_MOV_EP1_EQUIPO_09"
    FOR EACH ROW EXECUTE FUNCTION fn_bloquear_modificaciones_ep1_equipo_09();

CREATE TRIGGER trg_bloqueo_centros_ep1_equipo_09
    BEFORE INSERT OR UPDATE OR DELETE ON "CENTROS_EP1_EQUIPO_09"
    FOR EACH ROW EXECUTE FUNCTION fn_bloquear_modificaciones_ep1_equipo_09();

CREATE TRIGGER trg_bloqueo_mov_ep1_equipo_09
    BEFORE INSERT OR UPDATE OR DELETE ON "MOV_EP1_EQUIPO_09"
    FOR EACH ROW EXECUTE FUNCTION fn_bloquear_modificaciones_ep1_equipo_09();

CREATE TRIGGER trg_bloqueo_log_acceso_ep1_equipo_09
    BEFORE INSERT OR UPDATE OR DELETE ON "LOG_ACCESO_EP1_EQUIPO_09"
    FOR EACH ROW EXECUTE FUNCTION fn_bloquear_modificaciones_ep1_equipo_09();

RESET ROLE;

-- ============ 4) CÓMO ACTIVAR / DESACTIVAR ============
-- Para BLOQUEAR toda la base (ej: antes de tomar evidencias finales):
--   UPDATE "CONTROL_MODO_EP1_EQUIPO_09"
--   SET solo_lectura = true, modificado_por = current_user, fecha_hora = now();

-- Para DESBLOQUEAR y volver a la normalidad:
--   UPDATE "CONTROL_MODO_EP1_EQUIPO_09"
--   SET solo_lectura = false, modificado_por = current_user, fecha_hora = now();

-- Verificación del estado actual:
--   SELECT * FROM "CONTROL_MODO_EP1_EQUIPO_09" ORDER BY id DESC LIMIT 1;
