const mysql = require("mysql2/promise");

let dbUser = "deliverys_api@deliverys-api-mariadb-server";
let dbPassword = "Password123";

if (process.argv.length > 2) {
  dbUser = process.argv[2] + '@deliverys-api-mariadb-server';
  dbPassword = process.argv[3];
}

const db = mysql.createPool({
  connectionLimit: 5,
  host: process.env.HOST || "deliverys-api-mariadb-server.mariadb.database.azure.com",
  user: process.env.USER || dbUser,
  password: process.env.PASSWORD || dbPassword,
  database: process.env.DB || "deliverys_api_db",
  multipleStatements: true
});

module.exports = db;