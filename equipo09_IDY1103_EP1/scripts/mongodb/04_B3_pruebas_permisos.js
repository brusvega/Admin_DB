// =====================================================
// EQUIPO_09 - IDY1103 - EP1
// Script 04: Pruebas de permisos (permitido/denegado)
// Conectar con mongosh usando cada usuario
// =====================================================

/*
IMPORTANTE

Para que las pruebas de permisos se vean reflejadas correctamente,
hay que habilitar la autorización en el archivo de configuración (mongod.conf)

1. Abre el archivo de configuración de MongoDB 
(en Windows suele ubicarse en 
C:\Program Files\MongoDB\Server\<versión>\bin\mongod.cfg)
y añade o descomenta el bloque security:

  security:
    authorization: enabled

2. Reiniciar el servicio de MongoDB

3. Crear nueva conexión e ingresar URI con nombre y contraseña de usuario a probar:
    mongodb://nombre_usuario:contraseña@localhost:27017/db_ep1_equipo_09?authSource=db_ep1_equipo_09

4. Cuando se terminen de hacer las pruebas, dejar como estaba el bloque security en mongod.cfg
*/

// --- Conectado como MONGO_USER_1_EP1_EQUIPO_09 ---
mongodb://MONGO_USER_1_EP1_EQUIPO_09:MUser01$EP1@localhost:27017/db_ep1_equipo_09?authSource=db_ep1_equipo_09

// esperado: OK
db.COL_MOV_EP1_EQUIPO_09.find();
db.COL_MOV_EP1_EQUIPO_09.aggregate([{ $match: { "Material": "AA0004" } }]);
db.COL_CLASE_MOV_EP1_EQUIPO_09.find();
db.COL_CLASE_MOV_EP1_EQUIPO_09.aggregate([{ $match: { "Codigo": 101 } }]);
db.COL_CENTROS_EP1_EQUIPO_09.find();
db.COL_CENTROS_EP1_EQUIPO_09.aggregate([{ $match: { "Codigo": "BPAP" } }]);

// esperado: ERROR no autorizado
db.COL_MOV_EP1_EQUIPO_09.insertOne({ "Material": "AA0004","Clase de movimiento": "951" });
db.COL_MOV_EP1_EQUIPO_09.updateOne(
  { "Documento material": "4943917528" },
  { $set: { "Material": "AA0004" } }
);
db.COL_CLASE_MOV_EP1_EQUIPO_09.insertOne({ "Codigo": 101, "Descripcion": "EM Entr.mercancías" });
db.COL_CLASE_MOV_EP1_EQUIPO_09.updateOne(
  { "Codigo": 101 },
  { $set: { "Descripcion": "Anul.EM para pedido" } }
);
db.COL_CENTROS_EP1_EQUIPO_09.insertOne({ "Codigo": "BPAP", "Descripcion": "ANATOMIA" });
db.COL_CENTROS_EP1_EQUIPO_09.updateOne(
  { "Codigo": "BPAP" },
  { $set: { "Descripcion": "DUOC" } }
);

// --- Conectado como MONGO_AUDITOR_EP1_EQUIPO_09 ---
mongodb://MONGO_AUDITOR_EP1_EQUIPO_09:MAudit01$EP1@localhost:27017/db_ep1_equipo_09?authSource=db_ep1_equipo_09

// esperado: OK
db.COL_LOG_ACCESO_EP1_EQUIPO_09.find();  

// esperado: ERROR no autorizado
db.COL_MOV_EP1_EQUIPO_09.insertOne({ "Material": "AA0004","Clase de movimiento": "951" });
db.COL_MOV_EP1_EQUIPO_09.updateOne(
  { "Documento material": "4943917528" },
  { $set: { "Material": "AA0004" } }
);
db.COL_CLASE_MOV_EP1_EQUIPO_09.insertOne({ "Codigo": 101, "Descripcion": "EM Entr.mercancías" });
db.COL_CLASE_MOV_EP1_EQUIPO_09.updateOne(
  { "Codigo": 101 },
  { $set: { "Descripcion": "Anul.EM para pedido" } }
);
db.COL_CENTROS_EP1_EQUIPO_09.insertOne({ "Codigo": "BPAP", "Descripcion": "ANATOMIA" });
db.COL_CENTROS_EP1_EQUIPO_09.updateOne(
  { "Codigo": "BPAP" },
  { $set: { "Descripcion": "DUOC" } }
);