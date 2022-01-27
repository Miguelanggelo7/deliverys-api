const db = require("../db");

const findAll = () => {
  const query = `
    SELECT *
    FROM clientes
  `;

  return new Promise((resolve, reject) => {
    db.query(query, (err, rows) => {
      if (err) return reject(err);
      resolve(rows);
    });
  });
};

module.exports = {
  findAll
}