
-- DEFINICIÓN DE DATOS (DDL). -- 
-- (Asegurar la "integridad referencial al actualizar o eliminar registros relacionados)

-- 1.	Agrega una columna descriptiva opcional a una tabla padre.

-- 		Objetivo:	Añadir un campo de texto largo para una descripción
-- 					o notas generales sobre el elemento químico.

ALTER TABLE elementos_quimicos
ADD COLUMN descripcion_general TEXT NULL;

-- 2.	Modificar una columna existente, cambiando su tipo de dato o una de sus restricciones.

-- 		Objetivo:	Modificar una columna existente,
-- 					cambiando su tipo de dato o una de sus restricciones.

ALTER TABLE aplicaciones
MODIFY industria_aplicacion VARCHAR(100) NOT NULL;

-- 3.	Añadir una restricción CHECK con nombre a una columna existente para
--      imponer una nueva regla de negocio.

-- 		Objetivo:	Asegurar que los nombres de los compuestos (nombre_compuesto)
--    				tengan un mínimo de 3 caracteres.

ALTER TABLE compuestos_quimicos
ADD CONSTRAINT chk_nombre_compuesto_longitud CHECK (LENGTH(nombre_compuesto) >= 3);

-- 4.	Eliminar una columna completa de una tabla. Esta es una operación de alto impacto.

-- 		Objetivo:	Eliminar la columna notas_uso de la tabla elementos_aplicaciones porque
-- 				 	se ha decidido que la información no es necesaria.

ALTER TABLE elementos_aplicaciones
DROP COLUMN notas_uso;

-- 5.	Eliminar una tabla completa de la base de datos. Esta es la operación DDL más destructiva.

-- 		Objetivo:	Eliminar la tabla aplicaciones y, debido a las restricciones ON DELETE CASCADE en las tablas intermedias,
-- 					todas las filas en elementos_aplicaciones y compuestos_aplicaciones que dependan de ella también se eliminarán.

DROP TABLE aplicaciones;