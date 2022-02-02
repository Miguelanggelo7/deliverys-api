const db = require("../db");

// Obtener todos los clientes
const findAll = async () => {
  const query = `
    SELECT *
    FROM clientes
  `;

  const rows = await db.query(query);
  
  return rows[0];
};

// Obtener cliente por su cédula
const findById =  async (id) => {
  const query = `
    SELECT *
    FROM clientes
    WHERE id = ?
  `;

  const params = [id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

const create = async (cliente) => {
  const query = `
    INSERT INTO clientes
    (id, email, password, saldo, nombre, apellido, telefono, alt_telefono, direccion_id)
    VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?) 
    RETURNING *
  `;

  const params = [
    cliente.id,
    cliente.email,
    cliente.password,
    cliente.saldo,
    cliente.nombre,
    cliente.apellido,
    cliente.telefono,
    cliente.alt_telefono,
    cliente.direccion_id,
  ];

  const row = await db.query(query, params);

  return row;
};

const update = async (id, cliente) => {
  const query = `
    UPDATE clientes
    SET 
      id = ?, 
      email = ?, 
      password = ?, 
      saldo = ?, 
      nombre = ?, 
      apellido = ?, 
      telefono = ?, 
      alt_telefono = ?, 
      direccion_id = ?
    WHERE id = ? 
  `;

  const params = [
    cliente.id,
    cliente.email,
    cliente.password,
    cliente.saldo,
    cliente.nombre,
    cliente.apellido,
    cliente.telefono,
    cliente.alt_telefono,
    cliente.direccion_id,
    id
  ];

  await db.query(query, params);
};

const deleteCliente = async (id) => {
  const query = `
    DELETE FROM clientes
    WHERE id = ?
  `;

  const params = [id];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";
};

module.exports = {
  findAll,
  findById,
  create,
  update,
};

module.exports.delete = deleteCliente;