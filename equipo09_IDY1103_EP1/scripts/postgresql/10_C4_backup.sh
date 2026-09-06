#!/bin/bash
# =====================================================
# EQUIPO_09 - IDY1103 - EP1
# Script 09: Respaldo de la base de datos (pg_dump)
# =====================================================
pg_dump -U postgres -h localhost -d db_ep1_equipo_09 \
  -F c \
  -f "backup_db_ep1_equipo_09_$(date +%Y%m%d_%H%M).dump"

echo "Respaldo generado correctamente."
