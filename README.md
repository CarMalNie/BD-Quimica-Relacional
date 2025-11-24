
-----

# BD Química Relacional: Fase 3 (Modelado y Gestión de Datos)

Este proyecto representa la **Fase 3** del proceso formativo, siendo la **continuación lógica y complementaria** de la calculadora avanzada de peso molecular desarrollada en la Fase 2 (Python/POO).

El objetivo de esta fase es migrar la persistencia a un diseño robusto de **Base de Datos Relacional** en MySQL, demostrando el dominio del **Modelado Entidad-Relación (ERD)** y la **Integridad Referencial** a través de **todos los tipos de relaciones (1:1, 1:N, M:N)**.

-----

## Estructura del Proyecto

El modelo se basa en **8 Tablas** para modelar la complejidad de la formulación, los detalles químicos y las clasificaciones de negocio.

### Modelo de Entidad-Relación (ERD) - Relaciones Múltiples

| Tabla | Tipo | Propósito Principal | Relación Clave Demostrada |
| :--- | :--- | :--- | :--- |
| **elementos\_quimicos** | Padre | Catálogo de la Tabla Periódica. | Padre en **1:1** (a Detalles) y **1:N** |
| **detalles\_elementos** | Detalle | Almacena propiedades secundarias (Electronegatividad, Periodo). | **Relación 1:1** (Demuestra detalle y unicidad) |
| **compuestos\_quimicos** | Padre | Fórmulas, Nombres y Pesos Moleculares. | Padre en **M:N** |
| **industrias** | Padre | Clasificación de alto nivel de los usos (Ej: Farmacéutica). | Padre en **1:N** |
| **aplicaciones** | Intermedia | Usos concretos (Ej: Fungicida). | Hija en **1:N** y Padre en **M:N** |
| **elementos\_compuestos** | Intermedia | **Fórmula Química** (**M:N**). | **Relación M:N** (Fórmula) |
| **compuestos\_aplicaciones**| Intermedia | **Uso de Moléculas** (**M:N**). | **Relación M:N** (Uso) |

-----

## Diccionario de Datos (Resumen de Restricciones)

Este resumen demuestra la **Integridad de Dominio** implementada en el DDL:

| Atributo | Tipo Dato | Restricciones Clave |
| :--- | :--- | :--- |
| **Id\_Elemento** | INT | **PK** (en `elementos`), **PK + UNIQUE** (en `detalles_elementos`) |
| **peso\_atomico\_elemento** | DECIMAL(10, 6) | `NOT NULL`, `CHECK (> 0)`, **UNIQUE** |
| **Id\_industria** | INT | **FK** a `Industrias` (Implementa la relación **1:N**). |
| **uk\_elem\_comp** | (ID\_elemento, ID\_compuesto) | **UNIQUE KEY** (Garantiza la integridad de la fórmula **M:N**). |

-----

## Demostración de Habilidades Técnicas

### Dominio DDL (Definición de Datos)

El script SQL demuestra la implementación de estructuras relacionales utilizando: **PKs**, **FKs**, **UNIQUE**, y restricciones de dominio (**CHECK**).

**Prueba Clave:** Se demuestra el uso de **ALTER TABLE** para agregar, modificar y eliminar columnas/restricciones, así como **DROP TABLE** para probar la integridad en cascada.

### Dominio SQL (Consultas Estructuradas)

El script SQL cumple con la obtención de información compleja.

  * **Consultas JOIN Complejas:** Demostración de **JOINs** de 4 tablas para navegar por la estructura **1:N** y **M:N** simultáneamente.
  * **Cálculos Avanzados:** Uso de **SUM** (`peso * cantidad`) y **HAVING** para el análisis químico.
  * **Integridad DML:** Uso de **DELETE JOIN** para eliminar relaciones **M:N** de forma controlada.

-----

## Visión a Futuro: Fase 4 - Aplicación Web con Django

La **Fase 4** será la culminación del proceso formativo, integrando la lógica de la Fase 2 y la estructura de la Fase 3 en una aplicación de desarrollo web completa.

  * **Meta:** Desarrollar un sistema **CRUD** en **Django (Python)** para la gestión de datos químicos, utilizando esta base de datos MySQL como capa de persistencia.

-----

### Guía de Funcionamiento (DDL, DML y SQL)

**[Instrucciones para la ejecución secuencial del SQL en la Base de Datos]**

```bash
-- 1. Creación de Estructura (DDL)
SOURCE Estructura BD - Quimica Relacional.sql;
-- 2. Población y Pruebas (DML)
SOURCE Aplicación DML - Quimica Relacional.sql;
-- 3. Análisis de Información (SQL)
SOURCE Consultas BD - Quimica Relacional.sql;
```