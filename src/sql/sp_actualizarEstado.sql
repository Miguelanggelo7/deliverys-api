DROP PROCEDURE IF EXISTS sp_actualizarEstado;

CREATE PROCEDURE sp_actualizarEstado(
	encomienda VARCHAR(7)
)
BEGIN
	DECLARE oldEstado VARCHAR(15);
	DECLARE newEstado VARCHAR(15);
	
	SELECT estado
	INTO oldEstado
	FROM encomiendas
	WHERE id = encomienda;
	
	IF oldEstado = 'en espera' THEN
	
		SET newEstado = 'en progreso';
		
	ELSEIF oldEstado = 'en custodia'  THEN
	
		SET newEstado = 'en progreso';
		
	ELSEIF oldEstado = 'en progreso'  THEN
	
		SET newEstado = 'culminada';
		
	ELSE 
	
		SET newEstado = oldEstado;
		
	END IF;
	
	UPDATE encomiendas
	SET estado = newEstado
	WHERE id = encomienda;
	
END;