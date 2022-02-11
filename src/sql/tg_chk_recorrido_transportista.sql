DROP TRIGGER IF EXISTS tg_chk_recorrido_transportista;

CREATE TRIGGER tg_chk_recorrido_transportista
	BEFORE UPDATE
	ON recorridos FOR EACH ROW
BEGIN
	IF !(OLD.transportista_id <=> NEW.transportista_id)
		AND (
			SELECT nucleo_id
			FROM transportistas
			WHERE id = NEW.transportista_id
		) <> NEW.nucleo_org_id
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(tg_chk_recorrido_transportista) Error: el transportista 
			no pertenece al nucleo de origen del recorrido';
    END IF;
END;