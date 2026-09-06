import csv
import os
import time
from pathlib import Path
from pymongo import MongoClient

# ============================================================
# CONFIGURACIÓN
# ============================================================

CARPETA = Path(r"C:\datos\mov")

MONGO_URI = "mongodb://localhost:27017"
BASE_DATOS = "db_ep1_equipo_09"
COLECCION = "mov"

# Cantidad de documentos que se acumulan antes de insertar
BATCH_SIZE = 5000

# ============================================================
# CONEXIÓN A MONGODB
# ============================================================

print("=" * 70)
print("IMPORTACIÓN MASIVA DE CSV -> MONGODB")
print("=" * 70)
print()

print("Conectando a MongoDB...")

client = MongoClient(MONGO_URI)

# Verificar conexión
client.admin.command("ping")

db = client[BASE_DATOS]
collection = db[COLECCION]

print("Conexión OK")
print(f"Base de datos : {BASE_DATOS}")
print(f"Colección    : {COLECCION}")
print(f"Carpeta CSV  : {CARPETA}")
print()

# ============================================================
# BUSCAR ARCHIVOS
# ============================================================

archivos = sorted(CARPETA.glob("*.csv"))

if not archivos:
    print("ERROR: No se encontraron archivos CSV.")
    input("Presiona ENTER para salir...")
    raise SystemExit(1)

print(f"Archivos encontrados: {len(archivos)}")
print()

total_documentos = 0
inicio_total = time.time()

# ============================================================
# PROCESAR CADA CSV
# ============================================================

for numero_archivo, archivo in enumerate(archivos, start=1):

    print("=" * 70)
    print(f"[{numero_archivo}/{len(archivos)}] {archivo.name}")
    print("=" * 70)

    inicio_archivo = time.time()
    documentos_archivo = 0
    batch = []

    try:
        with open(
            archivo,
            "r",
            encoding="utf-8-sig",
            newline="",
            errors="replace"
        ) as f:

            lector = csv.DictReader(
                f,
                delimiter=";",
                quotechar='"'
            )

            # Verificar encabezados
            if not lector.fieldnames:
                print("ERROR: El archivo no tiene encabezado.")
                continue

            print(f"Columnas detectadas: {len(lector.fieldnames)}")

            # ----------------------------------------------------
            # LEER FILA POR FILA SIN CARGAR TODO EL ARCHIVO
            # ----------------------------------------------------

            for fila in lector:

                # Eliminar espacios sobrantes de los nombres de campos
                documento = {
                    clave.strip(): valor.strip() if isinstance(valor, str) else valor
                    for clave, valor in fila.items()
                    if clave is not None
                }

                batch.append(documento)

                # Insertar cada vez que alcanzamos BATCH_SIZE
                if len(batch) >= BATCH_SIZE:

                    resultado = collection.insert_many(
                        batch,
                        ordered=False
                    )

                    cantidad = len(resultado.inserted_ids)

                    documentos_archivo += cantidad
                    total_documentos += cantidad

                    batch.clear()

                    print(
                        f"\r  Documentos archivo: {documentos_archivo:,} "
                        f"| Total: {total_documentos:,}",
                        end="",
                        flush=True
                    )

            # Insertar el último bloque
            if batch:

                resultado = collection.insert_many(
                    batch,
                    ordered=False
                )

                cantidad = len(resultado.inserted_ids)

                documentos_archivo += cantidad
                total_documentos += cantidad

                batch.clear()

        tiempo_archivo = time.time() - inicio_archivo

        print()
        print(
            f"  OK -> {documentos_archivo:,} documentos "
            f"en {tiempo_archivo:.1f} segundos"
        )

    except Exception as e:

        print()
        print(f"  ERROR procesando {archivo.name}")
        print(f"  {type(e).__name__}: {e}")
        print("  Se continúa con el siguiente archivo.")

# ============================================================
# RESULTADO FINAL
# ============================================================

tiempo_total = time.time() - inicio_total

print()
print("=" * 70)
print("IMPORTACIÓN TERMINADA")
print("=" * 70)

print(f"Archivos encontrados : {len(archivos):,}")
print(f"Documentos insertados: {total_documentos:,}")
print(f"Tiempo total         : {tiempo_total / 60:.2f} minutos")

if tiempo_total > 0:
    print(
        f"Velocidad promedio  : "
        f"{total_documentos / tiempo_total:,.0f} documentos/segundo"
    )

print()
print(f"MongoDB: {MONGO_URI}")
print(f"DB     : {BASE_DATOS}")
print(f"Colección: {COLECCION}")
print()

client.close()

input("Presiona ENTER para salir...")
