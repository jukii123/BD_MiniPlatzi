-- 1. Trigger: after_insert_usuario
DELIMITER //
CREATE TRIGGER after_insert_usuario
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
  IF NEW.rol = 'estudiante' THEN
    INSERT INTO estudiante(usuario_id) VALUES (NEW.id);
  ELSEIF NEW.rol = 'instructor' THEN
    INSERT INTO instructor(usuario_id) VALUES (NEW.id);
  END IF;
END//
DELIMITER ;
-- 2. Trigger: after_insert_progreso
DELIMITER //
CREATE TRIGGER after_insert_progreso
AFTER INSERT ON progreso
FOR EACH ROW
BEGIN
  DECLARE curso_id INT;
  SELECT curso.id INTO curso_id
  FROM curso
  JOIN modulo ON modulo.curso_id = curso.id
  JOIN leccion ON leccion.modulo_id = modulo.id
  WHERE leccion.id = NEW.leccion_id
  LIMIT 1;
  CALL actualizar_estado_inscripcion(NEW.usuario_id, curso_id);
END//
DELIMITER ;
-- 3. Trigger: before_insert_curso
DELIMITER //
CREATE TRIGGER before_insert_curso
BEFORE INSERT ON curso
FOR EACH ROW
BEGIN
  DECLARE rol_instructor ENUM('estudiante', 'instructor', 'admins');
  SELECT rol INTO rol_instructor
  FROM usuario
  WHERE id = NEW.instructor_id;
  IF rol_instructor != 'instructor' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El usuario asignado no tiene rol de instructor';
  END IF;
END//
DELIMITER ;

