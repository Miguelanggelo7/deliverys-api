const db = require("../db");

// Buscar todas
const findAll = async () => {
  const query = `
    SELECT *
    FROM contiene
  `;

  const rows = await db.query(query);

  return rows[0];
};

// Buscar por id
const findById = async (idPaquete, idArticulo) => {
  const query = `
    SELECT *
    FROM contiene
    WHERE paquete_id = ?
    AND articulo_id = ? 
  `;

  const params = [idPaquete, idArticulo];

  const rows = await db.query(query, params);

  return rows[0][0];
};

// Buscar los articulos de un paquete
const findByPaqueteId = async (paqueteId) => {
  const query = `
    SELECT descripcion
    FROM contiene
    WHERE articulo_id = ? 
    AND paquete_id = ?
  `;

  const params = [idArticulo, idPaquete];

  const rows = await db.query(query, params);

  return rows[0];
};

// Crear nueva
const create = async (contiene) => {
  const query = `
    INSERT INTO contiene
    (articulo_id, paquete_id, cantidad)
    VALUES(?, ?, ?)
    RETURNING *
  `;

  const params = [
    contiene.articuloId, 
    contiene.paqueteId,
    contiene.cantidad
  ];

  const row = await db.query(query, params);

  return row;
};

// Actualizar
const update = async (idPaquete, idArticulo, contiene) => {
  const query = `
    UPDATE contiene
    SET
    paquete_id = ?,
    articulo_id = ?,
    cantidad = ?
    WHERE paquete_id = ?
    AND articulo_id = ? 
  `;

  const params = [
    contiene.idPaquete, 
    contiene.idArticulo,
    contiene.cantidad,
    idPaquete,
    idArticulo
  ];

  await db.query(query, params);
};

// Eliminar
const deleteContiene = async (paqueteId, articuloId) => {
  const query = `
    DELETE FROM contiene
    WHERE paquete_id = ?
    AND articulo_id = ?
  `;

  const params = [paqueteId, articuloId];

  await db.query(query, params);
};

  module.exports = { findAll, findById, create, update  };
  module.exports.delete = deleteContiene;