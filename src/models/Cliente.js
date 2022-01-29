const db = require("../db");

// Obtener todos los clientes
const findAll = () => {
  const query = `
    SELECT *
    FROM clientes
  `;

  return db.query(query);
};

// Obtener cliente por su cédula
const findById =  (id) => {
  const query = `
    SELECT *
    FROM clientes
    WHERE id = ?
  `;

  const params = [id];

  return db.query(query, params);
};

const create = (cliente) => {
  const query = `
    INSERT INTO clientes
    (id, email, password, saldo, nombre, apellido, telefono, alt_telefono, direccion_id)
    VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?) 
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

  return db.query(query, params);
};

const update = (id, cliente) => {
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

  return db.query(query, params);
};

const deleteCliente = (id) => {
  const query = `
    DELETE FROM clientes
    WHERE id = ?
  `;

  const params = [id];

  return db.query(query, params);
};

module.exports = {
  findAll,
  findById,
  create,
  update,
  deleteCliente
};