DROP PROCEDURE IF EXISTS sp_terminar_recorrido;

CREATE PROCEDURE sp_terminar_recorrido(
    _encomienda_id VARCHAR(7),
    _recorrido_id INT(10)
)
BEGIN
    DECLARE _transportista_id VARCHAR(9);
    DECLARE is_same_destiny int;
    DECLARE newOrigin int(10);
    DECLARE newDestiny int(10);

    IF (
        SELECT estado = 'abierto' OR estado = 'culminado'
        FROM recorridos
        WHERE encomienda_id = _encomienda_id
        AND id = _recorrido_id
    )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_terminar_recorrido) Error: el recorrido no se pude terminar';
    END IF;

    UPDATE recorridos
        SET estado = 'culminado'
        WHERE encomienda_id = _encomienda_id
        AND id = _recorrido_id;

    SELECT e.nucleo_rec_id = r.nucleo_des_id
        INTO is_same_destiny
        FROM encomiendas e
        INNER JOIN recorridos r ON r.encomienda_id = e.id
            AND r.id = _recorrido_id
        WHERE e.id = _encomienda_id;
    
    -- Si el destino de la encomienda es igual al destino del recorrido
    IF is_same_destiny THEN

        SELECT transportista_id
            INTO _transportista_id
            FROM recorridos
            WHERE encomienda_id = _encomienda_id
            AND id = (
                SELECT MAX(id) 
                FROM recorridos
                WHERE encomienda_id = _encomienda_id
            );

        CALL sp_update_estado(_encomienda_id, _transportista_id, NULL);

    ELSE
        SELECT nucleo_des_id
        INTO newOrigin
        FROM recorridos
        WHERE encomienda_id = _encomienda_id
        AND id = _recorrido_id;

        SELECT nucleo_rec_id
        INTO newDestiny
        FROM encomiendas
        WHERE id = _encomienda_id;

        INSERT INTO recorridos (id, encomienda_id, nucleo_org_id, nucleo_des_id)
            VALUES (_recorrido_id + 1, _encomienda_id, newOrigin, newDestiny);
    END IF;
END;