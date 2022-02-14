DROP PROCEDURE IF EXISTS sp_update_estado;

CREATE PROCEDURE sp_update_estado(
	encomienda VARCHAR(7),
	transportista VARCHAR(9),
	newEstado VARCHAR(15)
)
BEGIN

	DECLARE oldEstado VARCHAR(15);

	DECLARE _tipo VARCHAR(15);

	SELECT tipo
	INTO _tipo
	FROM encomiendas
	WHERE id = encomienda;
	
	IF transportista <=> NULL
		OR encomienda <=> NULL
		OR (
			_tipo = 'normal'
			AND transportista <> (
				SELECT transportista_id
				FROM encomiendas
				WHERE id = encomienda
			)
		)
		OR (
			_tipo = 'extendida'
			AND transportista NOT IN (
				SELECT transportista_id
				FROM recorridos
				WHERE encomienda_id = encomienda
				AND id = (
					SELECT MAX(id) 
					FROM recorridos
					WHERE encomienda_id = encomienda
            	)
			)
		)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_update_estado) Error: el transportista o encomienda ingresada no es valida';
	
	END IF;

	
	IF (newEstado <=> NULL) THEN
	
		SELECT estado
		INTO oldEstado
		FROM encomiendas
		WHERE id = encomienda;

		IF oldEstado <=> NULL THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = '(sp_update_estado) Error: la encomienda no ha sido iniciada, su estado no se puede actualizar';
		END IF;

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

				IF (
					SELECT tipo
					FROM encomiendas
					WHERE id = encomienda
				) = 'normal'
				THEN
					CALL sp_pagar_encomienda_transportista(encomienda);
				ELSE
					CALL sp_pagar_encomienda_extendida_transportistas(encomienda);
				END IF;

				UPDATE encomiendas
				SET precio = sf_calcular_costo_encomienda(encomienda)
				WHERE id = encomienda;

				UPDATE paquetes
				SET precio = sf_calcular_costo_paquete(id)
				WHERE encomienda_id = encomienda;

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