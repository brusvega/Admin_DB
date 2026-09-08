// =====================================================
// EQUIPO_09 - IDY1103 - EP1
// Script 07: Monitoreo básico
// Ejecutar comando en mongosh conectado a la bd con el ambiente security desactivado
// =====================================================
use db_ep1_equipo_09;

db.stats();                                          // tamaño de la BD
db.currentOp();                                      // conexiones/operaciones activas
db.getCollectionNames();                             // verificación de colecciones creadas
db.serverStatus().connections                        // Para métricas exactas de conexiones:
db.getCollectionInfos({ name: "nombre_coleccion" })  // Para inspeccionar esquemas de validación de las colecciones: