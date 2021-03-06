const db = require('../db');

// Buscar todas
const findAll = async () => {
  const query = `
    SELECT *
    FROM encomiendas
  `;

  const rows = await db.query(query);

  return rows[0];
};

// Buscar por id
const findById = async (id) => {
  const query = `
    SELECT id, tipo, fh_salida, fh_llegada, estado, nucleo_id, nucleo_rec_id,
    transportista_id, vehiculo_id, cliente_env_id, cliente_rec_id, 
    sf_calcular_costo_encomienda(?) as precio
    FROM encomiendas
    WHERE id = ?
  `;

  const params = [id,id];

  const rows = await db.query(query, params);

  if (typeof rows[0][0] === "undefined")
    throw "not-found";

  return rows[0][0];
};

// Crear nueva encomienda junto con sus paquetes
const create = async (paquetes, encomienda) => {
  const connection = await db.getConnection();
  try {
    
    await connection.beginTransaction();

    const query = `
      INSERT INTO encomiendas (tipo, nucleo_id, nucleo_rec_id,
        transportista_id, vehiculo_id, cliente_env_id, cliente_rec_id)
      VALUES ( ?, ?, ?, ?, ?, ?, ?);

      SELECT MAX(id) as id FROM encomiendas;
    `;

    const params = [
      encomienda.tipo,
      encomienda.nucleo_id,
      encomienda.nucleo_rec_id,
      encomienda.transportista_id,
      encomienda.vehiculo_id,
      encomienda.cliente_env_id,
      encomienda.cliente_rec_id,
    ];

    const [newData] = await connection.query(query, params); 
    const encomiendaId = newData[1][0].id;
    for (const item of paquetes) {
      const query1 = `
        INSERT INTO paquetes (peso, alto, ancho, largo, fragil, encomienda_id)
        VALUES (?, ?, ?, ?, ?, ?)
      `;

      const params1 = [
        item.peso,
        item.alto,
        item.ancho,
        item.largo,
        item.fragil,
        encomiendaId
      ];

      const promises = [];

      

      const arr = await connection.query(query1, params1);

      const paquete = {};
      paquete.id = arr[0].insertId;
      
      promises.push(
        Promise.all(
          item.articulos.map(art => {
            const query2 = `
              INSERT INTO articulos (paquete_id, descripcion, cantidad)
              VALUES (?, ?, ?)
            `;

            const params2 = [
              paquete.id,
              art.descripcion,
              art.cantidad
            ];

            return connection.query(query2, params2);
          })
        )
      );

      await Promise.all(promises);
    };

    const [newEncomienda] = await connection.query(`
      SELECT id, tipo, fh_salida, fh_llegada, estado, nucleo_id, nucleo_rec_id,
      transportista_id, vehiculo_id, cliente_env_id, cliente_rec_id, 
      sf_calcular_costo_encomienda(?) as precio
      FROM encomiendas
      WHERE id = ? 
    `, [encomiendaId,encomiendaId]);

    await connection.commit();
    return newEncomienda[0];

  } catch (err) {
    await connection.rollback();
    console.log(err)
    throw err;

  } finally {
    connection.release();
  }
};

// Actualizar
const update = async (id, encomiendas) => {
  const query = `
    UPDATE encomiendas
    SET
    id = ?,
    fh_salida = ?,
    fh_llegada = ?,
    estado = ?,
    tipo = ?,
    cliente_env_id = ?,
    cliente_rec_id = ?,
    nucleo_lcl_id = ?,
    nucleo_ext_id = ?,
    transp_lcl_id = ?,
    transp_ext_id = ?,
    precio = ?
    WHERE id = ?
  `;

  const params = [
    encomiendas.id,
    encomiendas.fh_salida,
    encomiendas.fh_llegada,
    encomiendas.estado,
    encomiendas.tipo,
    encomiendas.cliente_env_id,
    encomiendas.cliente_rec_id,
    encomiendas.nucleo_lcl_id,
    encomiendas.nucleo_ext_id,
    encomiendas.transp_lcl_id,
    encomiendas.transp_ext_id,
    encomiendas.precio,
    id
  ];

  await db.query(query, params);
};

//Actualizar Estado Encomienda
const updateEstado = async (encomienda_id, transportista_id, estado) => {
  const query = `CALL sp_update_estado(?,?,?)`;

  const params = [encomienda_id, transportista_id, estado];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";

}

// Eliminar
const deleteEncomiendas = async (id) => {
  const query = `
    DELETE FROM encomiendas
    WHERE id = ?
  `;

  const params = [id];

  const response = await db.query(query, params);

  if (response[0].affectedRows === 0)
    throw "not-found";
};

const solicitar = async (id) => {
  const query = `CALL sp_solicitar_encomienda(?)`;

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
    updateEstado,
    solicitar
  };
  module.exports.delete = deleteEncomiendas;