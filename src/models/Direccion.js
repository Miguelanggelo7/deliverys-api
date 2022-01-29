const db = require("../db");

// Buscar todas las direcciones
const findAll = () => {
  const query = `
    SELECT *
    FROM direcciones
  `;

  return new Promise((resolve, reject) => {
    db.query(query, (err, rows) => {
      if (err) return reject(err);
      resolve(rows);
    });
  });
};
  
// Buscar por id
const findById = async (id) => {
  const query = `
      SELECT *
      FROM "direcciones" 
      WHERE "id" = $1
  `;

  const params = [id];

  const { rows } = await db.query(query, params);
  return rows[0];
};

// Crear nueva direccion
const create = async (id) => {
  const query = `
      INSERT INTO "direcciones"
      ("id", "id_pais", "estado", "ciudad", "parroquia")
      VALUES($1, $2, $3, $4, $5)
      RETURNING *
  `;

  const params = [
      direccion.id,
      direccion.id_pais,
      direccion.estado,
      direccion.ciudad,
      direccion.parroquia,
  ];

  const { rows } = await db.query(query, params);

  return rows[0];
};

// Actualizar una direccion
const update = async (id, direccion) => {
  const query = `
      UPDATE "direcciones"
      SET "id" = $1,
      "id_pais" = $2,
      "estado" = $3,
      "ciudad" = $4,
      "parroquia" = $5
      WHERE "id" = $6
      RETURNING *
  `;

  const params = [
      direccion.id,
      direccion.id_pais,
      direccion.estado,
      direccion.ciudad,
      direccion.parroquia,
      id
  ];

  const { rows } = await db.query(query, params);

  return rows[0];
};

// Eliminar una direccion
const deleteDireccion = async (id) => {
  const query = `
      DELETE FROM "direcciones"
      WHERE "id" = $1
  `;

  const params = [id];

  await db.query(query, params);
};

  module.exports = { findAll, findById, create, update };
  module.exports.delete = deleteDireccion;