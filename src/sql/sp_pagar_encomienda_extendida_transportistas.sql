DROP PROCEDURE IF EXISTS sp_pagar_encomienda_extendida_transportistas;

CREATE PROCEDURE sp_pagar_encomienda_extendida_transportistas(
	_encomienda_id VARCHAR(7)
)
BEGIN
	DECLARE _transportista_id VARCHAR(9);

	DECLARE finished INTEGER DEFAULT 0;
	DECLARE comision FLOAT(255,2);
	-- DECLARE n INT;

	-- declarar cursor de todos los transportistas
	-- que participaron en la ecomienda
	DECLARE curTransportista CURSOR FOR 
			SELECT transportista_id
			FROM recorridos
			WHERE encomienda_id = _encomienda_id;
				
	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curTransportista;
	
	-- SET n = 0;

	FETCH curTransportista INTO _transportista_id;
	WHILE !finished DO

		-- calcular comision de cada transportista segun su nucleo
		SELECT n.com_vuelo
		INTO comision
		FROM transportistas t
		INNER JOIN nucleos n ON n.id = t.nucleo_id
		WHERE t.id = _transportista_id;

		-- pagar
		UPDATE transportistas t
		SET t.saldo = t.saldo + sf_calcular_costo_encomienda(_encomienda_id) 
			* comision
		WHERE id = _transportista_id;

		-- SET n = n + 1;

		FETCH curTransportista INTO _transportista_id;
	END WHILE;
	
	-- close cursor
	CLOSE curTransportista;

	-- SIGNAL SQLSTATE '45000'
	-- SET MESSAGE_TEXT = n;

END;