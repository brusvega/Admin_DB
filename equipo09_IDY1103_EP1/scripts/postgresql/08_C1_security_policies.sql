-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- Script 06: Políticas de seguridad - contraseñas
-- =====================================================
\c db_ep1_equipo_09

-- 1) COMPLEJIDAD: PostgreSQL no valida complejidad de forma nativa.
--    Se habilita la extensión "passwordcheck" (requiere agregarla en
--    shared_preload_libraries dentro de postgresql.conf y reiniciar el servicio).
--    Ejecutar como superusuario si el módulo está disponible en el servidor:
-- CREATE EXTENSION IF NOT EXISTS passwordcheck;

-- 2) EXPIRACIÓN: sí soportado de forma nativa (VALID UNTIL)
ALTER ROLE "APP_ADMIN_EP1_EQUIPO_09"  VALID UNTIL '2026-12-31';
ALTER ROLE "APP_USER_1_EP1_EQUIPO_09" VALID UNTIL '2026-12-31';
ALTER ROLE "APP_USER_2_EP1_EQUIPO_09" VALID UNTIL '2026-12-31';
ALTER ROLE "AUDITOR_EP1_EQUIPO_09"    VALID UNTIL '2026-12-31';

-- 3) BLOQUEO POR INTENTOS FALLIDOS: PostgreSQL no lo soporta de forma nativa
--    (limitación del motor, documentada en el informe).
--    Alternativa/control compensatorio propuesto:
--      - fail2ban monitoreando el log de autenticación (log_connections/log_disconnections)
--      - extensión "credcheck" para reforzar políticas de contraseña
--    Riesgo residual: sin bloqueo automático a nivel de motor; se mitiga con
--    monitoreo de intentos fallidos vía logs (ver script 07).
