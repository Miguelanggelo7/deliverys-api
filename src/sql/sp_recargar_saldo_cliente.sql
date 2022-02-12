DROP PROCEDURE IF EXISTS sp_recargar_saldo_cliente;

CREATE PROCEDURE sp_recargar_saldo_cliente(
	IN id_cliente VARCHAR(9), IN monto_recarga DECIMAL(14,3))
)
BEGIN
	
	UPDATE clientes
        SET saldo = saldo + monto_recarga
        WHERE id_cliente = id;
            
END;