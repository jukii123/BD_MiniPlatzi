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


-- 3. Procedimiento: registrar_curso

DELIMITER //
CREATE PROCEDURE registrar_curso(
    IN p_titulo VARCHAR(200),
    IN p_descripcion TEXT,
    IN p_instructor_id INT
)
BEGIN
  DECLARE existe_usuario INT;

  -- Verificamos que el usuario exista y sea instructor
  SELECT COUNT(*) INTO existe_usuario
  FROM usuario
  WHERE id = p_instructor_id AND rol = 'instructor';

  IF existe_usuario = 1 THEN
    -- Insertamos el curso
    INSERT INTO curso(titulo, descripcion, instructor_id)
    VALUES (p_titulo, p_descripcion, p_instructor_id);
  ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El usuario no es un instructor válido';
  END IF;

END //
DELIMITER ;

