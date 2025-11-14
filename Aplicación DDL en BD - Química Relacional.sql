
-- DEFINICIÓN DE DATOS (DDL). -- 
-- (Asegurar la "integridad referencial al actualizar o eliminar registros relacionados)

-- 1.	Agrega una columna descriptiva opcional a una tabla padre.

-- 		Objetivo:	Ampliar la información del Elemento Químico añadiendo un campo de texto largo 
--           		para notas o una descripción general que no es fundamental.

ALTER TABLE elementos_quimicos
ADD COLUMN descripcion_general TEXT NULL;

-- Para comprobar este ALTER ADD COLUMN consultar lo siguiente:
SELECT * FROM elementos_quimicos;


-- 2.	Modificar una columna existente, cambiando su tipo de dato o una de sus restricciones.

-- 		Objetivo:	Aumentar la longitud del campo que almacena el nombre de la industria de la aplicación 
--           		para permitir descripciones más detalladas (Ej: 'Química Industrial Avanzada').

ALTER TABLE aplicaciones
MODIFY nombre_uso VARCHAR(100) NOT NULL;

-- Para comprobar este ALTER MODIFY consultar lo siguiente:
DESCRIBE aplicaciones;


-- 3.	Añadir una restricción CHECK con nombre a una columna existente para
--      imponer una nueva regla de negocio.

-- 		Objetivo:	Asegurar la integridad de la entrada de datos imponiendo que el nombre formal de
--           		los compuestos (nombre_compuesto) tenga un mínimo de 3 caracteres, previniendo entradas triviales.

ALTER TABLE compuestos_quimicos
ADD CONSTRAINT chk_nombre_compuesto_longitud CHECK (LENGTH(nombre_compuesto) >= 3);

-- Para comprobar este ALTER ADD CONSTRAINT consultar lo siguiente:
SELECT 
    CONSTRAINT_NAME, 
    CONSTRAINT_TYPE
FROM 
    information_schema.TABLE_CONSTRAINTS
WHERE 
    TABLE_SCHEMA = 'quimica_relacional' 
    AND TABLE_NAME = 'compuestos_quimicos'
    AND CONSTRAINT_TYPE = 'CHECK';


-- 4.	Eliminar una columna completa de una tabla. Esta es una operación de alto impacto.

-- 		Objetivo:	Remover el campo notas_uso de la tabla elementos_aplicaciones. 
--           		Esto simplifica la estructura de la relación M:M si la información contextual ya no se considera vital.

ALTER TABLE elementos_aplicaciones
DROP COLUMN notas_uso;

-- Para comprobar este ALTER DROP COLUMN consultar lo siguiente:
DESCRIBE elementos_aplicaciones;


-- 5.	Eliminar una tabla completa de la base de datos. Esta es la operación DDL más destructiva.

-- 		Objetivo:	Eliminar la tabla aplicaciones. Esta operación activará las restricciones ON DELETE CASCADE 
--           		en cascada, eliminando automáticamente todas las filas dependientes en las tablas M:M: 
--           		elementos_aplicaciones y compuestos_aplicaciones.

-- Para ello primero se deben eliminar sus tablas hijas, las cuales son:

-- Elimina las relaciones de Elementos con Aplicaciones
DROP TABLE elementos_aplicaciones; 

-- Elimina las relaciones de Compuestos con Aplicaciones
DROP TABLE compuestos_aplicaciones;

-- Finalmente se elimina la respectiva Tabla Padre
DROP TABLE aplicaciones;

-- Para comprobar este DROP TABLE consultar lo siguiente:
SHOW TABLES;
