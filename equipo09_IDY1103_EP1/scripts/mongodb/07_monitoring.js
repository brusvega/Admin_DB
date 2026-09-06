// =====================================================
// EQUIPO_09 - IDY1103 - EP1
// Script 07: Monitoreo básico
// =====================================================
use db_ep1_equipo_09;

db.stats();                                     // tamaño de la BD
db.currentOp();                                 // conexiones/operaciones activas
db.getCollectionNames();                        // verificación de colecciones creadas
db.COL_PEDIDOS_EP1_EQUIPO_09.getIndexes();       // verificación de índices creados
