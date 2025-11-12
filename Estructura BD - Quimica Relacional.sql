-- CREACIÓN BASE DE DATOS Y TABLAS.

SET SQL_SAFE_UPDATES = 1; # Considerado para realizar UPDATE o DELETE de forma segura usando WHERE

-- Reinicio de Seguridad Base de Datos. (Implementado para pruebas. Comentado para cumplir con las funcionalidades)
DROP DATABASE IF EXISTS quimica_relacional;

-- Creación de Base de Datos.
CREATE DATABASE quimica_relacional;
USE quimica_relacional;

-- (1) Creación Estructura Tabla elementos_quimicos (Tabla Peródica).
CREATE TABLE elementos_quimicos (
	id_elemento INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_elemento VARCHAR(50) UNIQUE NOT NULL,
    simbolo_elemento VARCHAR(3) UNIQUE NOT NULL,
    numero_atomico_elemento INT UNIQUE NOT NULL CHECK (numero_atomico_elemento > 0),
    grupo_elemento INT NULL CHECK (grupo_elemento IS NULL OR (grupo_elemento >= 1 AND grupo_elemento <= 18)),
    peso_atomico_elemento DECIMAL(8, 4) NOT NULL CHECK (peso_atomico_elemento > 0)
) ENGINE = InnoDB;

-- (2) Creación Estructura Tabla compuestos_quimicos.
CREATE TABLE compuestos_quimicos (
    id_compuesto INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_compuesto VARCHAR(255) NOT NULL,
    formula_compuesto VARCHAR(255) UNIQUE NOT NULL,
    peso_molecular_compuesto DECIMAL(10, 4) NOT NULL CHECK (peso_molecular_compuesto > 0),
    fecha_registro_compuesto DATETIME NOT NULL CHECK (fecha_registro_compuesto <= NOW())
) ENGINE = InnoDB;

-- (3) Creación Estructura Tabla aplicaciones.
CREATE TABLE aplicaciones (
	id_aplicacion INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_aplicacion VARCHAR(255) UNIQUE NOT NULL,
    industria_aplicacion VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

-- (4) Creación Estructura Tabla elementos_compuestos (Tabla intermedia de elementos_quimicos y compuestos_quimicos).
CREATE TABLE elementos_compuestos (
	id_elem_comp INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_elemento INT NOT NULL,
    id_compuesto INT NOT NULL,
    cantidad_elem_en_comp INT NOT NULL CHECK (cantidad_elem_en_comp > 0),
    CONSTRAINT fk_elementos_compuestos_elementos_quimicos FOREIGN KEY (id_elemento) REFERENCES elementos_quimicos(id_elemento) ON DELETE CASCADE,
	CONSTRAINT fk_elementos_compuestos_compuestos_quimicos FOREIGN KEY (id_compuesto) REFERENCES compuestos_quimicos(id_compuesto) ON DELETE CASCADE,
	UNIQUE KEY uk_elem_comp (id_elemento, id_compuesto)
) ENGINE = InnoDB;

-- (5) Creación Estructura Tabla elementos_aplicaciones (Tabla intermedia de elementos_quimicos y aplicaciones).
CREATE TABLE elementos_aplicaciones (
	id_elem_aplic INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_elemento INT NOT NULL,
    id_aplicacion INT NOT NULL,
    notas_uso VARCHAR(255) NOT NULL,
    CONSTRAINT fk_elementos_aplicaciones_elementos_quimicos FOREIGN KEY (id_elemento) REFERENCES elementos_quimicos(id_elemento) ON DELETE CASCADE,
	CONSTRAINT fk_elementos_aplicaciones_aplicaciones FOREIGN KEY (id_aplicacion) REFERENCES aplicaciones(id_aplicacion) ON DELETE CASCADE,
	UNIQUE KEY uk_elem_aplic (id_elemento, id_aplicacion)
) ENGINE = InnoDB;

-- (6) Creación Estructura Tabla compuestos_aplicaciones (Tabla intermedia de compuestos_quimicos y aplicaciones).
CREATE TABLE compuestos_aplicaciones (
	id_comp_aplic INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_compuesto INT NOT NULL,
    id_aplicacion INT NOT NULL,
    concentracion_minima VARCHAR(45) NOT NULL,
    CONSTRAINT fk_compuestos_aplicaciones_compuestos_quimicos FOREIGN KEY (id_compuesto) REFERENCES compuestos_quimicos(id_compuesto) ON DELETE CASCADE,
	CONSTRAINT fk_compuestos_aplicaciones_aplicaciones FOREIGN KEY (id_aplicacion) REFERENCES aplicaciones(id_aplicacion) ON DELETE CASCADE,
	UNIQUE KEY uk_comp_aplic (id_compuesto, id_aplicacion)
) ENGINE = InnoDB;
