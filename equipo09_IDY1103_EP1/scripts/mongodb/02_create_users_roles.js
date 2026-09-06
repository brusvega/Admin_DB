// =====================================================
// EQUIPO_09 - IDY1103 - EP1
// Script 02: Roles personalizados (mínimo privilegio) y usuarios
// =====================================================
use db_ep1_equipo_09;

// ============ ROLES ============
db.createRole({
  role: "MONGO_READ_EP1_EQUIPO_09",
  privileges: [
    { resource: { db: "db_ep1_equipo_09", collection: "" }, actions: ["find"] }
  ],
  roles: []
});

db.createRole({
  role: "MONGO_WRITE_EP1_EQUIPO_09",
  privileges: [
    { resource: { db: "db_ep1_equipo_09", collection: "COL_PEDIDOS_EP1_EQUIPO_09" }, actions: ["find", "insert", "update"] },
    { resource: { db: "db_ep1_equipo_09", collection: "COL_CLIENTES_EP1_EQUIPO_09" }, actions: ["find"] }
  ],
  roles: []
});

db.createRole({
  role: "MONGO_AUDIT_EP1_EQUIPO_09",
  privileges: [
    { resource: { db: "db_ep1_equipo_09", collection: "COL_LOG_ACCESO_EP1_EQUIPO_09" }, actions: ["find"] },
    { resource: { db: "db_ep1_equipo_09", collection: "" }, actions: ["find"] }
  ],
  roles: []
});

// ============ USUARIOS ============
db.createUser({
  user: "MONGO_ADMIN_EP1_EQUIPO_09",
  pwd: "MAdmin01$EP1",
  roles: [{ role: "dbOwner", db: "db_ep1_equipo_09" }]   // administra objetos, sin ser admin global del clúster
});

db.createUser({
  user: "MONGO_USER_1_EP1_EQUIPO_09",
  pwd: "MUser01$EP1",
  roles: [{ role: "MONGO_READ_EP1_EQUIPO_09", db: "db_ep1_equipo_09" }]
});

db.createUser({
  user: "MONGO_AUDITOR_EP1_EQUIPO_09",
  pwd: "MAudit01$EP1",
  roles: [{ role: "MONGO_AUDIT_EP1_EQUIPO_09", db: "db_ep1_equipo_09" }]
});
