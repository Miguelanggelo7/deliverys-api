CREATE TRIGGER tr_after_encomiendas_update_estado
    AFTER UPDATE
	ON encomiendas FOR EACH ROW
BEGIN
	
    IF new.estado = 'culminada' THEN
		BEGIN
	
			DECLARE comision_normal FLOAT (255,2);
			DECLARE comision_vuelo FLOAT (255,2);
			DECLARE pago_normal FLOAT (255,2);
			DECLARE pago_vuelo FLOAT (255,2);
			DECLARE costo_encomienda FLOAT (255,2);
			
			SELECT com_vuelo, com_vehiculo_motor
			INTO comision_vuelo, comision_normal
			FROM nucleos
			WHERE id = new.nucleo_lcl_id;
			
			SET costo_encomienda = sf_calcular_costo_encomienda(old.id);
			SET pago_normal = costo_encomienda*comision_normal;
			SET pago_vuelo = costo_encomienda*comision_vuelo;
		 
			-- Sumar comisiones a los saldos de los transportistas
			
			IF new.tipo = 'vuelo' THEN
				BEGIN
				
					UPDATE transportistas
					SET saldo = saldo + pago_vuelo
					WHERE id = new.transp_lcl_id;
					
					UPDATE transportistas
					SET saldo = saldo + pago_normal
					WHERE id = new.transp_ext_id;

				END;
			ELSE
				UPDATE transportistas
				SET saldo = saldo + pago_normal
				WHERE id = new.transp_lcl_id;
			END IF;
			
			-- sp_restar_saldo_cliente(new.cliente_env_id, costo_encomienda); 
			
		END;
		
	END IF;
		
END