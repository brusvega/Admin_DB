// =====================================================
// EQUIPO_09 - IDY1103 - EP1
// Script 04: Pruebas de permisos (permitido/denegado)
// Conectar con mongosh usando cada usuario y guardar
// captura/log de cada resultado en /evidencias
// =====================================================

// --- Conectado como MONGO_USER_1_EP1_EQUIPO_09 ---
// mongosh "mongodb://MONGO_USER_1_EP1_EQUIPO_09:MUser01$EP1@localhost/db_ep1_equipo_09"
use db_ep1_equipo_09;
db.COL_CLIENTES_EP1_EQUIPO_09.find();                                                  // esperado: OK
db.COL_PEDIDOS_EP1_EQUIPO_09.aggregate([{ $match: {} }]);                              // esperado: OK
db.COL_PEDIDOS_EP1_EQUIPO_09.insertOne({ id: 99, id_cliente: 1, fecha: new Date(), total: 100 }); // esperado: ERROR no autorizado

// --- Conectado como MONGO_AUDITOR_EP1_EQUIPO_09 ---
// mongosh "mongodb://MONGO_AUDITOR_EP1_EQUIPO_09:MAudit01$EP1@localhost/db_ep1_equipo_09"
db.COL_LOG_ACCESO_EP1_EQUIPO_09.find();                                                 // esperado: OK
db.COL_PEDIDOS_EP1_EQUIPO_09.insertOne({ id: 100, id_cliente: 1, fecha: new Date(), total: 500 }); // esperado: ERROR no autorizado
db.COL_PEDIDOS_EP1_EQUIPO_09.updateOne({ id: 1 }, { $set: { total: 0 } });              // esperado: ERROR no autorizado
