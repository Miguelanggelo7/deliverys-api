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
			
		WHEN 'en custodia'  THEN
		
			SET newEstado = 'en progreso';
			
		WHEN 'en progreso'  THEN
		
			SET newEstado = 'culminada';
			
		ELSE 
		
			SET newEstado = oldEstado;
			
	END CASE;
	
	UPDATE encomiendas
	SET estado = newEstado
	WHERE id = encomienda;
	
END;