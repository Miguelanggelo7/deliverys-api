DROP FUNCTION IF EXISTS sf_calcular_costo_paquete;

CREATE FUNCTION sf_calcular_costo_paquete(
    id_paquete INT(10)
) RETURNS decimal(14,3)

BEGIN

    RETURN (
	SELECT (p.alto*p.ancho*p.largo)/5000 * n.precio_por_kg
	FROM paquetes p, nucleos n, encomiendas e
	WHERE id_paquete = p.id AND p.encomienda_id = e.id AND e.nucleo_id = n.id
    )

END;