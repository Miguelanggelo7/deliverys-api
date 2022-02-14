DROP FUNCTION IF EXISTS sf_retirar_saldo_transportista;
CREATE FUNCTION `sf_retirar_saldo_transportista`(
	_id_transportista VARCHAR(9), monto_retiro DECIMAL(14,3)
) RETURNS DECIMAL(14,3)
NOT DETERMINISTIC
BEGIN

    DECLARE saldo_final DECIMAL(14,3);

	IF _id_transportista <=> NULL ||  monto_retiro <=> NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sf_retirar_saldo_transportista) Error: el monto de retiro o el id_transportista es NULL';
    END IF;

    IF (
        SELECT saldo < monto_retiro
        FROM transportistas
        WHERE id = _id_transportista
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '(sf_retirar_saldo_transportista) Error: el transportista no posee saldo suficiente';
    END IF;
	
	UPDATE transportistas
        SET saldo = saldo - monto_retiro
        WHERE _id_transportista = id;

    SELECT saldo
        INTO saldo_final
        FROM transportistas
        WHERE id = _id_transportista;

    RETURN saldo_final;
END