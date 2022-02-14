DROP TRIGGER IF EXISTS tg_before_encomiendas_insert_id;

CREATE TRIGGER tg_before_encomiendas_insert_id
    BEFORE INSERT
    ON encomiendas FOR EACH ROW
BEGIN
    DECLARE _id VARCHAR(7);

    --Buscar el id mas grande
    SELECT MAX(id)
    INTO _id
    FROM encomiendas;

    --Sumarle 1
    SET _id = HEX(CONV(_id, 16, 10) + 1);

    --Completar con 0's
    WHILE LENGTH(_id) < 7 DO
        SET _id = CONCAT('0', _id);
    END WHILE;
   
    --Asignar como ID
    SET NEW.id = _id;
END;