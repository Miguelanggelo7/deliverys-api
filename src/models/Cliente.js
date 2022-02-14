const db = require('../db');


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

const findByEncomienda = async (encomienda) => {

  const query = `
    SELECT *
    FROM vw_clientes_for_transportistas
    WHERE encomienda = ?
  `;

  const params = [encomienda];

  const rows = await db.query(query, params);

  if (typeof rows[0] === "undefined")
    throw "not-found";


  return rows[0];
}

const create = async (cliente) => {
  const query = `
    INSERT INTO clientes
    (id, email, password, nombre, apellido, telefono, alt_telefono, direccion_id)
    VALUES(?, ?, ?, ?, ?, ?, ?, ?)
  `;

  const params = [
    cliente.id,
    cliente.email,
    cliente.password,
    cliente.nombre,
    cliente.apellido,
    cliente.telefono,
    cliente.alt_telefono,
    cliente.direccion_id,
  ];

  await db.query(query, params);

  return cliente.id;
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

const login = async (email, password) => {
  
  const query = `
    SELECT id, password = ? as is_password_correct
    FROM clientes
    WHERE email = ?
  `
  const params = [password, email];
  const response = await db.query(query, params);

  if (response[0].affectedRows === 0){
    throw "not-found";
  }

  return {
    is_password_correct: response[0][0].is_password_correct === 1,
    id: response[0][0].id
  };
  
}

const recargarSaldo = async (id, monto) => {
  const query = `
    SELECT sf_recargar_saldo_cliente(?,?) as saldo
  `
  const params = [id, monto];
  const response = await db.query(query, params);
  console.log(response);
  if (!response[0][0].saldo){
    throw "not-found";
  }

  return response[0][0].saldo;
}

module.exports = {
  findAll,
  findById,
  create,
  update,
  login,
  recargarSaldo,
  findByEncomienda
};

module.exports.delete = deleteCliente;