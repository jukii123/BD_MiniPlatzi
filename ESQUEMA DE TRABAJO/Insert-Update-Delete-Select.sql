#INSERTS:
-- Insertar un nuevo estudiante
INSERT INTO usuario (nombre, correo, contraseña, rol)
VALUES ('Carlos Gómez', 'carlos@example.com', 'pass1234', 'estudiante');

-- Insertar instructor
INSERT INTO usuario (nombre, correo, contraseña, rol)
VALUES ('María Torres', 'maria@example.com', 'pass4567', 'instructor');

-- Crear curso
INSERT INTO curso (titulo, descripcion, instructor_id)
VALUES ('Curso de Python', 'Aprende Python desde cero', 2);

-- Agregar módulos
INSERT INTO modulo (curso_id, titulo, orden)
VALUES (1, 'Introducción', 1),
       (1, 'Condicionales', 2);

-- Agregar lecciones
INSERT INTO leccion (modulo_id, titulo, contenido, tipo, orden)
VALUES (1, '¿Qué es Python?', 'Contenido básico', 'video', 1),
       (1, 'Instalación', 'Instalación paso a paso', 'texto', 2),
       (2, 'Estructuras de control', 'If, else', 'quiz', 1);

-- Inscripción a curso
INSERT INTO inscripcion (usuario_id, curso_id, estado)
VALUES (1, 1, 'activo');

-- Registrar progreso
INSERT INTO progreso (usuario_id, leccion_id, completado)
VALUES (1, 1, TRUE);

-- Comentario
INSERT INTO comentario (usuario_id, curso_id, texto, calificacion)
VALUES (1, 1, 'Muy buen curso', 5);

-- Evaluación
INSERT INTO evaluacion (usuario_id, curso_id, nota_obtenida)
VALUES (1, 1, 90.5);

-- Pago
INSERT INTO pagos (usuario_id, curso_id, monto)
VALUES (1, 1, 39.99);



-- ---------
#UPDATES
-- ---------
-- Marcar curso como finalizado
UPDATE inscripcion
SET estado = 'finalizado'
WHERE usuario_id = 1 AND curso_id = 1;

-- Actualizar contenido de una lección
UPDATE leccion
SET contenido = 'Nuevo contenido actualizado'
WHERE id = 1;


-- ---------
#DELETES
-- ---------
-- Eliminar un comentario
DELETE FROM comentario
WHERE id = 1;

-- Eliminar una inscripción cancelada
DELETE FROM inscripcion
WHERE usuario_id = 1 AND curso_id = 1;



-- ---------
#SELECTS
-- ---------
-- Ver todos los cursos
SELECT id, titulo, descripcion FROM curso;

-- Ver lecciones de un curso
SELECT l.id, l.titulo, l.tipo
FROM leccion l
JOIN modulo m ON l.modulo_id = m.id
WHERE m.curso_id = 1
ORDER BY l.orden;

-- Progreso del estudiante
SELECT calcular_progreso_curso(1, 1) AS progreso;

-- Comentarios de un curso
SELECT u.nombre, c.texto, c.calificacion
FROM comentario c
JOIN usuario u ON u.id = c.usuario_id
WHERE c.curso_id = 1;

-- Cursos inscritos por un usuario
SELECT cu.titulo, i.estado
FROM inscripcion i
JOIN curso cu ON cu.id = i.curso_id
WHERE i.usuario_id = 1;
