DROP VIEW IF EXISTS vw_clientes_for_transportistas;

CREATE VIEW vw_clientes_for_transportistas AS
SELECT e.id as encomienda, c.id, c.email, c.nombre, c.apellido, c.telefono, c.alt_telefono, c.direccion_id,
    (
        CASE c.id WHEN e.cliente_env_id THEN
            'origen'
        ELSE
            'destino'
        END
    ) AS tipo
FROM clientes c
INNER JOIN encomiendas e ON c.id = e.cliente_env_id
    OR c.id = e.cliente_rec_id;