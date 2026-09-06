# EP1 - IDY1103 - EQUIPO_09

## Orden de ejecución

### PostgreSQL (`scripts/postgresql/`) — alineado al checklist del Ítem A

| Script | Punto del checklist | Qué hace |
|---|---|---|
| `01_A1_crear_base_datos.sql` | A.1 | Crea `db_ep1_equipo_09` (conectado como superusuario) |
| `02_A2_crear_usuarios.sql` | A.2 | Crea los 4 usuarios con sus contraseñas |
| `03_A3_crear_roles.sql` | A.3 (pto 3) | Crea ROL_READ/WRITE/AUDIT y los asigna a los usuarios |
| `04_A4_crear_tablas_indice_vista.sql` | A.4 (pto 5) | Crea CLASE_MOV, CENTROS, MOV, el índice `idx_mat_ep1_equipo_09` y la vista |
| `05_A4_insertar_datos_prueba.sql` | A.4 (pto 6) | Inserta datos de prueba — **aquí va la captura del punto 6** |
| `06_A3_asignar_permisos.sql` | A.3 (pto 4) | GRANT de mínimo privilegio (se ejecuta después de A.4 porque necesita que las tablas ya existan) |
| `07_A5_pruebas_permisos.sql` | A.5 (pto 7) | Pruebas permitido/denegado — **conectarse con cada usuario y capturar cada resultado** |
| `08_C1_security_policies.sql` | C.1 | Políticas de contraseñas (expiración, complejidad, bloqueo) |
| `09_C2_C3_audit_and_encryption.sql` | C.2 / C.3 | Auditoría, tabla de bitácora y cifrado |
| `10_C4_backup.sh` | C.4 | Respaldo con `pg_dump` |
| `11_C4_monitoring.sql` | C.4 | Monitoreo básico |

> **Nota:** en la numeración del checklist, A.3 punto 4 (asignar permisos) aparece antes que A.4, pero en la ejecución real debe ir **después**, porque no se puede otorgar `GRANT` sobre tablas que aún no existen. Esto queda explicado en el propio script 06 y deben mencionarlo en el informe como una precisión técnica del orden de implementación.

### MongoDB (`scripts/mongodb/`)
1. `01_create_db_collections.js`
2. `02_create_users_roles.js`
3. `03_insert_test_data.js`
4. `04_test_permissions.js` — igual que en PostgreSQL, por usuario
5. `05_security_config.txt` — se aplica en `mongod.conf`, no con mongosh
6. `06_backup.sh`
7. `07_monitoring.js`

## Matriz Rol x Permiso (para el informe y la presentación)

| Rol | SELECT/find | INSERT/UPDATE | DDL (DROP/CREATE) | Alcance |
|---|---|---|---|---|
| APP_USER_1 / MONGO_USER_1 | ✅ Todo | ❌ Denegado | ❌ Denegado | Solo lectura |
| APP_USER_2 | ✅ Todo | ✅ Solo PEDIDOS y PAGOS | ❌ Denegado | Lectura + escritura controlada |
| AUDITOR | ✅ Todo + bitácora | ❌ Denegado | ❌ Denegado | Solo lectura/auditoría |
| APP_ADMIN | ✅ Todo | ✅ Todo | ✅ Sobre objetos del esquema (no del motor) | Administración de objetos |

## Checklist de entregables pendientes (ustedes deben generar)

- [ ] `informe.pdf` — con introducción, matriz rol×permiso, justificación de decisiones, políticas de seguridad y conclusiones
- [ ] Capturas de pantalla de **cada** prueba del script `08_test_permissions.sql` (PostgreSQL) y `04_test_permissions.js` (Mongo) → guardar en `/evidencias`
- [ ] Captura de la ejecución del respaldo (`09_backup.sh` / `06_backup.sh`)
- [ ] Captura del monitoreo (`10_monitoring.sql` / `07_monitoring.js`)
- [ ] Ajustar `id_cliente`/`id_pedido` de los datos de prueba si su motor no usa `SERIAL` (por ejemplo, si migran a MySQL u Oracle)
- [ ] Comprimir todo como `equipo09_IDY1103_EP1.zip`
- [ ] (Opcional) `presentacion.pptx` con máximo 15 diapositivas

## Notas importantes

- Las contraseñas están fijadas por el enunciado — **no las cambien**, ya que la pauta las pide tal cual.
- Si el motor exige otro patrón de contraseña, deben **documentar el ajuste y justificarlo** en el informe (así lo permite el enunciado).
- Las limitaciones nativas de PostgreSQL (bloqueo por intentos fallidos) y de MongoDB Community (expiración, bloqueo) ya están documentadas en los scripts `06_security_policies.sql` y `05_security_config.txt` con su control compensatorio — usen ese mismo texto como base para el informe.
