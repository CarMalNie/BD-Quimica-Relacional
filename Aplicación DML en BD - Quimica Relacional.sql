
-- MANIPULACIÓN DE DATOS (DML). -- 
-- (Asegurar la "integridad referencial al actualizar o eliminar registros relacionados)

-- Fundamental/Inicial: Adición de datos en todas las tablas que componen esta estructura de base de datos.

-- Elementos Químicos (Tabla Padre)
INSERT INTO elementos_quimicos (nombre_elemento, simbolo_elemento, numero_atomico_elemento, grupo_elemento, peso_atomico_elemento) VALUES
('Hidrógeno', 'H', 1, 1, 1.0080),
('Carbono', 'C', 6, 14, 12.0110),
('Oxígeno', 'O', 8, 16, 15.9990),
('Sodio', 'Na', 11, 1, 22.9897),
('Cloro', 'Cl', 17, 17, 35.4530),
('Hierro', 'Fe', 26, 8, 55.8450),
('Uranio', 'U', 92, 3, 238.0289),
('Litio', 'Li', 3, 1, 6.9400);

-- Compuestos Químicos (Tabla Padre)
INSERT INTO compuestos_quimicos (nombre_compuesto, formula_compuesto, peso_molecular_compuesto, fecha_registro_compuesto) VALUES
('Agua', 'H2O', 18.0153, NOW()),
('Dióxido de Carbono', 'CO2', 44.0090, NOW()),
('Cloruro de Sodio', 'NaCl', 58.4400, NOW()),
('Glucosa', 'C6H12O6', 180.1560, NOW()),
('Metano', 'CH4', 16.0430, NOW());

-- Aplicaciones (Tabla Padre)
INSERT INTO aplicaciones (nombre_aplicacion, industria_aplicacion) VALUES
('Agente de limpieza', 'Doméstica'),
('Baterías de ion-litio', 'Electrónica'),
('Neutralizador de pH', 'Química Fina'),
('Catalizador industrial', 'Petroquímica'),
('Antiséptico tópico', 'Farmacéutica'),
('Material estructural', 'Aeroespacial'),
('Estabilizador de alimentos', 'Alimenticia');

-- Elementos_Compuestos (Tabla Intermedia)
-- IDs: [elementos: H=1, C=2 y O=3], [compuestos: H2O=1, CO2=2]
INSERT INTO elementos_compuestos (id_elemento, id_compuesto, cantidad_elem_en_comp) VALUES
(1, 1, 2), -- H2O: 2 H
(3, 1, 1), -- H2O: 1 O
(2, 2, 1), -- CO2: 1 C
(3, 2, 2); -- CO2: 2 O

-- Elementos_Aplicaciones (Tabla Intermedia)
-- IDs: [elementos: Litio(Li)=8, Sodio(Na)=4 y Cloro(Cl)=5], [aplicaciones: Baterías=2 y Antiséptico=5]
INSERT INTO elementos_aplicaciones (id_elemento, id_aplicacion, notas_uso) VALUES
(8, 2, 'Fundamental como cátodo en baterías de alta densidad.'),
(4, 3, 'Usado en forma de hidróxido para ajuste de pH.'),
(5, 5, 'Usado como desinfectante en forma de soluciones diluidas.'),
(2, 6, 'El Carbono es un componente principal del acero y grafito estructural.');

-- Compuestos_Aplicaciones (Tabla Intermedia)
-- IDs: [compuestos: H2O=1, CO2=2, Glucosa(C6H12O6)=4], [aplicacion: Neutralizador=3 y Estabilizador=7]
INSERT INTO compuestos_aplicaciones (id_compuesto, id_aplicacion, concentracion_minima) VALUES
(1, 1, '100%'),
(2, 3, '500 ppm'),
(4, 7, 'Min. 5% peso/peso');

-- 1.	Actualizar un atributo en una sola tabla basándose en un identificador específico.

-- 		Objetivo: Corregir el peso atómico del elemento con símbolo 'H' (Hidrógeno).

UPDATE elementos_quimicos
SET peso_atomico_elemento = 1.0079
WHERE simbolo_elemento = 'H';

-- 2.	Actualizar el campo de industria para todas las aplicaciones cuyo nombre contenga la palabra 'tópico'.

-- 		Objetivo: Recategorizar las aplicaciones que son tópicas a la industria 'Sanidad y Cuidado'.

UPDATE aplicaciones
SET industria_aplicacion = 'Sanidad y Cuidado'
WHERE nombre_aplicacion LIKE '%tópico%';

-- 3. 	Eliminar un elemento que no participa en ninguna otra tabla.

-- 		Objetivo:	Eliminar el elemento 'Uranio'. Si el ID de Uranio no se usó en Elementos_Compuestos o Elementos_Aplicaciones,
--      			esta eliminación es simple. Si se usó, las restricciones ON DELETE CASCADE eliminarán automáticamente las referencias de
--      			ese elemento en las tablas intermedias.

 -- Asumiendo que el ID de Uranio es 7 (revisar la tabla)
DELETE FROM elementos_quimicos
WHERE id_elemento = 7;

-- 4.	Actualizar el peso molecular de un compuesto específico, demostrando un cálculo que
-- 		debe hacerse manualmente (o que en un sistema real sería calculado al insertar Elementos_Compuestos).

-- 		Objetivo: Recalcular el peso molecular del CO2 (Dióxido de Carbono) con un valor corregido.

-- Asumiendo que el ID del CO2 es 2 (revisar la tabla)
UPDATE compuestos_quimicos
SET peso_molecular_compuesto = 44.01
WHERE id_compuesto = 2;

-- 5. Eliminar todas las relaciones de una tabla intermedia basándose en un criterio de una tabla padre.

-- Objetivo: Eliminar todos los usos (relaciones) del elemento Carbono (C) en la tabla elementos_aplicaciones.

DELETE EA
FROM elementos_aplicaciones EA
JOIN elementos_quimicos EQ ON EA.id_elemento = EQ.id_elemento
WHERE EQ.simbolo_elemento = 'C';
