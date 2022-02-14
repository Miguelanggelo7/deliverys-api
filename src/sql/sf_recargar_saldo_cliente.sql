DROP FUNCTION IF EXISTS sf_recargar_saldo_cliente;

CREATE FUNCTION sf_recargar_saldo_cliente(
	id_cliente VARCHAR(9), monto_recarga DECIMAL(14,3)
) RETURNS DECIMAL(14,3)
NOT DETERMINISTIC
BEGIN
        DECLARE saldo_final DECIMAL(14,3);

	IF id_cliente <=> NULL || monto_recarga <=> NULL THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = '(sf_recargar_saldo_cliente) Error: monto_recarga o id_cliente es NULL';
        END IF;

	UPDATE clientes
        SET saldo = saldo + monto_recarga
        WHERE id_cliente = id;

        SELECT saldo
        INTO saldo_final
        FROM clientes
        WHERE id_cliente = id;

        RETURN saldo_final;
END;