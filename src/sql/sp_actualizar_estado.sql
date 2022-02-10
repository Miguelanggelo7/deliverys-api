DROP PROCEDURE IF EXISTS sp_update_estado;

CREATE PROCEDURE sp_update_estado(
	encomienda VARCHAR(7)
)
BEGIN
	DECLARE oldEstado VARCHAR(15);
	DECLARE newEstado VARCHAR(15);
	
	SELECT estado
	INTO oldEstado
	FROM encomiendas
	WHERE id = encomienda;

	CASE oldEstado
	
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
	
	UPDATE encomiendas
	SET estado = newEstado
	WHERE id = encomienda;
	
END;