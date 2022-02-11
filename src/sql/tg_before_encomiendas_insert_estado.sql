DROP TRIGGER IF EXISTS tg_before_encomiendas_insert_estado;

CREATE TRIGGER tg_before_encomiendas_insert_estado
    BEFORE INSERT
    ON encomiendas FOR EACH ROW
BEGIN
    IF NEW.tipo = 'extendida' THEN
        SET NEW.estado = 'en espera';
                
    END IF;
END;