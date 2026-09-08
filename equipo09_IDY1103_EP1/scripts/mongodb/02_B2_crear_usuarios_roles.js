// =====================================================
// EQUIPO_09 - IDY1103 - EP1
// Script 02: Roles personalizados (mínimo privilegio) y usuarios
// =====================================================

// ============ USUARIOS ============
db.createUser({
  user: "MONGO_ADMIN_EP1_EQUIPO_09",
  pwd: "MAdmin01$EP1",
  roles: []
});

db.createUser({
  user: "MONGO_USER_1_EP1_EQUIPO_09",
  pwd: "MUser01$EP1",
  roles: []
});

db.createUser({
  user: "MONGO_AUDITOR_EP1_EQUIPO_09",
  pwd: "MAudit01$EP1",
  roles: []
});

// Mostrar los usuarios creados 
show users

// ============ ROLES ============
db.createRole({
  role: "MONGO_READ_EP1_EQUIPO_09", // lectura
  privileges: [
    { resource: { db: "db_ep1_equipo_09", collection: "COL_MOV_EP1_EQUIPO_09" }, actions: ["find"] },
    { resource: { db: "db_ep1_equipo_09", collection: "COL_CLASE_MOV_EP1_EQUIPO_09" }, actions: ["find"] },
    { resource: { db: "db_ep1_equipo_09", collection: "COL_CENTROS_EP1_EQUIPO_09" }, actions: ["find"] }
  ],
  roles: []
});

db.createRole({
  role: "MONGO_WRITE_EP1_EQUIPO_09", // lectura + escritura controlada solo en COL_MOV
  privileges: [
    { resource: { db: "db_ep1_equipo_09", collection: "COL_MOV_EP1_EQUIPO_09" }, actions: ["find"] },
    { resource: { db: "db_ep1_equipo_09", collection: "COL_CLASE_MOV_EP1_EQUIPO_09" }, actions: ["find"] },
    { resource: { db: "db_ep1_equipo_09", collection: "COL_CENTROS_EP1_EQUIPO_09" }, actions: ["find"] },
    { resource: { db: "db_ep1_equipo_09", collection: "COL_MOV_EP1_EQUIPO_09" }, actions: ["insert", "update"] }
  ],
  roles: []
});

db.createRole({
  role: "MONGO_AUDIT_EP1_EQUIPO_09", // (revisión de logs/auditoría)
  privileges: [
    { resource: { db: "db_ep1_equipo_09", collection: "COL_LOG_ACCESO_EP1_EQUIPO_09" }, actions: ["find"] }
  ],
  roles: []
});

// Mostrar los roles creados 
db.getRoles({ showBuiltinRoles: false })

// ============ ASIGNACIÓN DE ROLES ============
db.grantRolesToUser(
  "MONGO_ADMIN_EP1_EQUIPO_09", // se le asignan todos los roles creados
  [ 
    { role: "MONGO_READ_EP1_EQUIPO_09", db: "db_ep1_equipo_09" },
    { role: "MONGO_WRITE_EP1_EQUIPO_09", db: "db_ep1_equipo_09" },
    { role: "MONGO_AUDIT_EP1_EQUIPO_09", db: "db_ep1_equipo_09" }
  ]
);

db.grantRolesToUser(
  "MONGO_USER_1_EP1_EQUIPO_09",
  [ { role: "MONGO_READ_EP1_EQUIPO_09", db: "db_ep1_equipo_09" } ]
);

db.grantRolesToUser(
  "MONGO_AUDITOR_EP1_EQUIPO_09",
  [ { role: "MONGO_AUDIT_EP1_EQUIPO_09", db: "db_ep1_equipo_09" } ]
);

// Ver usuarios con sus roles asignados
show users