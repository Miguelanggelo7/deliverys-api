DROP TRIGGER IF EXISTS tg_after_encomiendas_insert_publicar_recorrido;

CREATE TRIGGER tg_after_encomiendas_insert_publicar_recorrido
    AFTER INSERT
    ON encomiendas FOR EACH ROW
BEGIN
    IF NEW.tipo = 'extendida' THEN
        INSERT INTO recorridos (id, encomienda_id, nucleo_org_id, nucleo_des_id)
            VALUES (0, NEW.id, NEW.nucleo_id, NEW.nucleo_rec_id);
                
    END IF;
END;