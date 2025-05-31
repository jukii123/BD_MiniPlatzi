DELIMITER //
CREATE PROCEDURE registrar_inscripcion_completa (
    IN p_usuario_id INT,
    IN p_curso_id INT,
    IN p_monto DECIMAL(10,2)
)
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
  END;

  START TRANSACTION;

  -- Paso 1: Registrar el pago
  INSERT INTO pagos(usuario_id, curso_id, monto, fecha)
  VALUES(p_usuario_id, p_curso_id, p_monto, NOW());

  -- Paso 2: Registrar en log
  INSERT INTO log_pagos(usuario_id, curso_id, monto, fecha)
  VALUES(p_usuario_id, p_curso_id, p_monto, NOW());

  -- Paso 3: Llamar al procedimiento para inscribir
  CALL inscribir_en_curso(p_usuario_id, p_curso_id);


  COMMIT;
END//
DELIMITER ;



-- Finalización de curso

DELIMITER //

CREATE PROCEDURE finalizar_curso_con_certificado(
  IN p_usuario_id INT,
  IN p_curso_id INT,
  IN p_nota_final DECIMAL(5,2)
)
BEGIN
  DECLARE progreso DECIMAL(5,2);
  DECLARE v_codigo VARCHAR(100);

  START TRANSACTION;

  -- 1. Calcular el progreso del curso
  SET progreso = calcular_progreso_curso(p_usuario_id, p_curso_id);

  -- 2. Verificar si el curso está completo
  IF progreso = 100 THEN

    -- 3. Actualizar estado de inscripción
    CALL actualizar_estado_inscripcion(p_usuario_id, p_curso_id);

    -- 4. Registrar la evaluación final
    INSERT INTO evaluacion(usuario_id, curso_id, nota_obtenida)
    VALUES(p_usuario_id, p_curso_id, p_nota_final);

    -- 5. Emitir certificado si la nota es mayor o igual a 60
    IF p_nota_final >= 60 THEN
      SET v_codigo = CONCAT('CERT-', UUID());

      INSERT INTO certificado(usuario_id, curso_id, fecha_emision, codigo_verificacion)
      VALUES(p_usuario_id, p_curso_id, NOW(), v_codigo);
    END IF;

    COMMIT;
  ELSE
    -- Si no cancelar todo
    ROLLBACK;
  END IF;
END//

DELIMITER ;
