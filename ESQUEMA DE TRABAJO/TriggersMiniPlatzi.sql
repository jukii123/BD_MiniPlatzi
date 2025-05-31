CREATE DATABASE MiniPlatzi;
USE MiniPlatzi;

-- Tabla usuarios
CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    rol ENUM('estudiante', 'instructor', 'admin') NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- Estudiante (extiende usuario)
CREATE TABLE estudiante (
    usuario_id INT PRIMARY KEY,
    carrera VARCHAR(100),
    nivel_estudio VARCHAR(50),
    foto_perfil TEXT,
    bio TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);

-- Instructor (extiende usuario)
CREATE TABLE instructor (
    usuario_id INT PRIMARY KEY,
    especialidad VARCHAR(100),
    experiencia TEXT,
    redes_sociales TEXT,
    foto_perfil TEXT,
    bio TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);

-- Admin (extiende usuario)
CREATE TABLE admin (
    usuario_id INT PRIMARY KEY,
    permisos TEXT,
    nota TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);

-- Curso
CREATE TABLE curso (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES usuario(id) ON DELETE SET NULL
);
-- Modulo
CREATE TABLE modulo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    curso_id INT,
    titulo VARCHAR(200),
    orden INT,
    FOREIGN KEY (curso_id) REFERENCES curso(id) ON DELETE CASCADE
);
-- Leccion
CREATE TABLE leccion (
    id INT PRIMARY KEY AUTO_INCREMENT,
    modulo_id INT,
    titulo VARCHAR(200),
    contenido TEXT,
    tipo ENUM('video', 'texto', 'quiz'),
    orden INT,
    FOREIGN KEY (modulo_id) REFERENCES modulo(id) ON DELETE CASCADE
);
-- Ruta
CREATE TABLE ruta_aprendizaje (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200),
    descripcion TEXT
);
--  relacion curso-ruta
CREATE TABLE curso_ruta (
    ruta_id INT,
    curso_id INT,
    orden INT,
    PRIMARY KEY (ruta_id, curso_id),
    FOREIGN KEY (ruta_id) REFERENCES ruta_aprendizaje(id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES curso(id) ON DELETE CASCADE
);

-- Inscripcion
CREATE TABLE inscripcion (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    curso_id INT,
    fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('activo', 'finalizado', 'abandonado'),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);

-- Progreso
CREATE TABLE progreso (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    leccion_id INT,
    completado BOOLEAN DEFAULT FALSE,
    fecha_acceso DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (leccion_id) REFERENCES leccion(id)
);

-- Evaluación
CREATE TABLE evaluacion (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    curso_id INT,
    nota_obtenida DECIMAL(5,2),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);

-- Certificado
CREATE TABLE certificado (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    curso_id INT,
    fecha_emision DATETIME DEFAULT CURRENT_TIMESTAMP,
    codigo_verificacion VARCHAR(100) UNIQUE,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);
-- Comentarios
CREATE TABLE comentario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    curso_id INT,
    texto TEXT,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    fecha_comentario DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);

CREATE TABLE pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    curso_id INT,
    monto DECIMAL(10,2),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);



CREATE TABLE log_pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    curso_id INT,
    monto DECIMAL(10,2),
    fecha DATETIME
);



