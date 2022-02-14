DROP VIEW IF EXISTS vw_transportistas_for_clientes;

CREATE VIEW vw_transportistas_for_clientes AS
SELECT e.id as encomienda, t.id, t.email, t.nombre, t.apellido, t.telefono, t.alt_telefono, t.direccion_id,
    t.nucleo_id
FROM transportistas t
INNER JOIN encomiendas e ON e.transportista_id = t.id 

UNION

SELECT r.encomienda_id as encomienda, t.id, t.email, t.nombre, t.apellido, t.telefono, t.alt_telefono, t.direccion_id,
    t.nucleo_id
FROM transportistas t
INNER JOIN recorridos r ON r.transportista_id = t.id;