
-- MANIPULACIÓN DE DATOS (DML). -- 
-- (Asegurar la "integridad referencial al actualizar o eliminar registros relacionados)

-- Fundamental/Inicial: Adición de datos en todas las tablas que componen esta estructura de base de datos.

-- Tabla Industrias (Tabla Padre)
INSERT INTO industrias (nombre_industria) VALUES
('Doméstica'),         -- id_industria = 1
('Electrónica'),       -- id_industria = 2
('Química Fina'),      -- id_industria = 3
('Petroquímica'),      -- id_industria = 4
('Farmacéutica'),      -- id_industria = 5
('Aeroespacial'),      -- id_industria = 6
('Alimenticia'),       -- id_industria = 7
('Sanidad y Cuidado'); -- id_industria = 8

-- Tabla Elementos Químicos (Tabla Padre)
-- IDs: [H=1, C=2, O=3, Na=4, Cl=5, Fe=6, U=7, Li=8]
INSERT INTO elementos_quimicos (nombre_elemento, simbolo_elemento, numero_atomico_elemento, peso_atomico_elemento) VALUES
('Hidrógeno', 'H', 1, 1.0080), 
('Carbono', 'C', 6, 12.0110),   
('Oxígeno', 'O', 8, 15.9990),   
('Sodio', 'Na', 11, 22.9897),   
('Cloro', 'Cl', 17, 35.4530),   
('Hierro', 'Fe', 26, 55.8450),  
('Uranio', 'U', 92, 238.0289),  
('Litio', 'Li', 3, 6.9400);

-- Tabla Compuestos Químicos (Tabla Padre)
INSERT INTO compuestos_quimicos (nombre_compuesto, formula_compuesto, peso_molecular_compuesto, fecha_registro_compuesto) VALUES
('Agua', 'H2O', 18.0153, NOW()),
('Dióxido de Carbono', 'CO2', 44.0090, NOW()),
('Cloruro de Sodio', 'NaCl', 58.4400, NOW()),
('Glucosa', 'C6H12O6', 180.1560, NOW()),
('Metano', 'CH4', 16.0430, NOW());

-- Tabla Aplicaciones
INSERT INTO aplicaciones (id_industria, nombre_uso) VALUES
(1, 'Agente de limpieza'),             
(2, 'Baterías de ion-litio'),          
(3, 'Neutralizador de pH'),             
(5, 'Antiséptico tópico'),             
(7, 'Estabilizador de alimentos');

-- Tabla detalles_elementos (Relación 1:1)
-- El valor de id_elemento DEBE coincidir con la PK de la tabla elementos_quimicos (Ej: 1, 3, 8)
INSERT INTO detalles_elementos (id_elemento, grupo_elemento, periodo_elemento, categoria_elemento, electronegatividad, afinidad_electronica, energia_de_ionizacion, radio_covalente, descripcion_elemento) VALUES
(1, 1, 1, 'No Metal', 2.20, -72.8, 1312.0, 0.37, 'El más ligero y abundante del universo.'),  -- H (id=1)
(3, 16, 2, 'No Metal', 3.44, 141.0, 1313.9, 0.73, 'Esencial para la vida y la combustión.'),  -- O (id=3)
(8, 1, 2, 'Metal Alcalino', 0.98, 59.6, 520.2, 1.67, 'Usado en aleaciones y baterías.'),      -- Li (id=8)
(5, 17, 3, 'Halógeno', 3.16, 349.0, 1251.2, 1.02, 'Usado como desinfectante y blanqueador.'); -- Cl (id=5)

-- Tabla Elementos_Compuestos (Tabla Intermedia - Relaciona M:M)
-- IDs: [elementos: H=1, C=2 y O=3], [compuestos: H2O=1, CO2=2]
INSERT INTO elementos_compuestos (id_elemento, id_compuesto, cantidad_elem_en_comp) VALUES
(1, 1, 2), -- H2O: 2 H
(3, 1, 1), -- H2O: 1 O
(2, 2, 1), -- CO2: 1 C
(3, 2, 2); -- CO2: 2 O

-- Tabla Elementos_Aplicaciones (Tabla Intermedia - Relaciona M:M)
-- IDs: [elementos: Litio(Li)=8, Sodio(Na)=4, Cloro(Cl)=5, Carbono(C)=2], [aplicaciones: Baterías=2, Neutralizador=3 y Antiséptico=4]
INSERT INTO elementos_aplicaciones (id_elemento, id_aplicacion, notas_uso) VALUES
(8, 2, 'Fundamental como cátodo en baterías de alta densidad.'),
(4, 3, 'Usado en forma de hidróxido para ajuste de pH.'),
(5, 4, 'Usado como desinfectante en forma de soluciones diluidas.'),
(2, 1, 'El Carbono es un componente principal del acero y grafito estructural.');

-- Tabla Compuestos_Aplicaciones (Tabla Intermedia - Relaciona M:M)
-- IDs: [compuestos: Agua(H2O)=1, Dióxido de Carbono(CO2)=2, Glucosa(C6H12O6)=4], [aplicacion: Agente limpieza=1, Neutralizador=3 y Estabilizador=5]
INSERT INTO compuestos_aplicaciones (id_compuesto, id_aplicacion, concentracion_minima) VALUES
(1, 1, '100%'),
(2, 3, '500 ppm'),
(4, 5, 'Min. 5% peso/peso');


-- 1.	Actualizar un atributo en una sola tabla basándose en un identificador específico.

-- 		Objetivo: Corregir el peso atómico del elemento con símbolo 'H' (Hidrógeno).

UPDATE elementos_quimicos
SET peso_atomico_elemento = 1.0079
WHERE simbolo_elemento = 'H';

-- Para comprobar este UPDATE consultar lo siguiente:
SELECT
    nombre_elemento,
    simbolo_elemento,
    peso_atomico_elemento
FROM
    elementos_quimicos
WHERE
    simbolo_elemento = 'H';


-- 2.	Actualizar el campo de industria para todas las aplicaciones cuyo nombre contenga la palabra 'tópico'.

-- 		Objetivo: Recategorizar las aplicaciones que son tópicas (Ej: "Antiséptico tópico") a la industria 'Sanidad y Cuidado',
--                usando el ID de la industria.

-- Se obtiene la ID de la industria de destino
SET SQL_SAFE_UPDATES = 0; -- Se desactiva la restricción de seguridad
SET @id_sanidad = (SELECT id_industria FROM industrias WHERE nombre_industria = 'Sanidad y Cuidado');

-- Se actualiza la FK (id_industria) en la tabla aplicaciones
UPDATE aplicaciones
SET id_industria = @id_sanidad
WHERE nombre_uso LIKE '%tópico%';

-- Para comprobar este UPDATE consultar lo siguiente:
SELECT
    A.nombre_uso,
    I.nombre_industria,
    A.id_industria
FROM
    aplicaciones A
JOIN
    industrias I ON A.id_industria = I.id_industria
WHERE
    A.nombre_uso LIKE '%tópico%';


-- 3. 	Eliminar un elemento que no participa en ninguna otra tabla.

-- 		Objetivo:	Eliminar el elemento 'Uranio'.

-- 	Se usa el símbolo UNIQUE para identificarlo. Las restricciones ON DELETE CASCADE implementadas en las tablas intermedias 
--  (detalles_elementos, elementos_compuestos, elementos_aplicaciones) asegurarán que todas las referencias a este elemento sean eliminadas
--  automáticamente de las tablas dependientes, manteniendo la integridad referencial.

 -- Asumiendo que el ID de Uranio es 7 (revisar la tabla)
DELETE FROM elementos_quimicos
WHERE nombre_elemento = 'Uranio';

-- Para comprobar este DELETE (más especifico ON DELETE CASCADE) consultar lo siguiente:

-- Muestra todos los elementos y sus ID de detalle, probando que el Uranio desapareció
-- y que las FKs de los demás elementos (ej: Cloro, Litio) permanecen intactas.

SELECT
    EQ.nombre_elemento,
    EQ.id_elemento,
    DE.id_detalle,
    DE.grupo_elemento -- Muestra una propiedad de la fila eliminada
FROM
    elementos_quimicos EQ
LEFT JOIN
    detalles_elementos DE ON EQ.id_elemento = DE.id_elemento
ORDER BY
    EQ.id_elemento;


-- 4.	Actualizar el peso molecular de un compuesto específico, demostrando un cálculo que
-- 		debe hacerse manualmente (o que en un sistema real sería calculado al insertar Elementos_Compuestos).

-- 		Objetivo: Recalcular el peso molecular del CO2 (Dióxido de Carbono) con un valor corregido.

UPDATE compuestos_quimicos
SET peso_molecular_compuesto = 44.01
WHERE formula_compuesto = 'CO2';

-- Para comprobar este UPDATE consultar lo siguiente:
SELECT
    formula_compuesto,
    peso_molecular_compuesto
FROM
    compuestos_quimicos
WHERE
    formula_compuesto = 'CO2';


-- 5. Eliminar todas las relaciones de una tabla intermedia basándose en un criterio de una tabla padre.

-- Objetivo: Eliminar todos los usos (relaciones) del elemento Carbono (C) en la tabla intermedia elementos_aplicaciones.
-- 			 Esto demuestra el uso de JOIN en un DELETE.

DELETE EA
FROM elementos_aplicaciones EA
JOIN elementos_quimicos EQ ON EA.id_elemento = EQ.id_elemento
WHERE EQ.simbolo_elemento = 'C';

-- Para comprobar este DELETE consultar lo siguiente:
SELECT
    EQ.nombre_elemento AS Elemento,
    A.nombre_uso AS Aplicacion,
    EA.notas_uso
FROM
    elementos_aplicaciones EA
JOIN
    elementos_quimicos EQ ON EA.id_elemento = EQ.id_elemento
JOIN
    aplicaciones A ON EA.id_aplicacion = A.id_aplicacion
ORDER BY
    EQ.nombre_elemento;