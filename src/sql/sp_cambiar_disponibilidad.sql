DROP PROCEDURE IF EXISTS sp_cambiar_disponibilidad;

CREATE PROCEDURE sp_cambiar_disponibilidad(
  IN transportista_id VARCHAR(9),
  IN new_disp TINYINT(1)
)
BEGIN
		DECLARE licencia VARCHAR(12);
		SET @disp = (SELECT disponibilidad FROM transportistas WHERE id = transportista_id);
		-- Se valida que el transportista exista
		IF ISNULL(@disp) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El transportista que ingresó no existe';
		END IF;

		-- Se comprueba que no sea la misma disponibilidad
		IF @disp = new_disp THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usted ingresó la misma disponibilidad, por lo que no hubo cambios';
		END IF;

    IF new_disp = FALSE THEN
			UPDATE transportistas SET disponibilidad = FALSE WHERE id = transportista_id;
    ELSE
			-- Validar que tenga licencia
			-- SET licencia = (SELECT t.licencia FROM transportistas t WHERE t.id = transportista_id);
			-- IF (ISNULL(licencia)) THEN
			-- 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transportista no posee licencia registrada';
			-- END IF;

			-- Validar que tenga vehiculos
			IF (SELECT COUNT(*) FROM vehiculos v WHERE v.transportista_id = transportista_id) = 0 THEN
					SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transportista no posee vehiculos asociados';
			END IF;

			-- Validar que haya completado el curso
			IF (SELECT NOT t.curso_aprobado FROM transportistas t WHERE t.id = transportista_id) THEN
					SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transportista debe haber completado el curso';
			END IF;

			UPDATE transportistas SET disponibilidad = true WHERE id = transportista_id; 
    END IF;

		
END;