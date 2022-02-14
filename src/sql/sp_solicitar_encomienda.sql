DROP PROCEDURE IF EXISTS sp_solicitar_encomienda;

CREATE PROCEDURE sp_solicitar_encomienda(
	encomienda VARCHAR(7)
)
BEGIN

	IF (
		SELECT COUNT(*) = 0
		FROM paquetes
		WHERE encomienda_id = encomienda
	) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_solicitar_encomienda) Error: la encomienda no posee ningun paquete';
	END IF;
	
	IF !((SELECT estado
			FROM encomiendas
			WHERE id = encomienda) <=> NULL) THEN
			
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_solicitar_encomienda) Error: la encomienda ya ha sido solicitada';
	
	END IF;
	
	UPDATE encomiendas
	SET estado = 'en espera'
	WHERE id = encomienda;
	
	CALL sp_enviar_invitacion(encomienda);
END