DROP PROCEDURE IF EXISTS sp_aceptar_invitacion;

CREATE PROCEDURE sp_aceptar_invitacion(
	_encomienda_id VARCHAR(7),
	_transportista_id VARCHAR(9),
	_vehiculo_id VARCHAR(8)
)
BEGIN

	IF _vehiculo_id <=> NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_aceptar_invitacion) Error: vehiculo no puede ser NULL';

	END IF;
	
	IF !EXISTS(SELECT *
			FROM invitaciones
			WHERE transportista_id = _transportista_id
			AND encomienda_id = _encomienda_id) THEN
			
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_aceptar_invitacion) Error: la invitacion no existe';
	END IF;

	IF !(
		SELECT _vehiculo_id IN (
			SELECT id
			FROM vehiculos
			WHERE transportista_id = _transportista_id
		)
	) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_aceptar_invitacion) Error: el vehiculo no pertenece al transportista';

	END IF;
	
	UPDATE encomiendas
	SET transportista_id = _transportista_id,
		vehiculo_id = _vehiculo_id
	WHERE id = _encomienda_id;
	
	UPDATE invitaciones
	SET estado = 'aceptada'
	WHERE transportista_id = _transportista_id
	AND encomienda_id = _encomienda_id;
	
END;