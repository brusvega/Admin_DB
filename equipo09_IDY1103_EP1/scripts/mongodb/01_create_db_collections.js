// =====================================================
// EQUIPO_09 - IDY1103 - EP1
// Script 01: Base de datos y colecciones
// Ejecutar con mongosh conectado como admin
// =====================================================
use db_ep1_equipo_09;

db.createCollection("COL_CLIENTES_EP1_EQUIPO_09");
db.createCollection("COL_PEDIDOS_EP1_EQUIPO_09");
db.createCollection("COL_LOG_ACCESO_EP1_EQUIPO_09");

// Índice mínimo requerido
db.COL_PEDIDOS_EP1_EQUIPO_09.createIndex({ id_cliente: 1 });
db.COL_PEDIDOS_EP1_EQUIPO_09.createIndex({ fecha: 1 });
