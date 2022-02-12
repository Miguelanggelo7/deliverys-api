const db = require("../db");

// Buscar todas
const findAll = async () => {
  const query = `
    SELECT *
    FROM articulos
  `;

  const rows = await db.query(query);

  return rows[0];
};

// Buscar por id
const findById = async (idPaquete, idArticulo) => {
  const query = `
    SELECT *
    FROM articulos
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
    FROM articulos
    WHERE articulo_id = ? 
    AND paquete_id = ?
  `;

  const params = [paqueteId];

  const rows = await db.query(query, params);

  return rows[0];
};

// Crear nueva
const create = async (articulos) => {
  const query = `
    INSERT INTO articulos
    (articulo_id, paquete_id, cantidad)
    VALUES(?, ?, ?)
    RETURNING *
  `;

  const params = [
    articulos.articuloId, 
    articulos.paqueteId,
    articulos.cantidad
  ];

  const row = await db.query(query, params);

  return row;
};

// Actualizar
const update = async (idPaquete, idArticulo, articulos) => {
  const query = `
    UPDATE articulos
    SET
    paquete_id = ?,
    articulo_id = ?,
    cantidad = ?
    WHERE paquete_id = ?
    AND articulo_id = ? 
  `;

  const params = [
    articulos.idPaquete, 
    articulos.idArticulo,
    articulos.cantidad,
    idPaquete,
    idArticulo
  ];

  await db.query(query, params);
};

// Eliminar
const deleteArticulo = async (paqueteId, articuloId) => {
  const query = `
    DELETE FROM articulos
    WHERE paquete_id = ?
    AND articulo_id = ?
  `;

  const params = [paqueteId, articuloId];

  await db.query(query, params);
};

  module.exports = { findAll, findById, create, update, findByPaqueteId  };
  module.exports.delete = deleteArticulo;