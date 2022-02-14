const db = require("../db");

// Buscar todas
const findAll = async () => {
  const query = `
    SELECT *
    FROM vehiculos
  `;

  const rows = await db.query(query);

  return rows[0];
};
  
// Buscar por id
const findById = async (id) => {
  const query = `
    SELECT *
    FROM vehiculos
    WHERE id = ?
  `;

  const params = [id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

// Buscar por transportista
const findByTransportistaId = async (transportistaId) => {
  const query = `
    SELECT *
    FROM vehiculos
    WHERE id = ?
  `;

  const params = [transportistaId];

  const rows = await db.query(query, params);

  // if (typeof rows[0][0] === "undefined")
  //   throw "not-found";

  return rows[0];
};

// Crear nueva
const create = async (vehiculo) => {
  const query = `
    CALL sp_agregar_vehiculo(?, ?, ?, ?, ?, ?)
  `;

  const params = [
    vehiculo.id,
    vehiculo.transportista_id,
    vehiculo.modelo,
    vehiculo.marca,
    vehiculo.color,
    vehiculo.tipo
  ];

  const row = await db.query(query, params);

  return row[0][0].shift();
};

// Actualizar
const update = async (vehiculo) => {
  const query = `
    UPDATE vehiculos
    SET
    modelo = ?,
    marca = ?,
    color = ?,
    tipo = ?
    WHERE id = ?
  `;

  const params = [
    vehiculo.modelo, 
    vehiculo.marca, 
    vehiculo.color, 
    vehiculo.tipo,
    vehiculo.id
  ];

  await db.query(query, params);
};

// Eliminar
const deleteVehiculo = async (id) => {
  const query = `
    DELETE FROM vehiculos
    WHERE id = ?
  `;

  const params = [id];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";
};

  module.exports = { findAll, findById, create, findByTransportistaId, update };
  module.exports.delete = deleteVehiculo;