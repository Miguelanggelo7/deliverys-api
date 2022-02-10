DROP PROCEDURE IF EXISTS sp_rechazar_invitacion;

CREATE PROCEDURE sp_rechazar_invitacion(
	_encomienda_id VARCHAR(7),
	_transportista_id VARCHAR(9)
)
BEGIN
	
	IF !EXISTS(SELECT *
			FROM invitaciones
			WHERE transportista_id = _transportista_id
			AND encomienda_id = _encomienda_id) THEN
			
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_rechazar_invitacion) Error: la invitacion no existe';
	END IF;
	
	UPDATE invitaciones
	SET estado = 'rechazada'
	WHERE transportista_id = _transportista_id
	AND encomienda_id = _encomienda_id;
	
	CALL sp_enviar_invitacion(_encomienda_id);
	
END;