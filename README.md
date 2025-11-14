
-----

# BD Química Relacional: Fase 3 (Modelado y Gestión de Datos)

Este proyecto representa la **Fase 3** del proceso formativo, siendo la **continuación lógica y complementaria** de la calculadora avanzada de peso molecular desarrollada en la Fase 2 (Python/POO).

El objetivo de esta fase es migrar la persistencia a un diseño robusto de **Base de Datos Relacional** en $\text{MySQL}$, demostrando el dominio del **Modelado Entidad-Relación ($\text{ERD}$)** y la **Integridad Referencial** a través de **todos los tipos de relaciones ($\text{1:1}$, $\text{1:M}$, $\text{M:M}$)**.

-----

## Estructura del Proyecto

El modelo se basa en **8 Tablas** para modelar la complejidad de la formulación, los detalles químicos y las clasificaciones de negocio.

### Modelo de Entidad-Relación (ERD) - Relaciones Múltiples

| Tabla | Tipo | Propósito Principal | Relación Clave Demostrada |
| :--- | :--- | :--- | :--- |
| **elementos\_quimicos** | Padre | Catálogo de la Tabla Periódica. | Padre en **$\text{1:1}$** (a Detalles) y **$\text{M:M}$** |
| **detalles\_elementos** | Detalle | Almacena propiedades secundarias (Electronegatividad, Periodo). | **$\text{Relación 1:1}$** (Demuestra detalle y unicidad) |
| **compuestos\_quimicos** | Padre | Fórmulas, Nombres y Pesos Moleculares. | Padre en **$\text{M:M}$** |
| **industrias** | Padre | Clasificación de alto nivel de los usos (Ej: Farmacéutica). | Padre en **$\text{1:M}$** |
| **aplicaciones** | Intermedia | Usos concretos (Ej: Fungicida). | Hija en **$\text{1:M}$** y Padre en **$\text{M:M}$** |
| **elementos\_compuestos** | Intermedia | **Fórmula Química** ($\text{M:M}$). | $\text{Relación M:M}$ (Fórmula) |
| **compuestos\_aplicaciones**| Intermedia | **Uso de Moléculas** ($\text{M:M}$). | $\text{Relación M:M}$ (Uso) |

-----

## Diccionario de Datos (Resumen de Restricciones)

Este resumen demuestra la **Integridad de Dominio** implementada en el $\text{DDL}$:

| Atributo | Tipo Dato | Restricciones Clave |
| :--- | :--- | :--- |
| **Id\_Elemento** | $\text{INT}$ | **$\text{PK}$** (en `elementos`), **$\text{PK + UNIQUE}$** (en `detalles_elementos`) |
| **peso\_atomico\_elemento** | $\text{DECIMAL}(10, 6)$ | `NOT NULL`, `CHECK (> 0)`, **$\text{UNIQUE}$** |
| **Id\_industria** | $\text{INT}$ | **$\text{FK}$** a `Industrias` (Implementa la relación **$\text{1:M}$**). |
| **uk\_elem\_comp** | ($\text{ID\_elemento}$, $\text{ID\_compuesto}$) | $\text{UNIQUE KEY}$ (Garantiza la integridad de la fórmula $\text{M:M}$). |

-----

## Demostración de Habilidades Técnicas

### Dominio DDL (Definición de Datos)

El script $\text{SQL}$ demuestra la implementación de estructuras relacionales utilizando: **$\text{PK}$s**, **$\text{FK}$s**, **$\text{UNIQUE}$**, y restricciones de dominio ($\text{CHECK}$).

**Prueba Clave:** Se demuestra el uso de $\text{ALTER TABLE}$ para agregar, modificar y eliminar columnas/restricciones, así como $\text{DROP TABLE}$ para probar la integridad en cascada.

### Dominio SQL (Consultas Estructuradas)

El script $\text{SQL}$ cumple con la obtención de información compleja.

  * **Consultas $\text{JOIN}$ Complejas:** Demostración de $\text{JOIN}$s de 4 tablas para navegar por la estructura $\text{1:M}$ y $\text{M:M}$ simultáneamente.
  * **Cálculos Avanzados:** Uso de $\text{SUM}(\text{peso} * \text{cantidad})$ y $\text{HAVING}$ para el análisis químico.
  * **Integridad $\text{DML}$:** Uso de $\text{DELETE JOIN}$ para eliminar relaciones $\text{M:M}$ de forma controlada.

-----

## Visión a Futuro: Fase 4 - Aplicación Web con Django

La **Fase 4** será la culminación del proceso formativo, integrando la lógica de la Fase 2 y la estructura de la Fase 3 en una aplicación de desarrollo web completa.

  * **Meta:** Desarrollar un sistema $\text{CRUD}$ en **Django (Python)** para la gestión de datos químicos, utilizando esta base de datos $\text{MySQL}$ como capa de persistencia.

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