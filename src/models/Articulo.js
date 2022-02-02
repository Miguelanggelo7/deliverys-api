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
const findById = async (id) => {
  const query = `
    SELECT *
    FROM articulos
    WHERE id = ?
  `;

  const params = [id];

  const rows = await db.query(query, params);

  return rows[0][0];
};

// Crear nueva
const create = async (articulo) => {
  const query = `
    INSERT INTO articulos
    (descripcion)
    VALUES(?)
  `;

  const params = [articulo.descripcion];

  await db.query(query, params);
};

// Actualizar
const update = async (id, articulo) => {
  const query = `
    UPDATE articulos
    SET
    descripcion = ?,
    WHERE id = ?
  `;

  const params = [articulo.descripcion, id];

  await db.query(query, params);
};

// Eliminar
const deleteArticulo = async (id) => {
  const query = `
    DELETE FROM articulos
    WHERE id = ?
  `;

  const params = [id];

  await db.query(query, params);
};

  module.exports = { findAll, findById, create, update  };
  module.exports.delete = deleteArticulo;