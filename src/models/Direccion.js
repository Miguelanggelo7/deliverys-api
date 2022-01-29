const db = require("../db");

// Buscar todas las direcciones
const findAll = async () => {
  const query = `
    SELECT *
    FROM direcciones
  `;

  const rows = await db.query(query);

  return rows[0];
};
  
// Buscar por id
const findById = async (id) => {
  const query = `
      SELECT *
      FROM direcciones
      WHERE id = ?
  `;

  const params = [id];

  const rows = await db.query(query, params);

  return rows[0][0];
};

// Crear nueva direccion
const create = async (id) => {
  const query = `
      INSERT INTO direcciones
      (id, id_pais, estado, ciudad, parroquia)
      VALUES(?, ?, ?, ?, ?)
  `;

  const params = [
      direccion.id,
      direccion.id_pais,
      direccion.estado,
      direccion.ciudad,
      direccion.parroquia,
  ];

  await db.query(query, params);
};

// Actualizar una direccion
const update = async (id, direccion) => {
  const query = `
      UPDATE direcciones
      SET id = ?,
      id_pais = ?,
      estado = ?,
      ciudad = ?,
      parroquia = ?
      WHERE id = ?
  `;

  const params = [
      direccion.id,
      direccion.id_pais,
      direccion.estado,
      direccion.ciudad,
      direccion.parroquia,
      id
  ];

  await db.query(query, params);
};

// Eliminar una direccion
const deleteDireccion = async (id) => {
  const query = `
      DELETE FROM direcciones
      WHERE id = ?
  `;

  const params = [id];

  await db.query(query, params);
};

  module.exports = { findAll, findById, create, update };
  module.exports.delete = deleteDireccion;