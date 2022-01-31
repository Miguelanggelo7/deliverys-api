const db = require("../db");

// Buscar todas
const findAll = async () => {
  const query = `
    SELECT *
    FROM categorias
  `;

  const rows = await db.query(query);

  return rows[0];
};
  
// Buscar por id
const findById = async (id) => {
  const query = `
    SELECT *
    FROM categorias
    WHERE id = ?
  `;

  const params = [id];

  const rows = await db.query(query, params);

  return rows[0][0];
};

// Crear nueva
const create = async (categorias) => {
  const query = `
    INSERT INTO categorias
    (id, peso_min, precio, dimension_min, fragilidad)
    VALUES(?, ?, ?, ?, ?)
  `;

  const params = [
    categorias.id,
    categorias.peso_min,
    categorias.precio,
    categorias.dimension_min,
    categorias.fragilidad
  ];

  await db.query(query, params);
};

// Actualizar
const update = async (id, categoria) => {
  const query = `
    UPDATE categorias
    SET
    id = ?,
    peso_min = ?,
    precio = ?,
    dimension_min = ?,
    fragilidad = ?,
    WHERE id = ?
  `;

  const params = [
    direccion.id,
    categoria.peso_min,
    categoria.precio,
    categoria.dimension_min,
    categoria.fragilidad,
    id
  ];

  await db.query(query, params);
};

// Eliminar
const deleteCategoria = async (id) => {
  const query = `
    DELETE FROM categorias
    WHERE id = ?
  `;

  const params = [id];

  await db.query(query, params);
};

  module.exports = { findAll, findById, create, update  };
  module.exports.delete = deleteCategoria;