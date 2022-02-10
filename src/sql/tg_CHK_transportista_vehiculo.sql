DROP TRIGGER IF EXISTS tg_CHK_transportista_vehiculo;

CREATE TRIGGER tg_CHK_vehiculo_id
	BEFORE UPDATE
	ON encomiendas FOR EACH ROW
BEGIN
	IF !(OLD.vehiculo_id <=> NEW.vehiculo_id)
		AND !(NEW.vehiculo_id <=> NULL)
		AND !((SELECT transportista_id
				FROM vehiculos
				WHERE id = NEW.vehiculo_id) <=> OLD.transportista_id)
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: el transportista es NULL o el vehiculo no pertenece al transportista';
    END IF;
END;