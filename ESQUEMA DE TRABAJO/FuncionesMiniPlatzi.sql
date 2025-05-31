-- 1. Función: calcular_progreso_curso
DELIMITER //
CREATE FUNCTION calcular_progreso_curso(usuario_id INT, curso_id INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
  DECLARE total_lecciones INT;
  DECLARE completadas INT;
  DECLARE progreso DECIMAL(5,2);
  SELECT COUNT(*) INTO total_lecciones
  FROM leccion
  JOIN modulo ON leccion.modulo_id = modulo.id
  WHERE modulo.curso_id = curso_id;

  SELECT COUNT(*) INTO completadas
  FROM progreso
  JOIN leccion ON progreso.leccion_id = leccion.id
  JOIN modulo ON leccion.modulo_id = modulo.id
  WHERE progreso.usuario_id = usuario_id AND modulo.curso_id = curso_id AND progreso.completado = TRUE;
  IF total_lecciones = 0 THEN
    SET progreso = 0;
  ELSE
    SET progreso = (completadas / total_lecciones) * 100;
  END IF;
  RETURN progreso;
END//
DELIMITER ;
-- 2. Función: obtener_total_inscritos
DELIMITER //
CREATE FUNCTION obtener_total_inscritos(curso_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM inscripcion WHERE curso_id = curso_id;
  RETURN total;
END//
DELIMITER ;
