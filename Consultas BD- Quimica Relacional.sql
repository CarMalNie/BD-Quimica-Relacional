
-- CONSULTAS BÁSICAS y COMPLEJAS. --

-- 1.	Recupera todos los Elementos Químicos que pertenecen al Grupo 17 (Halógenos) y los ordena por número atómico.
--      Demuestra la selección simple y el filtrado por un criterio.

SELECT
    nombre_elemento,
    simbolo_elemento,
    numero_atomico_elemento
FROM
    elementos_quimicos EQ
JOIN
	detalles_elementos DE ON EQ.id_elemento = DE.id_elemento -- UNION con la tabla de detalles (relación 1:1)
WHERE
    DE.grupo_elemento = 17
ORDER BY
    EQ.numero_atomico_elemento ASC;
    
-- 2. 	Obtiene el nombre y la fórmula de los compuestos utilizados en la industria 'Doméstica',
-- 		demostrando la unión entre las tablas compuestas (intermedias) y la tabla que relaciona 1:M.

SELECT
    CQ.nombre_compuesto,
    CQ.formula_compuesto,
    I.nombre_industria
FROM
    compuestos_quimicos CQ
JOIN
    compuestos_aplicaciones CA ON CQ.id_compuesto = CA.id_compuesto
JOIN
    aplicaciones A ON CA.id_aplicacion = A.id_aplicacion
JOIN
    industrias I ON A.id_industria = I.id_industria
WHERE
    I.nombre_industria = 'Doméstica';
    
-- 3.	Cuenta cuántas aplicaciones diferentes tiene cada industria y solo muestra aquellas 
-- 		industrias que tienen una o más de una aplicación registrada (si la tuvieran).

SELECT
    I.nombre_industria,
    COUNT(A.id_aplicacion) AS total_aplicaciones
FROM
    aplicaciones A
JOIN
	industrias I ON A.id_industria = I.id_industria
GROUP BY
    I.nombre_industria
HAVING
    COUNT(A.id_aplicacion) >= 1
ORDER BY
    total_aplicaciones DESC;
    
-- 4.	Calcula el número total de átomos que componen un compuesto específico (ej., el Agua).
--      Demuestra el uso de SUM() sobre las cantidades de los elementos (subíndices) en la estructura M:M.

SELECT
    CQ.nombre_compuesto,
    SUM(EC.cantidad_elem_en_comp) AS total_de_atomos
FROM
    compuestos_quimicos CQ
JOIN
    elementos_compuestos EC ON CQ.id_compuesto = EC.id_compuesto
WHERE
    CQ.nombre_compuesto = 'Agua' -- Usamos Agua (H2O) que ya tiene datos insertados
GROUP BY
    CQ.nombre_compuesto;
    
-- 5. 	Identifica los nombres de las aplicaciones que utilizan un elemento específico (ej., 'Litio')
-- 		y que están categorizadas en la industria 'Electrónica'.

SELECT DISTINCT
    A.nombre_uso,
    I.nombre_industria
FROM
    elementos_aplicaciones EA 
JOIN
    elementos_quimicos EQ ON EA.id_elemento = EQ.id_elemento
JOIN
    aplicaciones A ON EA.id_aplicacion = A.id_aplicacion
JOIN
    industrias I ON A.id_industria = I.id_industria 
WHERE
    EQ.nombre_elemento = 'Litio' AND I.nombre_industria = 'Electrónica'
ORDER BY
    A.nombre_uso;
