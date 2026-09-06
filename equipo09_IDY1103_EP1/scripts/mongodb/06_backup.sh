#!/bin/bash
# =====================================================
# EQUIPO_09 - IDY1103 - EP1
# Script 06: Respaldo de la base de datos (mongodump)
# =====================================================
mongodump \
  --db db_ep1_equipo_09 \
  --username MONGO_ADMIN_EP1_EQUIPO_09 \
  --password 'MAdmin01$EP1' \
  --authenticationDatabase db_ep1_equipo_09 \
  --out "./backup_mongo_ep1_equipo_09_$(date +%Y%m%d_%H%M)"

echo "Respaldo generado correctamente."
