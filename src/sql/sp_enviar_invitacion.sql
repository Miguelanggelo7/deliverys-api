DROP PROCEDURE IF EXISTS sp_enviar_invitacion;

CREATE PROCEDURE sp_enviar_invitacion(
	_encomienda_id VARCHAR(7)
)
BEGIN

	DECLARE random INT;
	DECLARE total INT;
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE i INTEGER DEFAULT 0;
	DECLARE _transportista_id VARCHAR(9);
	
	-- declarar cursor de transportistas que no han recibido invitacion
	-- y tienen disponiblidad
	DEClARE curTransportista CURSOR FOR 
			SELECT t.id
			FROM transportistas t
			LEFT JOIN invitaciones i ON	i.transportista_id = t.id
				AND i.encomienda_id = _encomienda_id
			WHERE i.encomienda_id IS NULL
			AND t.nucleo_id = (SELECT nucleo_id 
								FROM encomiendas
								WHERE id = _encomienda_id)
			AND t.disponibilidad;
				
	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
	
	-- contar transportistas que no han recibido invitacion
	-- y tienen disponiblidad	
	SELECT COUNT(t.id)
		INTO total
		FROM transportistas t
		LEFT JOIN invitaciones i ON	i.transportista_id = t.id
			AND i.encomienda_id = _encomienda_id
		WHERE i.encomienda_id IS NULL
		AND t.nucleo_id = (SELECT nucleo_id 
							FROM encomiendas
							WHERE id = _encomienda_id)
		AND t.disponibilidad;
	
	IF total = 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_enviar_invitacion) Error: no hay transportistas disponibles';
	END IF;
	
	-- generate a random number
	SET random = FLOOR(RAND() * total);
	
	-- Open cursor
	OPEN curTransportista;
	
	WHILE i <= random DO
		FETCH curTransportista INTO _transportista_id;
		SET i = i + 1;
	END WHILE;
	
	-- close cursor
	CLOSE curTransportista;
	
	INSERT INTO invitaciones(transportista_id, encomienda_id, fecha_hora) 
		VALUES(_transportista_id, _encomienda_id, NOW());
	
END