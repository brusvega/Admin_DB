// =====================================================
// EQUIPO_09 - IDY1103 - EP1
// Script 03: Datos de prueba
// =====================================================
use db_ep1_equipo_09;

db.COL_CLIENTES_EP1_EQUIPO_09.insertMany([
  { id: 1, nombre: "Ana Torres",  email: "ana.torres@correo.cl" },
  { id: 2, nombre: "Bruno Silva", email: "bruno.silva@correo.cl" }
]);

db.COL_PEDIDOS_EP1_EQUIPO_09.insertMany([
  { id: 1, id_cliente: 1, fecha: new Date("2026-08-01"), total: 45000 },
  { id: 2, id_cliente: 2, fecha: new Date("2026-08-03"), total: 12000 }
]);

db.COL_LOG_ACCESO_EP1_EQUIPO_09.insertOne({
  usuario: "MONGO_ADMIN_EP1_EQUIPO_09",
  accion: "INIT_DATA",
  fecha_hora: new Date()
});
