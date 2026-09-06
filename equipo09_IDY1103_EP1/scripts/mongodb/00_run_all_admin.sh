#!/bin/bash
# =====================================================
# EQUIPO_09 - IDY1103 - EP1
# Ejecuta en orden los scripts de configuración inicial
# de MongoDB (los que corren como admin).
#
# USO:
#   1) Ajusta la variable MONGO_URI si tu servidor no es
#      localhost:27017 o si ya tienes auth habilitada.
#   2) chmod +x run_all_admin.sh
#   3) ./run_all_admin.sh
# =====================================================

# Si NO tienes autenticación habilitada todavía (primera vez):
MONGO_URI="mongodb://localhost:27017/db_ep1_equipo_09"

# Si YA habilitaste authorization:enabled en mongod.conf, usa en su lugar:
# MONGO_URI="mongodb://MONGO_ADMIN_EP1_EQUIPO_09:MAdmin01\$EP1@localhost:27017/db_ep1_equipo_09?authSource=db_ep1_equipo_09"

set -e  # corta la ejecución si algún script falla

echo ">> 01 - Creando base y colecciones..."
mongosh "$MONGO_URI" 01_create_db_collections.js

echo ">> 02 - Creando roles y usuarios..."
mongosh "$MONGO_URI" 02_create_users_roles.js

echo ">> 03 - Insertando datos de prueba..."
mongosh "$MONGO_URI" 03_insert_test_data.js

echo ">> 07 - Verificando monitoreo básico..."
mongosh "$MONGO_URI" 07_monitoring.js

echo ">> Listo. Ahora corre 04_test_permissions.js MANUALMENTE conectado"
echo "   con cada usuario (MONGO_USER_1 y MONGO_AUDITOR) para tomar evidencias,"
echo "   ya que cada bloque necesita una conexión distinta con esas credenciales."
