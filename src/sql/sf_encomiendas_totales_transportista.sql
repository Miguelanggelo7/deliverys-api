DROP FUNCTION IF EXISTS sf_encomiendas_totales_transportista;

CREATE FUNCTION sf_encomiendas_totales_transportista(
  IN transportista_id VARCHAR(9)
) RETURNS INT(11)
BEGIN
    RETURN ( 
        SELECT COUNT(*)
        FROM recorridos r
        WHERE r.transportista_id = transportista_id
    );
END;