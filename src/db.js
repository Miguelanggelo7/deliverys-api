const mysql = require("mysql2/promise");

const db = mysql.createPool({
  connectionLimit: 5,
  host: process.env.HOST || "deliverys-api-server.mysql.database.azure.com",
  user: process.env.USER || "deliverys_api_server",
  password: process.env.PASSWORD || "Password123",
  database: process.env.DB || "deliverys_api_db",
});

module.exports = db;