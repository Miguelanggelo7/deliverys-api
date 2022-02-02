const res = require("express/lib/response");
const db = require("../db");

// Buscar todos
const findAll = async () => {
  const query = `
    SELECT *
    FROM paises
  `;

  const rows = await db.query(query);

  return rows[0];
};
  
// Buscar por id
const findById = async (id) => {
  const query = `
    SELECT *
    FROM paises
    WHERE id = ?
  `;

  const params = [id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

// Crear nuevo 
const create = async (paises) => {
  const query = `
    INSERT INTO paises
    (pais)
    VALUES(?)
    RETURNING *
  `;

  const params = [
    paises.pais
  ];

  const row = await db.query(query, params);

  return row[0][0];
};

// Actualizar 
const update = async (id, paises) => {
  const query = `
    UPDATE paises
    SET
    pais = ?
    WHERE id = ?
  `;

  const params = [
    paises.pais,
    id
  ];

  await db.query(query, params);
};

// Eliminar
const deletePais = async (id) => {
  const query = `
    DELETE FROM paises
    WHERE id = ?
  `;

  const params = [id];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";
};

  module.exports = { findAll, findById, create, update };
  module.exports.delete = deletePais;