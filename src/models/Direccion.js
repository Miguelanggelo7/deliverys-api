const res = require("express/lib/response");
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

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

// Crear nueva direccion
const create = async (direccion) => {
  const query = `
    INSERT INTO direcciones
    (id_pais, estado, ciudad, parroquia)
    VALUES(?, ?, ?, ?)
    RETURNING *
  `;

  const params = [
    direccion.id_pais,
    direccion.estado,
    direccion.ciudad,
    direccion.parroquia,
  ];

  const row = await db.query(query, params);

  return row[0][0];
};

// Actualizar una direccion
const update = async (id, direccion) => {
  const query = `
    UPDATE direcciones
    SET
    id_pais = ?,
    estado = ?,
    ciudad = ?,
    parroquia = ?
    WHERE id = ?
  `;

  const params = [
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

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";
};

  module.exports = { findAll, findById, create, update };
  module.exports.delete = deleteDireccion;