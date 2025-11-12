
-- CONSULTAS BÁSICAS y COMPLEJAS. --

-- 1.	Recupera todos los Elementos Químicos que pertenecen al Grupo 17 (Halógenos) y los ordena por número atómico.
-- Demuestra la selección simple y el filtrado por un criterio.

SELECT
    nombre_elemento,
    simbolo_elemento,
    numero_atomico_elemento
FROM
    elementos_quimicos
WHERE
    grupo_elemento = 17
ORDER BY
    numero_atomico_elemento ASC;
    
-- 2. Obtiene el nombre y la fórmula de los compuestos utilizados en la industria 'Farmacéutica',
-- demostrando la unión entre las tablas padres a través de la tabla intermedia compuestos_aplicaciones.

SELECT
    CQ.nombre_compuesto,
    CQ.formula_compuesto,
    A.nombre_aplicacion
FROM
    compuestos_quimicos CQ
JOIN
    compuestos_aplicaciones CA ON CQ.id_compuesto = CA.id_compuesto
JOIN
    aplicaciones A ON CA.id_aplicacion = A.id_aplicacion
WHERE
    A.industria_aplicacion = 'Farmacéutica';
    
-- 3. Cuenta cuántas aplicaciones diferentes tiene cada industria en la base de datos,
-- pero solo muestra aquellas industrias que tienen más de dos aplicaciones registradas.

SELECT
    industria_aplicacion,
    COUNT(id_aplicacion) AS total_aplicaciones
FROM
    aplicaciones
GROUP BY
    industria_aplicacion
HAVING
    COUNT(id_aplicacion) > 2
ORDER BY
    total_aplicaciones DESC;
    
-- 4. Calcula el peso molecular total de todos los elementos que componen un compuesto específico (ej., la Glucosa),
-- usando la tabla elementos_compuestos y sumando los pesos atómicos.
-- Esto demuestra el uso de SUM() sobre una unión.

SELECT
    CQ.nombre_compuesto,
    SUM(EQ.peso_atomico_elemento * EC.cantidad_elem_en_comp) AS peso_molecular_calculado
FROM
    compuestos_quimicos CQ
JOIN
    elementos_compuestos EC ON CQ.id_compuesto = EC.id_compuesto
JOIN
    elementos_quimicos EQ ON EC.id_elemento = EQ.id_elemento
WHERE
    CQ.nombre_compuesto = 'Glucosa'
GROUP BY
    CQ.nombre_compuesto;
    
-- 5. Identifica los nombres de las aplicaciones que utilizan un elemento específico (ej., 'Sodio')
-- y que están categorizadas en la industria 'Electrónica'.
-- Esta consulta une dos de las tres relaciones M:M para un filtro cruzado.

SELECT DISTINCT
    A.nombre_aplicacion,
    A.industria_aplicacion
FROM
    aplicaciones A
JOIN
    elementos_aplicaciones EA ON A.id_aplicacion = EA.id_aplicacion
JOIN
    elementos_quimicos EQ ON EA.id_elemento = EQ.id_elemento
WHERE
    EQ.nombre_elemento = 'Sodio'
    AND A.industria_aplicacion = 'Electrónica'
ORDER BY
    A.nombre_aplicacion;
