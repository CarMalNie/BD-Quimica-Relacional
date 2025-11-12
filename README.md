
-----

# BD Quimica Relacional: Fase 3 (Modelado y Gestión de Datos)

Este proyecto representa la **Fase 3** del proceso formativo como desarrollador full-stack, siendo la **continuación lógica y complementaria** de la calculadora avanzada de peso molecular desarrollada en la Fase 2 (Python/POO).

El objetivo de esta fase es migrar la persistencia a un diseño robusto de **Base de Datos Relacional** en $\text{MySQL}$, demostrando el dominio del **Modelado Entidad-Relación ($\text{ERD}$)** y la **Integridad Referencial**.

-----

## Estructura del Proyecto

El modelo se basa en **6 Tablas** para demostrar la gestión de la información química (Elementos, Compuestos) y sus relaciones complejas ($\text{M:M}$).

### Modelo de Entidad-Relación (ERD)

| Tabla | Tipo | Propósito Principal | Restricciones Clave |
| :--- | :--- | :--- | :--- |
| **elementos\_quimicos** | Padre | Catálogo de la Tabla Periódica. | $\text{PK}$, $\text{UNIQUE}$ |
| **compuestos\_quimicos** | Padre | Fórmulas, Nombres y Pesos Moleculares. | $\text{PK}$, $\text{UNIQUE}$ |
| **aplicaciones** | Padre | Usos y clasificación por industria. | $\text{PK}$, $\text{UNIQUE}$ |
| **elementos\_compuestos** | Intermedia | **Fórmula Química** (Elemento $\leftrightarrow$ Compuesto). | $\text{PK}$ Sustituta, $\text{UNIQUE KEY}$ ($\text{M:M}$) |
| **compuestos\_aplicaciones**| Intermedia | **Uso Industrial** (Compuesto $\leftrightarrow$ Aplicación). | $\text{PK}$ Sustituta, $\text{UNIQUE KEY}$ ($\text{M:M}$) |

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

## Guía de Funcionamiento (DDL, DML y SQL)

Para el correcto funcionamiento del modelo y la validación de sus reglas, deben ejecutarse los siguientes scripts en orden:

### 1\. Creación de Estructura (DDL)

El script `Estructura BD - Quimica Relacional.sql` crea la base de datos y sus 6 tablas.

```bash
-- FUNCIÓN: Crea todas las tablas con sus PK, FK, y CHECK constraints.
SOURCE Estructura BD - Quimica Relacional.sql;
```

### 2\. Población y Manipulación (DML)

El script `Aplicación DML - Química Relacional.sql` prueba la integridad de los datos.

```bash
-- FUNCIÓN: Inserta datos de prueba, realiza UPDATE y DELETE.
-- Pruebas Clave: Demuestra el correcto funcionamiento de ON DELETE CASCADE.
SOURCE Aplicación DML - Quimica Relacional.sql;
```

### 3\. Análisis de Información (SQL)

El script `Consultas BD - Química Relacional.sql` contiene las consultas complejas de análisis.

```bash
-- FUNCIÓN: Ejecuta SELECTs con JOINs, GROUP BY y funciones de agregación.
-- Demuestra el análisis de datos a través de las relaciones M:M.
SOURCE Consultas BD - Quimica Relacional.sql;
```

-----

## Visión a Futuro: Fase 4 - Aplicación Web con Django

La **Fase 4** será la culminación del proceso formativo, integrando los conceptos de la Fase 2 y la Fase 3 en una aplicación de desarrollo web completa.

  * **Objetivo:** Desarrollar una aplicación web en **Django (Python)**.
  * **Integración:** La aplicación utilizará la **calculadora avanzada** (Fase 2) y se conectará a esta **Base de Datos Relacional** (Fase 3) para la gestión persistente de la información química.
  * **Meta:** Diseñar una web enfocada en la Gestión de Información Química, uniendo el front-end, el back-end (Django/Python), y la capa de datos ($\text{MySQL}$).