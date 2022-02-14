DROP PROCEDURE IF EXISTS sp_aceptar_recorrido;

CREATE PROCEDURE sp_aceptar_recorrido(
    _encomienda_id VARCHAR(7),
    _recorrido_id INT(10),
    _transportista_id VARCHAR(9),
    _nucleo_des_id INT(10)
)
BEGIN

    IF (
        SELECT estado <> 'abierto'
        FROM recorridos
        WHERE encomienda_id = _encomienda_id
        AND id = _recorrido_id
    )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_aceptar_recorrido) Error: el recorrido no esta disponible';
    END IF;

    IF !(
        SELECT curso_aprobado
        FROM transportistas
        WHERE id =  _transportista_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sp_aceptar_recorrido) Error: el transportista no ha aprobado el curso';
    END IF;
    
    UPDATE recorridos
        SET transportista_id = _transportista_id,
            nucleo_des_id = _nucleo_des_id,
            estado = 'cerrado'
        WHERE encomienda_id = _encomienda_id
        AND id = _recorrido_id;
    
    IF (
        SELECT estado
        FROM encomiendas
        WHERE id = _encomienda_id
    ) = 'en espera'
    THEN
        CALL sp_update_estado(_encomienda_id, _transportista_id, NULL);
    END IF;
END;