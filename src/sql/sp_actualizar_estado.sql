DROP PROCEDURE IF EXISTS sp_update_estado;

CREATE PROCEDURE sp_update_estado(
	transportista VARCHAR(9),
	encomienda VARCHAR(7),
	newEstado VARCHAR(15)
)
BEGIN

	DECLARE oldEstado VARCHAR(15);
	
	IF transportista <=> NULL
		OR encomienda <=> NULL
		OR !(transportista <=> (SELECT transportista_id
									FROM encomiendas
									WHERE id = encomienda)) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_update_estado) Error: el transportista o encomienda ingresada no es valida';
	
	END IF;

	
	IF (newEstado <=> NULL) THEN
	
		SELECT estado
		INTO oldEstado
		FROM encomiendas
		WHERE id = encomienda;

		CASE oldEstado
		
			WHEN NULL THEN
			
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = '(sp_update_estado) Error: la encomienda no ha sido iniciada, su estado no se puede actualizar';
		
			WHEN 'en espera' THEN

				SET newEstado = 'en progreso';
				
				-- Registrar fecha de salida
				UPDATE encomiendas
					SET fh_salida = NOW()
					WHERE id = encomienda;
				
				-- cobrarle al cliente
				CALL sp_cobrar_encomienda_cliente(encomienda);
				
			WHEN 'en custodia'  THEN
			
				SET newEstado = 'en progreso';
				
			WHEN 'en progreso'  THEN
			
				SET newEstado = 'culminada';
				
				-- Registrar fecha de llegada
				UPDATE encomiendas
					SET fh_llegada = NOW()
					WHERE id = encomienda;
				
				-- pagarle al transportista
				CALL sp_pagar_encomienda_transportista(encomienda);
				
			ELSE 
			
				SET newEstado = oldEstado;
				
		END CASE;
	
	ELSEIF !(newEstado <=> 'en custodia')
		AND !(newEstado <=> 'cancelada') THEN
		
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_update_estado) Error: el estado ingresado no es valido';
		
	END IF;
	
	UPDATE encomiendas
	SET estado = newEstado
	WHERE id = encomienda;
	
END;