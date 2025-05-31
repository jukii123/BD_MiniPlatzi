-- Catálogo de cursos
-- Usuarios filtran cursos por nombre, categoría o nivel
CREATE INDEX idx_curso_titulo ON curso(titulo);
CREATE INDEX idx_curso_categoria ON curso(descripcion(100)); -- asumiendo que 'descripcion' contiene info de categoría/nivel
CREATE INDEX idx_curso_nivel ON curso(nivel); -- si nivel es un campo separado
-- Progreso del usuario
-- Mostrar avance por usuario y curso
CREATE INDEX idx_progreso_usuario ON progreso(usuario_id);
CREATE INDEX idx_inscripcion_usuario_curso ON inscripcion(usuario_id, curso_id);
-- Comentarios
-- Mostrar comentarios recientes en clase o curso
CREATE INDEX idx_comentario_clase_fecha ON comentario(curso_id, fecha_comentario);
-- Perfil de usuario
-- Ver cursos tomados y certificados según estado
CREATE INDEX idx_inscripcion_estado ON inscripcion(usuario_id, estado);
CREATE INDEX idx_certificado_usuario ON certificado(usuario_id);
-- Lecciones
-- Acceso secuencial a lecciones por curso y orden
CREATE INDEX idx_leccion_curso_orden ON leccion(modulo_id, orden);
-- Búsqueda general
-- Búsqueda en campos amplios como título, descripción y profesor
CREATE FULLTEXT INDEX ft_busqueda_curso ON curso(titulo, descripcion);
CREATE INDEX idx_curso_profesor ON curso(instructor_id);