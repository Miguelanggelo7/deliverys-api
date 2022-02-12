DROP FUNCTION IF EXISTS sf_consultar_saldo_cliente;

CREATE FUNCTION sf_consultar_saldo_cliente;
    id_cliente VARCHAR(9)
) RETURNS decimal(14,3)
BEGIN

    RETURN( 
        SELECT saldo
        FROM clientes
        WHERE id_cliente = id
    )

END;