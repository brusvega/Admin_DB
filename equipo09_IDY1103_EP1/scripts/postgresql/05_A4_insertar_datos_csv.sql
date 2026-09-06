-- =====================================================
-- EQUIPO_09 - IDY1103 - EP1
-- PASO A.4 (parte 2): Insertar registros a las tres tablas
-- =====================================================

-- Script generado automaticamente para cargar los 35 .csv a las 3 tablas: 
-- CLASE_MOV_EP1_EQUIPO_09, CENTROS_EP1_EQUIPO_09 y MOV_EP1_EQUIPO_09

-- 1. 'clase_mov.csv', 'centros.csv' y este archivo '05_A4_insertar_datos_csv.sql' deben estar en C:\datos
-- 2. Los 33 .csv de mov deben estar dentro de una carpeta así C:\datos\mov

-- 3. Ejecutar solo una vez en psql tool con: \i 'C:/datos/05_A4_insertar_datos_csv.sql'

\copy public."CLASE_MOV_EP1_EQUIPO_09" FROM 'C:/datos/clase_mov.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')

\copy public."CENTROS_EP1_EQUIPO_09" FROM 'C:/datos/centros.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')

\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_pa1.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso1.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso2.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso3.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso4.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso5.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso6.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso7.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso8.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso9.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso10.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso11.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso12.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso13.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso14.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso15.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso16.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso17.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso18.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso19.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso20.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso21.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso22.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso23.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso24.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso25.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso26.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso27.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso28.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso29.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso30.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso31.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')
\copy public."MOV_EP1_EQUIPO_09" FROM 'C:/datos/mov/mov_paso32.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8')

