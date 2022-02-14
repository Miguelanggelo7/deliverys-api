
DROP FUNCTION IF EXISTS sf_calcular_costo_encomienda;

CREATE FUNCTION sf_calcular_costo_encomienda(
    _id VARCHAR(7)
) RETURNS float(255,2)
NOT DETERMINISTIC
BEGIN

    DECLARE total FLOAT (255,2);
	
	SELECT SUM(sf_calcular_costo_paquete(p.id))
	INTO total
	FROM encomiendas e
	LEFT JOIN paquetes p ON p.encomienda_id = e.id
	WHERE e.id = _id;
	
	RETURN total;

END;

