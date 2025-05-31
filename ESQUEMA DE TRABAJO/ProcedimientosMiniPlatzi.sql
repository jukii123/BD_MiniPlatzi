-- 1. Procedimiento: inscribir_en_curso
DELIMITER //
CREATE PROCEDURE inscribir_en_curso(IN p_usuario_id INT, IN p_curso_id INT)
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM inscripcion
    WHERE usuario_id = p_usuario_id AND curso_id = p_curso_id
  ) THEN
    INSERT INTO inscripcion(usuario_id, curso_id, fecha_inscripcion, estado)
    VALUES(p_usuario_id, p_curso_id, NOW(), 'activo');
  END IF;
END//
DELIMITER ;
-- 2. Procedimiento: actualizar_estado_inscripcion
DELIMITER //
CREATE PROCEDURE actualizar_estado_inscripcion(IN p_usuario_id INT, IN p_curso_id INT)
BEGIN
  DECLARE progreso DECIMAL(5,2);
  SET progreso = calcular_progreso_curso(p_usuario_id, p_curso_id);
   IF progreso = 100 THEN
    UPDATE inscripcion
    SET estado = 'finalizado'
    WHERE usuario_id = p_usuario_id AND curso_id = p_curso_id;
  END IF;
END//
DELIMITER ;
