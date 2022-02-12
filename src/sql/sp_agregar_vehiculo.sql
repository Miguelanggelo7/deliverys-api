DROP FUNCTION IF EXISTS sp_agregar_vehiculo;

CREATE FUNCTION sp_agregar_vehiculo(
  IN id VARCHAR(8),
  IN transportista_id VARCHAR(9),
  IN modelo VARCHAR(20),
  IN marca VARCHAR(13),
  IN color VARCHAR(20),
  IN tipo VARCHAR(15)
)
BEGIN
	IF tipo = "motor" THEN
		SET @licencia = (SELECT licencia FROM transportistas t WHERE t.id = transportista_id);
		IF ISNULL(@licencia) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El transportista no posee licencia registrada, por lo que no se podrá registrar un vehiculo a motor';	
		END IF;
	END IF;

	INSERT INTO vehiculos VALUES(id, transportista_id, modelo, marca, color, tipo);
	SELECT * FROM vehiculos v WHERE v.id = id;
	
END;