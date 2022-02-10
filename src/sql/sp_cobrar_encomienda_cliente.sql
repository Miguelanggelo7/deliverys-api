DROP PROCEDURE IF EXISTS sp_cobrar_encomienda_cliente;

CREATE PROCEDURE sp_cobrar_encomienda_cliente(
	encomienda VARCHAR(7)
)
BEGIN

	UPDATE clientes c
	SET c.saldo = c.saldo - sf_calcular_costo_encomienda(encomienda)
	WHERE id = (SELECT cliente_env_id
					FROM encomiendas
					WHERE id = encomienda);
END;