
-----

# BD Quimica Relacional: Fase 3 (Modelado y Gestión de Datos)

Este proyecto representa la **Fase 3** del proceso formativo como desarrollador full-stack, siendo la **continuación lógica y complementaria** de la calculadora avanzada de peso molecular desarrollada en la Fase 2 (Python/POO).

El objetivo de esta fase es migrar la persistencia a un diseño robusto de **Base de Datos Relacional** en $\text{MySQL}$, demostrando el dominio del **Modelado Entidad-Relación ($\text{ERD}$)** y la **Integridad Referencial**.

-----

## Estructura del Proyecto

El modelo se basa en **6 Tablas** para demostrar la gestión de la información química (Elementos, Compuestos) y sus relaciones complejas ($\text{M:M}$).

### Modelo de Entidad-Relación (ERD)

| Tabla | Tipo | Propósito Principal | Demostración de Requisito |
| :--- | :--- | :--- | :--- |
| **elementos\_quimicos** | Padre | Catálogo de la Tabla Periódica. | $\text{PK}$, $\text{UNIQUE}$ (Requisito: Describir componentes básicos) |
| **compuestos\_quimicos** | Padre | Fórmulas, Nombres y Pesos Moleculares. | $\text{PK}$, $\text{UNIQUE}$ (Requisito: Describir componentes básicos) |
| **aplicaciones** | Padre | Usos y clasificación por industria. | $\text{PK}$, $\text{UNIQUE}$ (Requisito: Características de una BD) |
| **elementos\_compuestos** | Intermedia | **Fórmula Química** (Elemento $\leftrightarrow$ Compuesto). | $\text{Relación M:M}$ (Requisito: Explicar cómo se almacenan los datos) |
| **compuestos\_aplicaciones**| Intermedia | **Uso Industrial** (Compuesto $\leftrightarrow$ Aplicación). | $\text{Relación M:M}$ (Requisito: Explicar cómo se almacenan los datos) |

-----

## Diccionario de Datos (Resumen de Restricciones)

Este resumen demuestra la **Integridad de Dominio** implementada en el $\text{DDL}$ (Lenguaje de Definición de Datos):

| Atributo | Tipo Dato | Restricciones Clave |
| :--- | :--- | :--- |
| **id\_elemento** | $\text{INT}$ | **`PRIMARY KEY`**, `NOT NULL`, `AUTO_INCREMENT` |
| **peso\_atomico\_elemento** | $\text{DECIMAL}(8, 4)$ | `NOT NULL`, `CHECK (> 0)` |
| **grupo\_elemento** | $\text{INT}$ | `NULL`, `CHECK (1-18)` |
| **peso\_molecular\_compuesto** | $\text{DECIMAL}(10, 4)$ | `NOT NULL`, `CHECK (> 0)` |
| **fecha\_registro\_compuesto** | $\text{DATETIME}$ | `NOT NULL`, `CHECK (<= NOW())` |

-----

## Demostración de Habilidades Técnicas

Esta sección consolida la ejecución de los lenguajes $\text{DDL}$, $\text{DML}$ y $\text{SQL}$ para validar las habilidades adquiridas en el diseño y gestión de bases de datos.

### Dominio DDL (Definición de Datos)

El script `Estructura BD - Quimica Relacional.sql` cumple con la implementación de estructuras relacionales utilizando: **$\text{PK}$s**, **$\text{FK}$s**, índices **$\text{UNIQUE}$**, y restricciones de dominio (**$\text{CHECK}$**).

### Dominio DML (Manipulación de Datos)

El script `Aplicación DML - Química Relacional.sql` demuestra el uso de $\text{INSERT}$, $\text{UPDATE}$ y $\text{DELETE}$ para la modificación de datos.

  * **Prueba Clave:** Demuestra la **Integridad Referencial** mediante la eliminación en cascada (`ON DELETE CASCADE`).

### Dominio SQL (Consultas Estructuradas)

El script `Consultas BD - Química Relacional.sql` cumple con la obtención de información compleja, utilizando:

  * Cláusulas esenciales: **$\text{SELECT}$, $\text{WHERE}$, $\text{JOIN}$** (múltiple).
  * Cláusulas avanzadas: **$\text{GROUP BY}$** y funciones de agregación para el análisis de datos.

-----

## Guía de Funcionamiento (DDL, DML y SQL)

Para el correcto funcionamiento del modelo y la validación de sus reglas, deben ejecutarse los siguientes scripts en orden:

### 1\. Creación de Estructura (DDL)

```bash
-- FUNCIÓN: Crea todas las tablas con sus PK, FK, y CHECK constraints.
SOURCE Estructura BD - Quimica Relacional.sql;
```

### 2\. Población y Pruebas (DML)

```bash
-- FUNCIÓN: Inserta datos de prueba, realiza UPDATE y DELETE.
-- Pruebas Clave: Demuestra el correcto funcionamiento de ON DELETE CASCADE.
SOURCE Aplicación DML - Quimica Relacional.sql;
```

### 3\. Análisis de Información (SQL)

```bash
-- FUNCIÓN: Ejecuta SELECTs con JOINs, GROUP BY y funciones de agregación.
SOURCE Consultas BD - Quimica Relacional.sql;
```

-----

## Visión a Futuro: Fase 4 - Aplicación Web con Django

La **Fase 4** será la culminación del proceso formativo, integrando los conceptos de la Fase 2 y la Fase 3 en una aplicación de desarrollo web completa.

  * **Objetivo:** Desarrollar una aplicación web en **Django (Python)**.
  * **Integración:** La aplicación utilizará la **calculadora avanzada** (Fase 2) y se conectará a esta **Base de Datos Relacional** (Fase 3) para la gestión persistente de la información química.
  * **Meta:** Diseñar una web enfocada en la Gestión de Información Química, uniendo el front-end, el back-end (Django/Python), y la capa de datos ($\text{MySQL}$).